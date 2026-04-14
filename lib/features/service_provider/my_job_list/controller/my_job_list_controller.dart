import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:protiva502/core/services/api_client.dart';
import 'package:protiva502/core/services/secure_storage_service.dart';
import 'package:protiva502/core/utils/constants/apiendpoint.dart';
import 'package:protiva502/features/service_provider/my_job_list/controller/create_job_controller.dart';
import 'package:protiva502/features/service_provider/my_job_list/model/job_model.dart';
import 'package:protiva502/routes/app_routes.dart';

class MyJobListController extends GetxController {
  final ApiClient _apiClient = ApiClient();

  // Listings data
  final listings = <JobModel>[].obs;
  final isLoading = false.obs;
  final isLoadingMore = false.obs;
  final errorMessage = ''.obs;

  // Pagination data
  final currentPage = 1.obs;
  final totalPages = 1.obs;
  final pageSize = 6; // Initial load 6 items
  final additionalPageSize = 4; // Load 4 more items on pagination
  late ScrollController scrollController;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    scrollController.addListener(_onScroll);
    fetchMyActiveJobs();
  }

  @override
  void onClose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.onClose();
  }

  void _onScroll() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (currentPage.value < totalPages.value && !isLoadingMore.value) {
        loadMoreJobs();
      }
    }
  }

  Future<void> fetchMyActiveJobs({bool refresh = false}) async {
    try {
      if (refresh) {
        currentPage.value = 1;
        listings.clear();
        errorMessage.value = '';
      }

      isLoading.value = !refresh;
      errorMessage.value = '';

      final token = await SecureStorageService.getToken();
      if (token == null || token.isEmpty) {
        errorMessage.value = 'Provider token not found';
        return;
      }

      final limit = refresh ? pageSize : pageSize;
      final response = await _apiClient.get<dynamic>(
        ApiEndpoints.getJobs,
        queryParameters: {'page': currentPage.value, 'limit': limit},
        options: Options(
          headers: {'accept': '*/*', 'Authorization': 'Bearer $token'},
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      debugPrint(
        'My job list request => ${ApiEndpoints.baseUrl}${ApiEndpoints.getJobs}?page=${currentPage.value}&limit=$limit',
      );
      debugPrint('My job list status => ${response.statusCode}');
      debugPrint('My job list response => ${response.data}');

      if (response.statusCode != 200) {
        errorMessage.value = 'Failed to load my jobs';
        if (refresh) {
          listings.clear();
        }
        return;
      }

      final responseMap = _asMap(response.data) ?? <String, dynamic>{};
      final responseData = _asMap(responseMap['data']) ?? <String, dynamic>{};

      // Parse pagination info
      final page = int.tryParse(responseData['page']?.toString() ?? '1') ?? 1;
      final totalPagesValue =
          int.tryParse(responseData['totalPages']?.toString() ?? '1') ?? 1;

      totalPages.value = totalPagesValue;
      currentPage.value = page;

      final items = responseData['result'];

      if (items is! List) {
        if (refresh) {
          listings.clear();
        }
        return;
      }

      final newJobs = items
          .whereType<Map>()
          .map(
            (item) => JobModel.fromJson(
              item.map((key, value) => MapEntry(key.toString(), value)),
            ),
          )
          .toList();

      if (refresh) {
        listings.assignAll(newJobs);
      } else {
        listings.addAll(newJobs);
      }

      debugPrint('My job list length => ${listings.length}');
    } on DioException catch (e) {
      debugPrint('DioException: $e');
      errorMessage.value = 'Failed to load my jobs';
      if (refresh) {
        listings.clear();
      }
    } catch (e) {
      debugPrint('Exception: $e');
      errorMessage.value = 'Failed to load my jobs';
      if (refresh) {
        listings.clear();
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMoreJobs() async {
    if (isLoadingMore.value || currentPage.value >= totalPages.value) {
      return;
    }

    try {
      isLoadingMore.value = true;
      final nextPage = currentPage.value + 1;

      final token = await SecureStorageService.getToken();
      if (token == null || token.isEmpty) {
        errorMessage.value = 'Provider token not found';
        return;
      }

      final response = await _apiClient.get<dynamic>(
        ApiEndpoints.getJobs,
        queryParameters: {'page': nextPage, 'limit': additionalPageSize},
        options: Options(
          headers: {'accept': '*/*', 'Authorization': 'Bearer $token'},
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      debugPrint(
        'Load more jobs request => ${ApiEndpoints.baseUrl}${ApiEndpoints.getJobs}?page=$nextPage&limit=$additionalPageSize',
      );
      debugPrint('Load more jobs status => ${response.statusCode}');

      if (response.statusCode != 200) {
        errorMessage.value = 'Failed to load more jobs';
        return;
      }

      final responseMap = _asMap(response.data) ?? <String, dynamic>{};
      final responseData = _asMap(responseMap['data']) ?? <String, dynamic>{};

      final totalPagesValue =
          int.tryParse(responseData['totalPages']?.toString() ?? '1') ?? 1;
      totalPages.value = totalPagesValue;
      currentPage.value = nextPage;

      final items = responseData['result'];

      if (items is! List) {
        return;
      }

      final newJobs = items
          .whereType<Map>()
          .map(
            (item) => JobModel.fromJson(
              item.map((key, value) => MapEntry(key.toString(), value)),
            ),
          )
          .toList();

      listings.addAll(newJobs);
      debugPrint('Loaded more jobs. Total: ${listings.length}');
    } on DioException catch (e) {
      debugPrint('DioException loading more: $e');
      errorMessage.value = 'Failed to load more jobs';
    } catch (e) {
      debugPrint('Exception loading more: $e');
      errorMessage.value = 'Failed to load more jobs';
    } finally {
      isLoadingMore.value = false;
    }
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

  void handleNewListing() {
    Get.toNamed(AppRoute.postJob);
  }

  void handleEditListing(int index) {
    final job = listings[index];
    Get.toNamed(
      AppRoute.postJob,
      arguments: job,
    );
  }

  void handleDeleteListing(int index) {
    final job = listings[index];
    
    Get.dialog(
      AlertDialog(
        title: const Text('Delete Job'),
        content: Text('Are you sure you want to delete "${job.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Get.back(); // Close dialog
              
              // Get CreateJobController to use its deleteJob method
              final createJobController = Get.find<CreateJobController>();
              final success = await createJobController.deleteJob(job.id);
              
              if (success) {
                // Remove from list after successful deletion
                listings.removeAt(index);
                Get.snackbar(
                  'Success',
                  '${job.title} has been deleted',
                  snackPosition: SnackPosition.BOTTOM,
                );
              }
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
