import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/services/api_client.dart';
import 'package:protiva502/core/utils/constants/apiendpoint.dart';
import 'package:protiva502/features/user/home/model/home_job_model.dart';

class SearchController extends GetxController {
  final RxList<HomeJobModel> searchResults = <HomeJobModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString searchQuery = ''.obs;

  late TextEditingController searchTextController;
  final ApiClient _apiClient = ApiClient();

  @override
  void onInit() {
    super.onInit();
    searchTextController = TextEditingController();
  }

  @override
  void onClose() {
    searchTextController.dispose();
    super.onClose();
  }

  Future<void> searchJobs(String query) async {
    if (query.isEmpty) {
      searchResults.clear();
      errorMessage.value = '';
      return;
    }

    try {
      isLoading.value = true;
      errorMessage.value = '';
      searchQuery.value = query;

      final response = await _apiClient.get(
        ApiEndpoints.homeSearch,
        queryParameters: {'search': query},
      );

      // Add these two lines right after the await:
      debugPrint('REQUEST URL: ${response.requestOptions.uri}');
      debugPrint('RESPONSE: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data;
        if (data is Map && data['data'] is List) {
          final jobsData = (data['data'] as List)
              .map((job) => HomeJobModel.fromJson(job as Map<String, dynamic>))
              .toList();
          searchResults.value = jobsData;

          if (searchResults.isEmpty) {
            errorMessage.value = 'No services found for "$query"';
          }
        } else {
          errorMessage.value = 'Invalid response format';
        }
      } else {
        errorMessage.value = 'Failed to fetch search results';
      }
    } on DioException catch (e) {
      errorMessage.value = e.message ?? 'Search failed';
    } catch (e) {
      errorMessage.value = 'An error occurred during search';
    } finally {
      isLoading.value = false;
    }
  }

  void clearSearch() {
    searchQuery.value = '';
    searchResults.clear();
    errorMessage.value = '';
  }
}
