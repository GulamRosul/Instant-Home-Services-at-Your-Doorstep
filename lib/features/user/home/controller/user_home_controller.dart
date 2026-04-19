import 'dart:async';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/services/api_client.dart';
import 'package:protiva502/core/services/secure_storage_service.dart';
import 'package:protiva502/core/services/storage_service.dart';
import 'package:protiva502/core/utils/constants/apiendpoint.dart';
import 'package:protiva502/core/utils/logging/logger.dart';
import 'package:protiva502/features/user/home/model/categories_model.dart';
import 'package:protiva502/features/user/home/model/expert_recommendation_model.dart';
import 'package:protiva502/features/user/home/model/home_job_model.dart';
import 'package:protiva502/features/user/home/model/user_banner_model.dart';

class UserHomeController extends GetxController {
  final ApiClient _apiClient = ApiClient();

  // Profile data for the header
  var profileName = ''.obs;
  var profileImage = ''.obs;
  var isProfileLoading = false.obs;

  // For the banner carousel dots
  var currentBannerIndex = 0.obs;
  final PageController bannerController = PageController();
  final isBannerLoading = true.obs;
  final bannerErrorMessage = ''.obs;
  final banners = <UserBannerModel>[].obs;
  final isServicesLoading = false.obs;
  final servicesErrorMessage = ''.obs;
  final popularServices = <HomeJobModel>[].obs;
  final allServices = <HomeJobModel>[].obs;
  final isCategoriesLoading = false.obs;
  final categoriesErrorMessage = ''.obs;
  final categories = <CategoryModel>[].obs;
  Timer? _bannerAutoScrollTimer;

  // Expert Recommendation properties
  final isExpertsLoading = false.obs;
  final expertsErrorMessage = ''.obs;
  final recommendedExperts = <ExpertRecommendationModel>[].obs;
  final expertPageController = PageController();
  var currentExpertPage = 0.obs;
  final int _expertsPageSize = 5;

  void updateBannerIndex(int index) {
    currentBannerIndex.value = index;
  }

  void _startBannerAutoScroll() {
    _bannerAutoScrollTimer?.cancel();

    if (banners.length <= 1) {
      return;
    }

    _bannerAutoScrollTimer = Timer.periodic(const Duration(seconds: 4), (
      timer,
    ) {
      if (!bannerController.hasClients || banners.isEmpty) {
        return;
      }

      final nextIndex = (currentBannerIndex.value + 1) % banners.length;
      bannerController.animateToPage(
        nextIndex,
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeInOut,
      );
    });
  }

  void _stopBannerAutoScroll() {
    _bannerAutoScrollTimer?.cancel();
    _bannerAutoScrollTimer = null;
  }

  @override
  void onInit() {
    super.onInit();
    fetchProfileData();
    fetchBanners();
    fetchHomeServices();
    fetchCategories();
    fetchRecommendedExperts();
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
        'User profile request => ${ApiEndpoints.baseUrl}${ApiEndpoints.authMe}',
      );
      debugPrint('User profile status => ${response.statusCode}');
      debugPrint('User profile response => ${response.data}');

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
    } on DioException catch (error) {
      AppLoggerHelper.error('Profile fetch failed', error);
    } catch (error) {
      AppLoggerHelper.error('Unexpected profile fetch error', error);
    } finally {
      isProfileLoading.value = false;
    }
  }

  Future<void> fetchHomeServices() async {
    try {
      isServicesLoading.value = true;
      servicesErrorMessage.value = '';

      final allResponse = await _apiClient.get<dynamic>(
        ApiEndpoints.homeJobs,
        queryParameters: {'page': 1, 'limit': 10},
        options: Options(
          headers: const {'accept': '*/*'},
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      final popularResponse = await _apiClient.get<dynamic>(
        ApiEndpoints.homeJobs,
        queryParameters: {'isPopuler': true, 'page': 1, 'limit': 10},
        options: Options(
          headers: const {'accept': '*/*'},
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      final allJobs = _extractJobs(allResponse.data);
      final popularJobs = _extractJobs(popularResponse.data);

      allServices.assignAll(allJobs);
      popularServices.assignAll(popularJobs);

      debugPrint(
        'User home request => ${ApiEndpoints.baseUrl}${ApiEndpoints.homeJobs}?page=1&limit=10',
      );
      debugPrint('User home status => ${allResponse.statusCode}');
      debugPrint('User home response => ${allResponse.data}');
      debugPrint(
        'User home request => ${ApiEndpoints.baseUrl}${ApiEndpoints.homeJobs}?isPopuler=true&page=1&limit=10',
      );
      debugPrint('User home status => ${popularResponse.statusCode}');
      debugPrint('User home response => ${popularResponse.data}');
      debugPrint('All Services Length: ${allServices.length}');
      debugPrint('Popular Services Length: ${popularServices.length}');
    } on DioException catch (error) {
      servicesErrorMessage.value =
          _extractMessage(error.response?.data) ??
          error.message ??
          'Failed to load services';
      AppLoggerHelper.error('Home services fetch failed', error);
    } catch (error) {
      servicesErrorMessage.value = 'Failed to load services';
      AppLoggerHelper.error('Unexpected home services fetch error', error);
    } finally {
      isServicesLoading.value = false;
    }
  }

  Future<void> fetchCategories() async {
    try {
      isCategoriesLoading.value = true;
      categoriesErrorMessage.value = '';

      final response = await _apiClient.get<dynamic>(
        ApiEndpoints.categories,
        queryParameters: {'page': 1, 'limit': 20},
        options: Options(
          headers: const {'accept': '*/*'},
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      debugPrint(
        'Categories request => ${ApiEndpoints.baseUrl}${ApiEndpoints.categories}?page=1&limit=20',
      );
      debugPrint('Categories status => ${response.statusCode}');
      debugPrint('Categories response => ${response.data}');

      List<CategoryModel> fetchedCategories = [];

      if (response.statusCode == 200) {
        // Extract categories data - handle multiple possible response structures
        final categoriesData = _extractCategoriesData(response.data);

        if (categoriesData.isNotEmpty) {
          fetchedCategories =
              categoriesData
                  .map(
                    (category) => CategoryModel.fromJson(
                      category.map(
                        (key, value) => MapEntry(key.toString(), value),
                      ),
                    ),
                  )
                  .where((category) => category.isActive)
                  .toList()
                ..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
        }
      }

      if (fetchedCategories.isEmpty && response.statusCode != 200) {
        categories.clear();
        categoriesErrorMessage.value =
            _extractMessage(response.data) ?? 'Failed to load categories';
        AppLoggerHelper.warning(
          'Failed to fetch categories: ${categoriesErrorMessage.value}',
        );
        return;
      }

      categories.assignAll(fetchedCategories);
      debugPrint('Fetched ${fetchedCategories.length} categories');
      AppLoggerHelper.info('Fetched ${fetchedCategories.length} categories');
    } on DioException catch (error) {
      categories.clear();
      categoriesErrorMessage.value =
          _extractMessage(error.response?.data) ??
          error.message ??
          'Failed to load categories';
      AppLoggerHelper.error('Categories fetch failed', error);
    } catch (error) {
      categories.clear();
      categoriesErrorMessage.value = 'Failed to load categories';
      AppLoggerHelper.error('Unexpected categories fetch error', error);
    } finally {
      isCategoriesLoading.value = false;
    }
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
      _startBannerAutoScroll();
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

  Future<void> fetchRecommendedExperts({int page = 1}) async {
    try {
      if (page == 1) {
        isExpertsLoading.value = true;
      }
      expertsErrorMessage.value = '';

      final response = await _apiClient.get<dynamic>(
        ApiEndpoints.getRecommendedExperts,
        queryParameters: {'page': page, 'limit': _expertsPageSize},
        options: Options(
          headers: const {'accept': '*/*'},
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      debugPrint(
        'Recommended Experts request => ${ApiEndpoints.baseUrl}${ApiEndpoints.getRecommendedExperts}?page=$page&limit=$_expertsPageSize',
      );
      debugPrint('Recommended Experts status => ${response.statusCode}');
      debugPrint('Recommended Experts response => ${response.data}');

      final experts = _extractExperts(response.data);

      if (response.statusCode == 200 && experts.isNotEmpty) {
        if (page == 1) {
          recommendedExperts.assignAll(experts);
        } else {
          recommendedExperts.addAll(experts);
        }
        AppLoggerHelper.info('Fetched ${experts.length} recommended experts');
      } else if (response.statusCode != 200) {
        if (page == 1) {
          recommendedExperts.clear();
        }
        expertsErrorMessage.value =
            _extractMessage(response.data) ??
            'Failed to load recommended experts';
        AppLoggerHelper.warning(
          'Failed to fetch experts: ${expertsErrorMessage.value}',
        );
      }
    } on DioException catch (error) {
      if (currentExpertPage.value == 1) {
        recommendedExperts.clear();
      }
      expertsErrorMessage.value =
          _extractMessage(error.response?.data) ??
          error.message ??
          'Failed to load recommended experts';
      AppLoggerHelper.error('Expert fetch failed', error);
    } catch (error) {
      if (currentExpertPage.value == 1) {
        recommendedExperts.clear();
      }
      expertsErrorMessage.value = 'Failed to load recommended experts';
      AppLoggerHelper.error('Unexpected expert fetch error', error);
    } finally {
      isExpertsLoading.value = false;
    }
  }

  void updateExpertPage(int pageIndex) {
    currentExpertPage.value = pageIndex;
    final nextPageToLoad = (pageIndex ~/ _expertsPageSize) + 1;
    final totalLoadedPages =
        (recommendedExperts.length + _expertsPageSize - 1) ~/ _expertsPageSize;

    // Load more if user scrolls to next page
    if (nextPageToLoad > totalLoadedPages && totalLoadedPages > 0) {
      fetchRecommendedExperts(page: nextPageToLoad);
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

  // Extract categories from various possible API response structures
  List<Map> _extractCategoriesData(dynamic responseData) {
    final responseMap = _asMap(responseData) ?? <String, dynamic>{};

    // Try different possible response structures
    // Structure 1: { data: { data: { data: [...] } } }
    var data = _asMap(responseMap['data']);
    if (data != null) {
      var nestedData = _asMap(data['data']);
      if (nestedData != null) {
        var categoriesData = nestedData['data'];
        if (categoriesData is List) {
          return categoriesData.whereType<Map>().toList();
        }
      }
    }

    // Structure 2: { data: [...] } - direct array in data
    if (responseMap['data'] is List) {
      return responseMap['data'].whereType<Map>().toList();
    }

    // Structure 3: { data: { categories: [...] } }
    data = _asMap(responseMap['data']);
    if (data != null && data['categories'] is List) {
      return data['categories'].whereType<Map>().toList();
    }

    return [];
  }

  List<ExpertRecommendationModel> _extractExperts(dynamic responseData) {
    final responseMap = _asMap(responseData);
    final data = _asMap(responseMap?['data']);
    final expertsData = data?['data'];

    if (expertsData is! List) {
      return const [];
    }

    return expertsData
        .whereType<Map>()
        .map(
          (item) => ExpertRecommendationModel.fromJson(
            item.map((key, value) => MapEntry(key.toString(), value)),
          ),
        )
        .toList();
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

  List<HomeJobModel> _extractJobs(dynamic responseData) {
    final responseMap = _asMap(responseData);
    final data = _asMap(responseMap?['data']);
    final nestedData = _asMap(data?['data']);
    final items = nestedData?['data'];

    if (items is! List) {
      return const [];
    }

    return items
        .whereType<Map>()
        .map(
          (item) => HomeJobModel.fromJson(
            item.map((key, value) => MapEntry(key.toString(), value)),
          ),
        )
        .toList();
  }

  // Methods for pagination in GenericListingScreen
  Future<List<HomeJobModel>> fetchPopularServices(int page, int limit) async {
    try {
      final response = await _apiClient.get<dynamic>(
        ApiEndpoints.homeJobs,
        queryParameters: {'isPopuler': true, 'page': page, 'limit': limit},
        options: Options(
          headers: const {'accept': '*/*'},
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      return _extractJobs(response.data);
    } catch (error) {
      AppLoggerHelper.error('Failed to fetch popular services', error);
      rethrow;
    }
  }

  Future<List<HomeJobModel>> fetchAllServices(int page, int limit) async {
    try {
      final response = await _apiClient.get<dynamic>(
        ApiEndpoints.homeJobs,
        queryParameters: {'page': page, 'limit': limit},
        options: Options(
          headers: const {'accept': '*/*'},
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      return _extractJobs(response.data);
    } catch (error) {
      AppLoggerHelper.error('Failed to fetch all services', error);
      rethrow;
    }
  }

  Future<List<ExpertRecommendationModel>> fetchAllExperts(
    int page,
    int limit,
  ) async {
    try {
      final response = await _apiClient.get<dynamic>(
        ApiEndpoints.getRecommendedExperts,
        queryParameters: {'page': page, 'limit': limit},
        options: Options(
          headers: const {'accept': '*/*'},
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      return _extractExperts(response.data);
    } catch (error) {
      AppLoggerHelper.error('Failed to fetch recommended experts', error);
      rethrow;
    }
  }

  @override
  void onClose() {
    _stopBannerAutoScroll();
    bannerController.dispose();
    expertPageController.dispose();
    super.onClose();
  }
}
