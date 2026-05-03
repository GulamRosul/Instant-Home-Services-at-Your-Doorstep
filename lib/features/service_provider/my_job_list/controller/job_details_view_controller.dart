import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/services/api_client.dart';
import 'package:protiva502/core/services/secure_storage_service.dart';
import 'package:protiva502/core/services/storage_service.dart';
import 'package:protiva502/core/utils/constants/apiendpoint.dart';
import 'package:protiva502/features/service_provider/my_job_list/model/job_details_view_model.dart';
import 'package:protiva502/features/service_provider/my_job_list/model/job_model.dart';

class JobDetailsViewController extends GetxController {
  JobDetailsViewController({ApiClient? apiClient})
    : _apiClient = apiClient ?? ApiClient();

  final ApiClient _apiClient;

  final Rxn<JobModel> job = Rxn<JobModel>();
  final Rxn<JobDetailsModel> jobDetails = Rxn<JobDetailsModel>();
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  String get jobId => job.value?.id ?? '';

  @override
  void onInit() {
    super.onInit();
    _setInitialJob(Get.arguments);
    if (jobId.isNotEmpty) {
      getSingleJob(jobId);
    } else {
      errorMessage.value = 'Job id not found';
    }
  }

  Future<void> getSingleJob(String id) async {
    if (id.trim().isEmpty) {
      errorMessage.value = 'Job id not found';
      return;
    }

    try {
      isLoading.value = true;
      errorMessage.value = '';

      await StorageService.ensureInitialized();
      final token = await SecureStorageService.getToken();
      final headers = <String, dynamic>{'accept': '*/*'};
      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }

      final endpoint = ApiEndpoints.getSingleJob(id);
      final response = await _apiClient.get<dynamic>(
        endpoint,
        options: Options(
          headers: headers,
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      debugPrint('Single job request => ${ApiEndpoints.baseUrl}$endpoint');
      debugPrint('Single job status => ${response.statusCode}');
      debugPrint('Single job response => ${response.data}');

      if (response.statusCode != 200 || response.data == null) {
        errorMessage.value = 'Failed to load service details';
        return;
      }

      final responseMap = _asMap(response.data);
      if (responseMap == null) {
        errorMessage.value = 'Invalid service details response';
        return;
      }

      final detailsResponse = JobDetailsResponseModel.fromJson(responseMap);
      final details = detailsResponse.data;
      if (details == null) {
        errorMessage.value = 'Service details not found';
        return;
      }

      jobDetails.value = details;
      job.value = details.toJobModel();
    } on DioException catch (error) {
      debugPrint('Single job DioException => $error');
      errorMessage.value = error.message ?? 'Failed to load service details';
    } catch (error) {
      debugPrint('Single job exception => $error');
      errorMessage.value = 'Failed to load service details';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshJob() async {
    final id = jobId;
    if (id.isNotEmpty) {
      await getSingleJob(id);
    }
  }

  void _setInitialJob(dynamic arguments) {
    if (arguments is JobModel) {
      job.value = arguments;
      return;
    }

    if (arguments is JobDetailsModel) {
      jobDetails.value = arguments;
      job.value = arguments.toJobModel();
      return;
    }

    if (arguments is Map) {
      final data = arguments.map(
        (key, value) => MapEntry(key.toString(), value),
      );
      final id = data['id']?.toString() ?? data['jobId']?.toString() ?? '';
      if (id.isNotEmpty) {
        job.value = _placeholderJob(id);
      }
      return;
    }

    if (arguments is String && arguments.trim().isNotEmpty) {
      job.value = _placeholderJob(arguments.trim());
    }
  }

  JobModel _placeholderJob(String id) {
    return JobModel(
      id: id,
      userId: '',
      categoryId: '',
      subCategoryId: '',
      title: '',
      slug: '',
      description: '',
      basePrice: '0',
      priceType: '',
      includeService: const [],
      thumbnail: '',
      images: const [],
      videos: const [],
      status: '',
      views: 0,
      clicks: 0,
      totalBookings: 0,
      isPopuler: false,
      createdAt: '',
      updatedAt: '',
    );
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
}
