import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:protiva502/core/services/secure_storage_service.dart';
import 'package:protiva502/core/services/storage_service.dart';
import 'package:protiva502/core/utils/constants/apiendpoint.dart';
import 'package:protiva502/routes/app_routes.dart';

class ApiClient {
  ApiClient._internal() {
    _initializeDio();
  }

  static final ApiClient _instance = ApiClient._internal();

  factory ApiClient() => _instance;

  late final Dio _dio;

  /// Dedicated Dio instance for refresh requests (no interceptors)
  late final Dio _refreshDio;

  /// Shared in-flight refresh future so concurrent 401s wait on the same call.
  Future<_RefreshResult>? _refreshFuture;

  static const String _authRetryAttemptKey = 'authRetryAttempted';

  /// Auth endpoints that should not trigger refresh logic
  static const _authEndpoints = [
    '/auth/login',
    '/auth/register',
    '/auth/refresh',
    '/auth/verify-otp',
    '/auth/resend-otp',
    '/auth/forgot-password',
    '/auth/reset-password',
  ];

  void _initializeDio() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: const {'accept': '*/*', 'Content-Type': 'application/json'},
        validateStatus: (status) =>
            status != null, // Accept all status codes, don't throw
      ),
    );

    // Separate Dio for refresh — no interceptors to avoid recursion
    _refreshDio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: const {'accept': '*/*', 'Content-Type': 'application/json'},
      ),
    );

    // Add interceptor to inject authorization token and handle 401 refresh
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await SecureStorageService.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
            debugPrint('🔐 [API CLIENT] Authorization header added to request');
          } else {
            debugPrint(
              '⚠️ [API CLIENT] No token found, request will be unauthenticated',
            );
          }
          return handler.next(options);
        },
        onResponse: (response, handler) async {
          final statusCode = response.statusCode;
          final requestOptions = response.requestOptions;

          if (statusCode == 401 &&
              !_isAuthEndpoint(requestOptions.path) &&
              !(_wasRetryAttempted(requestOptions))) {
            final refreshResult = await _getOrRefreshAccessToken();

            if (refreshResult.status == _RefreshStatus.success &&
                refreshResult.accessToken != null) {
              requestOptions.headers['Authorization'] =
                  'Bearer ${refreshResult.accessToken}';
              requestOptions.extra[_authRetryAttemptKey] = true;

              try {
                final retriedResponse = await _dio.fetch(requestOptions);

                if (retriedResponse.statusCode == 401) {
                  debugPrint(
                    '❌ [API CLIENT] Retried request still unauthorized, forcing logout',
                  );
                  await _forceLogout();
                }

                return handler.resolve(retriedResponse);
              } on DioException catch (retryError) {
                debugPrint(
                  '❌ [API CLIENT] Retry after refresh failed: ${retryError.message}',
                );

                if (retryError.response?.statusCode == 401) {
                  await _forceLogout();
                }

                return handler.next(response);
              }
            }

            if (refreshResult.status == _RefreshStatus.invalidRefreshToken) {
              debugPrint(
                '❌ [API CLIENT] Refresh token is invalid or expired, forcing logout',
              );
              await _forceLogout();
            }
          }

          return handler.next(response);
        },
        onError: (error, handler) async {
          debugPrint('❌ [API CLIENT] Error: ${error.message}');
          return handler.next(error);
        },
      ),
    );
  }

  /// Checks if the given path is an auth endpoint
  bool _isAuthEndpoint(String path) {
    return _authEndpoints.any((endpoint) => path.contains(endpoint));
  }

  bool _wasRetryAttempted(RequestOptions requestOptions) {
    return requestOptions.extra[_authRetryAttemptKey] == true;
  }

  Future<_RefreshResult> _getOrRefreshAccessToken() {
    final currentRefresh = _refreshFuture;
    if (currentRefresh != null) {
      return currentRefresh;
    }

    final refreshFuture = _performTokenRefresh();
    _refreshFuture = refreshFuture;
    refreshFuture.whenComplete(() {
      if (identical(_refreshFuture, refreshFuture)) {
        _refreshFuture = null;
      }
    });

    return refreshFuture;
  }

  Future<_RefreshResult> _performTokenRefresh() async {
    debugPrint('🔄 [API CLIENT] Attempting token refresh...');

    final refreshToken = await SecureStorageService.getRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      debugPrint('❌ [API CLIENT] No refresh token available');
      return const _RefreshResult.invalidRefreshToken();
    }

    try {
      final response = await _refreshDio.post(
        ApiEndpoints.refreshtoken,
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode != 200) {
        debugPrint('❌ [API CLIENT] Refresh failed: ${response.statusCode}');
        return _classifyRefreshFailure(response.statusCode);
      }

      final responseData = response.data;
      final data = responseData is Map<String, dynamic>
          ? (responseData['data'] is Map<String, dynamic>
                ? responseData['data'] as Map<String, dynamic>
                : responseData)
          : null;

      final newAccessToken = data?['accessToken']?.toString();
      final newRefreshToken = data?['refreshToken']?.toString();

      if (newAccessToken == null || newAccessToken.isEmpty) {
        debugPrint(
          '❌ [API CLIENT] Refresh response missing accessToken. Payload: $responseData',
        );
        return const _RefreshResult.invalidRefreshToken();
      }

      await SecureStorageService.saveToken(newAccessToken);
      if (newRefreshToken != null && newRefreshToken.isNotEmpty) {
        await SecureStorageService.saveRefreshToken(newRefreshToken);
      }

      debugPrint('✅ [API CLIENT] Token refreshed successfully');
      return _RefreshResult.success(newAccessToken);
    } on DioException catch (e) {
      debugPrint('❌ [API CLIENT] Refresh request failed: ${e.message}');
      return _classifyRefreshFailure(e.response?.statusCode);
    } catch (e) {
      debugPrint('❌ [API CLIENT] Unexpected error during refresh: $e');
      return const _RefreshResult.transientFailure();
    }
  }

  _RefreshResult _classifyRefreshFailure(int? statusCode) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return const _RefreshResult.invalidRefreshToken();
    }

    return const _RefreshResult.transientFailure();
  }

  /// Clears all stored data and navigates to the login/onboarding screen
  Future<void> _forceLogout() async {
    debugPrint('🔒 [API CLIENT] Force logout: clearing session data');
    await StorageService.clearAll();
    Get.offAllNamed(AppRoute.getUserLoginScreen());
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.patch<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }
}

enum _RefreshStatus { success, transientFailure, invalidRefreshToken }

class _RefreshResult {
  final _RefreshStatus status;
  final String? accessToken;

  const _RefreshResult._(this.status, this.accessToken);

  const _RefreshResult.success(String token)
    : this._(_RefreshStatus.success, token);

  const _RefreshResult.transientFailure()
    : this._(_RefreshStatus.transientFailure, null);

  const _RefreshResult.invalidRefreshToken()
    : this._(_RefreshStatus.invalidRefreshToken, null);
}
