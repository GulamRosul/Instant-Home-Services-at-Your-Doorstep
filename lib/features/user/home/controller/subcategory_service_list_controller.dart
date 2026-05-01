import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/localization/localization_service.dart';
import 'package:protiva502/core/services/api_client.dart';
import 'package:protiva502/core/services/secure_storage_service.dart';
import 'package:protiva502/core/utils/constants/apiendpoint.dart';
import 'package:protiva502/core/utils/logging/logger.dart';
import 'package:protiva502/features/user/home/model/subcategory_service_model.dart';

class SubcategoryServiceListController extends GetxController {
  final ApiClient _apiClient = ApiClient();

  // Observable for the subcategory title
  var subcategoryTitle = ''.obs;

  // Observable for the service count
  var serviceCount = 0.obs;

  // Service list observables
  final services = <SubcategoryServiceModel>[].obs;
  final isLoading = false.obs;
  final isLoadingMore = false.obs;
  final errorMessage = ''.obs;

  // Pagination variables
  var currentPage = 1.obs;
  var totalPages = 1.obs;
  var subCategoryId = ''.obs;
  late ScrollController scrollController;

  static const int pageSize = 6;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    scrollController.addListener(_onScroll);

    // Get the parameters passed from the previous screen
    if (Get.arguments != null) {
      subcategoryTitle.value = Get.arguments['title'] ?? 'Subcategory Services';
      subCategoryId.value = Get.arguments['subCategoryId'] ?? '';

      // Handle count as either int or string
      final countArg = Get.arguments['count'];
      if (countArg is int) {
        serviceCount.value = countArg;
      } else {
        String countString = countArg?.toString() ?? '0 Services';
        serviceCount.value = _extractCountFromString(countString);
      }

      // Fetch services for the subcategory
      if (subCategoryId.value.isNotEmpty) {
        fetchServices();
      }
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      if (currentPage.value < totalPages.value && !isLoadingMore.value) {
        _loadMoreServices();
      }
    }
  }

  Future<void> fetchServices({int page = 1}) async {
    try {
      if (page == 1) {
        isLoading.value = true;
        errorMessage.value = '';
      } else {
        isLoadingMore.value = true;
      }

      final token = await SecureStorageService.getToken();
      final headers = <String, dynamic>{'accept': '*/*'};
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }

      final response = await _apiClient.get<dynamic>(
        ApiEndpoints.subCategoryServices(subCategoryId.value),
        queryParameters: {'page': page, 'limit': pageSize},
        options: Options(
          headers: headers,
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      AppLoggerHelper.info('Services response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final responseData = SubcategoryServiceResponse.fromJson(response.data);

        if (page == 1) {
          services.assignAll(responseData.data);
        } else {
          services.addAll(responseData.data);
        }

        currentPage.value = page;
        totalPages.value = responseData.meta.totalPage;

        AppLoggerHelper.info(
          'Fetched ${responseData.data.length} services (page: $page)',
        );
      } else {
        errorMessage.value = 'failed_load_services'.tr;
        AppLoggerHelper.warning(
          'Failed to fetch services: ${response.statusCode}',
        );
      }
    } on DioException catch (error) {
      errorMessage.value = error.message ?? 'failed_load_services'.tr;
      AppLoggerHelper.error('Services fetch failed', error);
    } catch (error) {
      errorMessage.value = 'failed_load_services'.tr;
      AppLoggerHelper.error('Unexpected services fetch error', error);
    } finally {
      isLoading.value = false;
      isLoadingMore.value = false;
    }
  }

  void _loadMoreServices() {
    final nextPage = currentPage.value + 1;
    if (nextPage <= totalPages.value) {
      fetchServices(page: nextPage);
    }
  }

  // Helper method to extract the numeric count from the string
  int _extractCountFromString(String countString) {
    // Extract numbers from string like "05 Services" or "5 Services"
    final RegExp regExp = RegExp(r'\d+');
    final match = regExp.firstMatch(countString);
    if (match != null) {
      return int.parse(match.group(0)!);
    }
    return 0;
  }
}
