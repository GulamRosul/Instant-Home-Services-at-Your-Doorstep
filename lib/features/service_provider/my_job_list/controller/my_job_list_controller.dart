import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:protiva502/core/services/api_client.dart';
import 'package:protiva502/core/services/secure_storage_service.dart';
import 'package:protiva502/core/utils/constants/apiendpoint.dart';
import 'package:protiva502/features/service_provider/home/model/active_job_model.dart';
import 'package:protiva502/routes/app_routes.dart';

class MyJobListController extends GetxController {
  final ApiClient _apiClient = ApiClient();
  final listings = <ActiveJobModel>[].obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMyActiveJobs();
  }

  Future<void> fetchMyActiveJobs() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final token = await SecureStorageService.getToken();
      if (token == null || token.isEmpty) {
        errorMessage.value = 'Provider token not found';
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
        'My job list request => ${ApiEndpoints.baseUrl}${ApiEndpoints.myActiveJob}?page=1&limit=10',
      );
      debugPrint('My job list status => ${response.statusCode}');
      debugPrint('My job list response => ${response.data}');

      if (response.statusCode != 200) {
        errorMessage.value = 'Failed to load my jobs';
        listings.clear();
        return;
      }

      final responseMap = _asMap(response.data) ?? <String, dynamic>{};
      final data = _asMap(responseMap['data']) ?? <String, dynamic>{};
      final items = data['data'];

      if (items is! List) {
        listings.clear();
        return;
      }

      listings.assignAll(
        items.whereType<Map>().map(
          (item) => ActiveJobModel.fromJson(
            item.map((key, value) => MapEntry(key.toString(), value)),
          ),
        ),
      );

      debugPrint('My job list length => ${listings.length}');
    } on DioException catch (_) {
      errorMessage.value = 'Failed to load my jobs';
      listings.clear();
    } catch (_) {
      errorMessage.value = 'Failed to load my jobs';
      listings.clear();
    } finally {
      isLoading.value = false;
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
    Get.snackbar("Action", "Editing: ${listings[index].title}");
  }

  void handleDeleteListing(int index) {
    final title = listings[index].title;
    listings.removeAt(index);
    Get.snackbar("Deleted", "$title has been removed from listings");
  }
}
