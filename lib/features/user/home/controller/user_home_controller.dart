import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/services/api_client.dart';
import 'package:protiva502/core/utils/constants/apiendpoint.dart';
import 'package:protiva502/core/utils/constants/icon_path.dart';
import 'package:protiva502/core/utils/logging/logger.dart';
import 'package:protiva502/features/user/home/model/user_banner_model.dart';

class UserHomeController extends GetxController {
  final ApiClient _apiClient = ApiClient();

  // For the banner carousel dots
  var currentBannerIndex = 0.obs;
  final PageController bannerController = PageController();
  final isBannerLoading = true.obs;
  final bannerErrorMessage = ''.obs;
  final banners = <UserBannerModel>[].obs;

  // Mock data for categories
  final List<Map<String, String>> categories = [
    {'name': 'Electrician', 'icon': IconPath.electrician},
    {'name': 'Mechanic', 'icon': IconPath.mechanic},
    {'name': 'Plumber', 'icon': IconPath.plumber},
    {'name': 'Carpenter', 'icon': IconPath.carpenter},
    {'name': 'Automotive', 'icon': IconPath.automotive},
    {'name': 'Cleaner', 'icon': IconPath.cleaner},
    {'name': 'Painter', 'icon': IconPath.painter},
    {'name': 'Technician', 'icon': IconPath.technician},
  ];

  void updateBannerIndex(int index) {
    currentBannerIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    fetchBanners();
  }

  Future<void> fetchBanners() async {
    try {
      isBannerLoading.value = true;
      bannerErrorMessage.value = '';

      final response = await _apiClient.get<dynamic>(
        ApiEndpoints.userBanners,
        options: Options(
          headers: const {'accept': '*/*'},
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      final responseMap = _asMap(response.data) ?? <String, dynamic>{};
      final data = _asMap(responseMap['data']) ?? <String, dynamic>{};
      final bannerList = data['banners'];

      if (response.statusCode != 200 || bannerList is! List) {
        banners.clear();
        bannerErrorMessage.value =
            _extractMessage(response.data) ?? 'Failed to load banners';
        AppLoggerHelper.warning(
          'Failed to fetch banners: ${bannerErrorMessage.value}',
        );
        return;
      }

      final fetchedBanners =
          bannerList
              .whereType<Map>()
              .map(
                (banner) => UserBannerModel.fromJson(
                  banner.map((key, value) => MapEntry(key.toString(), value)),
                ),
              )
              .where((banner) => banner.isActive)
              .toList()
            ..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));

      banners.assignAll(fetchedBanners);
      currentBannerIndex.value = 0;
      AppLoggerHelper.info('Fetched ${fetchedBanners.length} user banners');
    } on DioException catch (error) {
      banners.clear();
      bannerErrorMessage.value =
          _extractMessage(error.response?.data) ??
          error.message ??
          'Failed to load banners';
      AppLoggerHelper.error('Banner fetch failed', error);
    } catch (error) {
      banners.clear();
      bannerErrorMessage.value = 'Failed to load banners';
      AppLoggerHelper.error('Unexpected banner fetch error', error);
    } finally {
      isBannerLoading.value = false;
    }
  }

  String? _extractMessage(dynamic responseData) {
    final responseMap = _asMap(responseData);
    if (responseMap == null) {
      return null;
    }

    final data = _asMap(responseMap['data']);
    final message = data?['message'] ?? responseMap['message'];

    if (message is String && message.trim().isNotEmpty) {
      return message;
    }

    return null;
  }

  Map<String, dynamic>? _asMap(dynamic value) {
    if (value is Map<String, dynamic>) {
      return value;
    }

    if (value is Map) {
      return value.map((key, item) => MapEntry(key.toString(), item));
    }

    return null;
  }

  @override
  void onClose() {
    bannerController.dispose();
    super.onClose();
  }
}
