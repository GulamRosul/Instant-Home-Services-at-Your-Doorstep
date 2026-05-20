import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:protiva502/core/services/api_client.dart';
import 'package:protiva502/core/services/secure_storage_service.dart';
import 'package:protiva502/core/services/storage_service.dart';
import 'package:protiva502/core/utils/constants/apiendpoint.dart';
import 'package:protiva502/features/service_provider/home/model/active_job_model.dart';
import 'package:protiva502/features/service_provider/home/model/recent_booking_model.dart';
import 'package:protiva502/features/service_provider/provider_navber/controller/provider_navbar_controller.dart';
import 'package:protiva502/features/service_provider/wallet/screen/wallet_screen.dart';
import 'package:protiva502/routes/app_routes.dart';

class ProviderHomeController extends GetxController {
  final ApiClient _apiClient = ApiClient();

  // Logic for application limit
  var isLimitReached = true.obs; // Toggle this for testing the UI
  var applicationsCount = 1.obs;
  final int maxApplications = 2;

  // Profile data for the header
  var profileName = ''.obs;
  var profileImage = ''.obs;
  var isProfileLoading = false.obs;

  // Wallet data for the UI
  var isWalletLoading = false.obs;
  var walletErrorMessage = ''.obs;
  var totalEarnings = "0.00".obs;
  var pendingAmount = "0.00".obs;
  var bookingsServed = "0/0".obs;

  // Stats data for the UI
  var isStatsLoading = false.obs;

  var isActiveJobsLoading = false.obs;
  var activeJobsErrorMessage = ''.obs;
  final activeJobs = <ActiveJobModel>[].obs;
  var isRecentBookingsLoading = false.obs;
  var recentBookingsErrorMessage = ''.obs;
  final recentBookings = <RecentBookingModel>[].obs;
  var averageRating = "0".obs;
  var reviewCount = 0.obs;
  var submittedProposals = 10.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfileData();
    fetchProviderWallet();
    fetchActiveJobs();
    fetchRecentBookings();
  }

  @override
  void onReady() {
    super.onReady();
    refreshHomeData();
  }

  Future<void> fetchProfileData() async {
    try {
      isProfileLoading.value = true;
      await StorageService.ensureInitialized();

      profileImage.value = StorageService.getAvatar()?.trim() ?? '';

      final firstName = StorageService.getFirstName()?.trim() ?? '';
      final lastName = StorageService.getLastName()?.trim() ?? '';
      final fullName = '$firstName $lastName'.trim();
      if (fullName.isNotEmpty) {
        profileName.value = fullName;
      }

      final token = await SecureStorageService.getToken();
      if (token == null || token.isEmpty) {
        return;
      }

      final response = await _apiClient.get<dynamic>(
        ApiEndpoints.authMe,
        options: Options(
          headers: {'accept': '*/*', 'Authorization': 'Bearer $token'},
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      debugPrint(
        'Provider profile request => ${ApiEndpoints.baseUrl}${ApiEndpoints.authMe}',
      );
      debugPrint('Provider profile status => ${response.statusCode}');
      const JsonEncoder encoder = JsonEncoder.withIndent('  ');
      debugPrint(
        'Provider profile response => ${encoder.convert(response.data)}',
      );

      if (response.statusCode != 200) {
        return;
      }

      final responseMap = _asMap(response.data) ?? <String, dynamic>{};
      final data = _asMap(responseMap['data']) ?? <String, dynamic>{};

      final fetchedFirstName = (data['firstName'] ?? '').toString().trim();
      final fetchedLastName = (data['lastName'] ?? '').toString().trim();
      final fetchedName = '$fetchedFirstName $fetchedLastName'.trim().isNotEmpty
          ? '$fetchedFirstName $fetchedLastName'.trim()
          : (data['fullName'] ?? '').toString().trim();
      final fetchedAvatar = (data['avatar'] ?? data['profileImage'] ?? '')
          .toString()
          .trim();

      if (fetchedName.isNotEmpty) {
        profileName.value = fetchedName;
      }
      if (fetchedAvatar.isNotEmpty) {
        profileImage.value = fetchedAvatar;
      }

      await StorageService.saveUser(
        firstName: fetchedFirstName.isEmpty ? null : fetchedFirstName,
        lastName: fetchedLastName.isEmpty ? null : fetchedLastName,
        avatar: fetchedAvatar.isEmpty ? null : fetchedAvatar,
      );
    } on DioException catch (_) {
      // Handle error silently, use fallback values
    } catch (_) {
      // Handle error silently, use fallback values
    } finally {
      isProfileLoading.value = false;
    }
  }

  Future<void> fetchProviderWallet() async {
    try {
      isWalletLoading.value = true;
      walletErrorMessage.value = '';

      final token = await SecureStorageService.getToken();
      if (token == null || token.isEmpty) {
        walletErrorMessage.value = 'Provider token not found';
        return;
      }

      final response = await _apiClient.get<dynamic>(
        ApiEndpoints.providerWallet,
        options: Options(
          headers: {'accept': '*/*', 'Authorization': 'Bearer $token'},
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      debugPrint(
        'Provider wallet request => ${ApiEndpoints.baseUrl}${ApiEndpoints.providerWallet}',
      );
      debugPrint('Provider wallet status => ${response.statusCode}');
      const JsonEncoder encoder = JsonEncoder.withIndent('  ');
      debugPrint(
        'Provider wallet response => ${encoder.convert(response.data)}',
      );

      if (response.statusCode != 200) {
        walletErrorMessage.value = 'Failed to load wallet';
        return;
      }

      final responseMap = _asMap(response.data) ?? <String, dynamic>{};
      final data = _asMap(responseMap['data']) ?? <String, dynamic>{};
      final walletData = _asMap(data['data']) ?? <String, dynamic>{};
      final withdraw = _asMap(walletData['withdraw']) ?? <String, dynamic>{};
      final withdrawAble =
          _asMap(withdraw['totalWithdraeAbleAmount']) ?? <String, dynamic>{};
      final booking = _asMap(walletData['booking']) ?? <String, dynamic>{};
      final review = _asMap(walletData['review']) ?? <String, dynamic>{};

      totalEarnings.value = _formatAmount(withdrawAble['amount']);
      pendingAmount.value = _formatAmount(withdraw['totalPendingAmount']);
      bookingsServed.value =
          '${booking['totalBookingServed'] ?? 0}/${booking['totalBooking'] ?? 0}';
      averageRating.value = (review['averageRating'] ?? 0).toString();
      reviewCount.value = review['totalReview'] ?? 0;
    } on DioException catch (_) {
      walletErrorMessage.value = 'Failed to load wallet';
    } catch (_) {
      walletErrorMessage.value = 'Failed to load wallet';
    } finally {
      isWalletLoading.value = false;
    }
  }

  Future<void> fetchActiveJobs() async {
    try {
      isActiveJobsLoading.value = true;
      activeJobsErrorMessage.value = '';

      final token = await SecureStorageService.getToken();
      if (token == null || token.isEmpty) {
        activeJobsErrorMessage.value = 'Provider token not found';
        return;
      }

      final response = await _apiClient.get<dynamic>(
        ApiEndpoints.myActiveJob,
        queryParameters: {'page': 1, 'limit': 10},
        options: Options(
          headers: {'accept': '*/*', 'Authorization': 'Bearer $token'},
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      debugPrint(
        'Provider active jobs request => ${ApiEndpoints.baseUrl}${ApiEndpoints.myActiveJob}?page=1&limit=10',
      );
      debugPrint('Provider active jobs status => ${response.statusCode}');
      const JsonEncoder encoder = JsonEncoder.withIndent('  ');
      debugPrint(
        'Provider active jobs response => ${encoder.convert(response.data)}',
      );

      if (response.statusCode != 200) {
        activeJobsErrorMessage.value = 'Failed to load active jobs';
        return;
      }

      final responseMap = _asMap(response.data) ?? <String, dynamic>{};
      final data = _asMap(responseMap['data']) ?? <String, dynamic>{};
      final items = data['data'];

      if (items is! List) {
        activeJobs.clear();
        return;
      }

      activeJobs.assignAll(
        items.whereType<Map>().map(
          (item) => ActiveJobModel.fromJson(
            item.map((key, value) => MapEntry(key.toString(), value)),
          ),
        ),
      );

      debugPrint('Provider active jobs length => ${activeJobs.length}');
    } on DioException catch (_) {
      activeJobsErrorMessage.value = 'Failed to load active jobs';
    } catch (_) {
      activeJobsErrorMessage.value = 'Failed to load active jobs';
    } finally {
      isActiveJobsLoading.value = false;
    }
  }

  Future<void> fetchRecentBookings() async {
    try {
      isRecentBookingsLoading.value = true;
      recentBookingsErrorMessage.value = '';

      final token = await SecureStorageService.getToken();
      if (token == null || token.isEmpty) {
        recentBookingsErrorMessage.value = 'Provider token not found';
        return;
      }

      final response = await _apiClient.get<dynamic>(
        ApiEndpoints.recentBookings,
        queryParameters: {'page': 1, 'limit': 10},
        options: Options(
          headers: {'accept': '*/*', 'Authorization': 'Bearer $token'},
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      debugPrint(
        'Provider recent bookings request => ${ApiEndpoints.baseUrl}${ApiEndpoints.recentBookings}?page=1&limit=100',
      );
      debugPrint('Provider recent bookings status => ${response.statusCode}');
      const JsonEncoder encoder = JsonEncoder.withIndent('  ');
      debugPrint(
        'Provider recent bookings response => ${encoder.convert(response.data)}',
      );

      if (response.statusCode != 200) {
        recentBookingsErrorMessage.value = 'Failed to load recent bookings';
        return;
      }

      final responseMap = _asMap(response.data) ?? <String, dynamic>{};
      final data = _asMap(responseMap['data']) ?? <String, dynamic>{};
      final items = data['data'];

      if (items is! List) {
        recentBookings.clear();
        return;
      }

      recentBookings.assignAll(
        items.whereType<Map>().map(
          (item) => RecentBookingModel.fromJson(
            item.map((key, value) => MapEntry(key.toString(), value)),
          ),
        ),
      );

      debugPrint('Provider recent bookings length => ${recentBookings.length}');
    } on DioException catch (_) {
      recentBookingsErrorMessage.value = 'Failed to load recent bookings';
    } catch (_) {
      recentBookingsErrorMessage.value = 'Failed to load recent bookings';
    } finally {
      isRecentBookingsLoading.value = false;
    }
  }

  String _formatAmount(dynamic value) {
    final parsed = double.tryParse(value?.toString() ?? '') ?? 0;
    return parsed.toStringAsFixed(2);
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

  void toggleLimit() {
    isLimitReached.value = !isLimitReached.value;
  }

  void handleUpgrade() {
    // Logic to navigate to pricing or upgrade screen
    Get.snackbar("Upgrade", "Navigating to Upgrade screen...");
  }

  void handleViewAllActiveJobs() {
    Get.toNamed(AppRoute.activeJobs);
  }

  void handleViewAllRecentBookings() {
    Get.toNamed(AppRoute.recentBookings);
  }

  void handleViewWallet() {
    Get.find<ProviderNavbarController>().showHomeSubPage(const WalletScreen());
  }

  Future<void> refreshHomeData() async {
    await Future.wait([
      fetchProfileData(),
      fetchProviderWallet(),
      fetchActiveJobs(),
      fetchRecentBookings(),
    ]);
  }
}
