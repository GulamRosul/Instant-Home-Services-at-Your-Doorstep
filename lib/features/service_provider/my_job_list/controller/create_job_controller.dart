import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:image_picker/image_picker.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/services/api_client.dart';
import 'package:protiva502/core/services/secure_storage_service.dart';
import 'package:protiva502/core/services/storage_service.dart';
import 'package:protiva502/core/utils/constants/apiendpoint.dart';
import 'package:protiva502/core/utils/logging/logger.dart';
import 'package:protiva502/features/service_provider/my_job_list/model/create_job_model.dart';
import 'package:protiva502/features/service_provider/my_job_list/model/delete_job_response.dart';
import 'package:protiva502/features/service_provider/my_job_list/model/job_model.dart';
import 'package:protiva502/features/user/home/model/categories_model.dart';
import 'package:protiva502/features/user/home/model/sub_category_model.dart';

class CreateJobController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  final ApiClient _apiClient = ApiClient();

  // Step Management
  var currentStep = 0.obs;

  // Edit mode state
  var isEditMode = false.obs;
  var editingJobId = "".obs;
  var editingJob = Rxn<CreateJobModel>();

  // Step 1: Job Details
  final jobTitleController = TextEditingController();
  var selectedCategory = "".obs;
  var selectedCategoryId = "".obs;
  var selectedSpecificService = "".obs;
  var selectedSubCategoryId = "".obs;
  final jobDescriptionController = TextEditingController();
  final basePriceController = TextEditingController();
  var priceType = "Fixed".obs;

  // Step 2: Service Details
  var includedServices = <String>["Basic cleaning service"].obs;
  final serviceInputController = TextEditingController();
  var uploadedImagePath = "".obs;
  var thumbnailUrl = "".obs;

  // Categories and Services Observable
  final isCategoriesLoading = false.obs;
  final categoriesErrorMessage = ''.obs;
  final categories = <CategoryModel>[].obs;

  final isSubCategoriesLoading = false.obs;
  final subCategoriesErrorMessage = ''.obs;
  final subCategories = <SubCategoryModel>[].obs;

  // Job creation state
  final isCreatingJob = false.obs;
  final createdJob = Rxn<CreateJobModel>();
  final isUpdatingJob = false.obs;
  
  // Job deletion state
  final isDeletingJob = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> initializeEditMode(JobModel job) async {
    isEditMode.value = true;
    editingJobId.value = job.id;
    editingJob.value = CreateJobModel(
      id: job.id,
      userId: job.userId,
      categoryId: job.categoryId,
      subCategoryId: job.subCategoryId,
      title: job.title,
      slug: job.slug,
      description: job.description,
      basePrice: job.basePrice,
      priceType: job.priceType,
      includeService: job.includeService,
      thumbnail: job.thumbnail,
      features: job.features,
      images: job.images.cast<String>(),
      videos: job.videos.cast<String>(),
      serviceLocation: job.serviceLocation,
      serviceRadius: job.serviceRadius,
      status: job.status,
      views: job.views,
      clicks: job.clicks,
      totalBookings: job.totalBookings,
      averageRating: job.averageRating,
      metaTitle: job.metaTitle,
      metaDescription: job.metaDescription,
      publishedAt: job.publishedAt,
      isPopuler: job.isPopuler,
      createdAt: job.createdAt,
      updatedAt: job.updatedAt,
      deletedAt: job.deletedAt,
    );

    // Prefill form fields
    jobTitleController.text = job.title;
    jobDescriptionController.text = job.description;
    basePriceController.text = job.basePrice;
    selectedCategoryId.value = job.categoryId;
    selectedSubCategoryId.value = job.subCategoryId;
    priceType.value = job.priceType == 'FIXED' ? 'Fixed' : job.priceType;
    includedServices.assignAll(job.includeService);
    thumbnailUrl.value = job.thumbnail;

    // Fetch sub-categories for the selected category
    await fetchSubCategories(job.categoryId);
  }

  Future<void> fetchCategories({int page = 1}) async {
    try {
      isCategoriesLoading.value = true;
      categoriesErrorMessage.value = '';

      final response = await _apiClient.get<dynamic>(
        ApiEndpoints.categories,
        queryParameters: {'page': page, 'limit': 20},
        options: Options(
          headers: const {'accept': '*/*'},
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      AppLoggerHelper.info(
        'Categories response status: ${response.statusCode}',
      );

      List<CategoryModel> fetchedCategories = [];

      if (response.statusCode == 200) {
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

      if (page == 1) {
        categories.assignAll(fetchedCategories);
      } else {
        categories.addAll(fetchedCategories);
      }

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

  Future<void> fetchSubCategories(String categoryId, {int page = 1}) async {
    try {
      isSubCategoriesLoading.value = true;
      subCategoriesErrorMessage.value = '';

      final response = await _apiClient.get<dynamic>(
        ApiEndpoints.subCategories(categoryId),
        queryParameters: {'page': page, 'limit': 20},
        options: Options(
          headers: const {'accept': '*/*'},
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      AppLoggerHelper.info(
        'Sub-categories response status: ${response.statusCode}',
      );

      List<SubCategoryModel> fetchedSubCategories = [];

      if (response.statusCode == 200) {
        final subCategoriesData = _extractSubCategoriesData(response.data);

        if (subCategoriesData.isNotEmpty) {
          fetchedSubCategories =
              subCategoriesData
                  .map(
                    (subCategory) => SubCategoryModel.fromJson(
                      subCategory.map(
                        (key, value) => MapEntry(key.toString(), value),
                      ),
                    ),
                  )
                  .where((subCategory) => subCategory.isActive)
                  .toList()
                ..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
        }
      }

      if (fetchedSubCategories.isEmpty && response.statusCode != 200) {
        subCategories.clear();
        subCategoriesErrorMessage.value =
            _extractMessage(response.data) ?? 'Failed to load sub-categories';
        AppLoggerHelper.warning(
          'Failed to fetch sub-categories: ${subCategoriesErrorMessage.value}',
        );
        return;
      }

      if (page == 1) {
        subCategories.assignAll(fetchedSubCategories);
      } else {
        subCategories.addAll(fetchedSubCategories);
      }

      AppLoggerHelper.info(
        'Fetched ${fetchedSubCategories.length} sub-categories for category: $categoryId',
      );
    } on DioException catch (error) {
      subCategories.clear();
      subCategoriesErrorMessage.value =
          _extractMessage(error.response?.data) ??
          error.message ??
          'Failed to load sub-categories';
      AppLoggerHelper.error('Sub-categories fetch failed', error);
    } catch (error) {
      subCategories.clear();
      subCategoriesErrorMessage.value = 'Failed to load sub-categories';
      AppLoggerHelper.error('Unexpected sub-categories fetch error', error);
    } finally {
      isSubCategoriesLoading.value = false;
    }
  }

  void selectCategory(String categoryId, String categoryName) {
    selectedCategoryId.value = categoryId;
    selectedCategory.value = categoryName;
    selectedSubCategoryId.value = '';
    fetchSubCategories(categoryId);
  }

  void selectSubCategory(String subCategoryId, String subCategoryName) {
    if (selectedCategoryId.value.isEmpty) {
      Get.snackbar(
        'Please Select Category',
        'Please select a category first',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orangeAccent,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
      return;
    }
    selectedSubCategoryId.value = subCategoryId;
    selectedSpecificService.value = subCategoryName;
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

  List<Map> _extractCategoriesData(dynamic responseData) {
    final responseMap = _asMap(responseData) ?? <String, dynamic>{};

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

    if (responseMap['data'] is List) {
      return responseMap['data'].whereType<Map>().toList();
    }

    data = _asMap(responseMap['data']);
    if (data != null && data['categories'] is List) {
      return data['categories'].whereType<Map>().toList();
    }

    return [];
  }

  List<Map> _extractSubCategoriesData(dynamic responseData) {
    final responseMap = _asMap(responseData) ?? <String, dynamic>{};

    var data = _asMap(responseMap['data']);
    if (data != null) {
      var nestedData = _asMap(data['data']);
      if (nestedData != null) {
        var subCategoriesData = nestedData['data'];
        if (subCategoriesData is List) {
          return subCategoriesData.whereType<Map>().toList();
        }
      }
    }

    if (responseMap['data'] is List) {
      return responseMap['data'].whereType<Map>().toList();
    }

    data = _asMap(responseMap['data']);
    if (data != null && data['subCategories'] is List) {
      return data['subCategories'].whereType<Map>().toList();
    }

    return [];
  }

  bool validateStep() {
    if (currentStep.value == 0) {
      if (jobTitleController.text.trim().isEmpty) {
        EasyLoading.showError("Please enter job title");
        return false;
      }
      if (selectedCategoryId.value.isEmpty) {
        EasyLoading.showError("Please select a category");
        return false;
      }
      if (selectedSubCategoryId.value.isEmpty) {
        EasyLoading.showError("Please select a specific service");
        return false;
      }
      if (jobDescriptionController.text.trim().isEmpty) {
        EasyLoading.showError("Please enter job description");
        return false;
      }
      if (basePriceController.text.trim().isEmpty) {
        EasyLoading.showError("Please enter base price");
        return false;
      }
    } else if (currentStep.value == 1) {
      if (includedServices.isEmpty) {
        EasyLoading.showError("Please add at least one included service");
        return false;
      }
      if (uploadedImagePath.value.isEmpty) {
        EasyLoading.showError("Please upload an image");
        return false;
      }
    }
    return true;
  }

  void nextStep() {
    // if (validateStep()) {
    //   if (currentStep.value < 2) {
    //     currentStep.value++;
    //   }
    // }
    if (currentStep.value < 2) {
      currentStep.value++;
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    } else {
      Get.back();
    }
  }

  void addService() {
    if (serviceInputController.text.isNotEmpty) {
      includedServices.add(serviceInputController.text);
      serviceInputController.clear();
    }
  }

  void removeService(int index) {
    includedServices.removeAt(index);
  }

  Future<void> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );
      if (image != null) {
        uploadedImagePath.value = image.path;
        EasyLoading.showSuccess("Image selected successfully!");
      }
    } catch (e) {
      EasyLoading.showError("Failed to pick image: $e");
    }
  }

  void publishJob() {
    if (validateStep()) {
      if (isEditMode.value) {
        _updateJob();
      } else {
        _createJob();
      }
    }
  }

  Future<void> _createJob() async {
    try {
      if (uploadedImagePath.value.isEmpty) {
        EasyLoading.showError("Please upload an image");
        return;
      }

      isCreatingJob.value = true;
      EasyLoading.show(status: 'Creating job...');

      // Get token from secure storage
      final token = await SecureStorageService.getToken();
      if (token == null || token.isEmpty) {
        EasyLoading.dismiss();
        EasyLoading.showError("Authentication required. Please login again.");
        return;
      }

      // Prepare multipart form data
      final formData = FormData.fromMap({
        'categoryId': selectedCategoryId.value,
        'subCategoryId': selectedSubCategoryId.value,
        'title': jobTitleController.text.trim(),
        'description': jobDescriptionController.text.trim(),
        'basePrice': basePriceController.text.trim(),
        'priceType': priceType.value == "Fixed" ? "FIXED" : priceType.value,
        'includeService': includedServices,
        'image': await MultipartFile.fromFile(
          uploadedImagePath.value,
          filename: uploadedImagePath.value.split('/').last,
        ),
      });

      final response = await _apiClient.post<dynamic>(
        ApiEndpoints.createJob,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      EasyLoading.dismiss();

      AppLoggerHelper.info(
        'Create job response status: ${response.statusCode}',
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final jobData = _extractJobData(response.data);
        if (jobData != null) {
          createdJob.value = CreateJobModel.fromJson(jobData);
          AppLoggerHelper.info(
            'Job created successfully: ${createdJob.value?.id}',
          );
          _showSuccessDialog();
          _resetForm();
        } else {
          EasyLoading.showError('Failed to parse job response');
        }
      } else {
        final errorMessage =
            _extractMessage(response.data) ?? 'Failed to create job';
        AppLoggerHelper.warning('Job creation failed: $errorMessage');
        EasyLoading.showError(errorMessage);
      }
    } on DioException catch (error) {
      EasyLoading.dismiss();
      final errorMessage =
          _extractMessage(error.response?.data) ??
          error.message ??
          'Failed to create job';
      AppLoggerHelper.error('Job creation error', error);
      EasyLoading.showError(errorMessage);
    } catch (error) {
      EasyLoading.dismiss();
      AppLoggerHelper.error('Unexpected job creation error', error);
      EasyLoading.showError('An unexpected error occurred');
    } finally {
      isCreatingJob.value = false;
    }
  }

  Map<String, dynamic>? _extractJobData(dynamic responseData) {
    final responseMap = _asMap(responseData);
    if (responseMap == null) {
      return null;
    }

    final data = _asMap(responseMap['data']);
    if (data != null && data.isNotEmpty) {
      return data;
    }

    return null;
  }

  void _resetForm() {
    jobTitleController.clear();
    jobDescriptionController.clear();
    basePriceController.clear();
    serviceInputController.clear();
    uploadedImagePath.value = '';
    thumbnailUrl.value = '';
    selectedCategory.value = '';
    selectedCategoryId.value = '';
    selectedSpecificService.value = '';
    selectedSubCategoryId.value = '';
    includedServices.assignAll(['Basic cleaning service']);
    priceType.value = 'Fixed';
    currentStep.value = 0;
    isEditMode.value = false;
    editingJobId.value = '';
    editingJob.value = null;
  }

  Future<void> _updateThumbnail(String jobId) async {
    if (uploadedImagePath.value.isEmpty) {
      return;
    }

    try {
      EasyLoading.show(status: 'Uploading image...');

      final token = await SecureStorageService.getToken();
      if (token == null || token.isEmpty) {
        EasyLoading.dismiss();
        EasyLoading.showError("Authentication required. Please login again.");
        return;
      }

      final formData = FormData.fromMap({
        'thumbnail': await MultipartFile.fromFile(
          uploadedImagePath.value,
          filename: uploadedImagePath.value.split('/').last,
        ),
      });

      final response = await _apiClient.patch<dynamic>(
        ApiEndpoints.updateThumbnail(jobId),
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      AppLoggerHelper.info('Update thumbnail response: ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jobData = _extractJobData(response.data);
        if (jobData != null) {
          thumbnailUrl.value = jobData['thumbnail']?.toString() ?? '';
          AppLoggerHelper.info('Thumbnail updated successfully');
        }
      } else {
        final errorMessage =
            _extractMessage(response.data) ?? 'Failed to upload thumbnail';
        AppLoggerHelper.warning('Thumbnail upload failed: $errorMessage');
        EasyLoading.showError(errorMessage);
      }
    } on DioException catch (error) {
      final errorMessage =
          _extractMessage(error.response?.data) ??
          error.message ??
          'Failed to upload thumbnail';
      AppLoggerHelper.error('Thumbnail upload error', error);
      EasyLoading.showError(errorMessage);
    } catch (error) {
      AppLoggerHelper.error('Unexpected thumbnail upload error', error);
      EasyLoading.showError('An unexpected error occurred');
    }
  }

  Future<void> _updateJob() async {
    try {
      isUpdatingJob.value = true;
      EasyLoading.show(status: 'Updating job...');

      final token = await SecureStorageService.getToken();
      if (token == null || token.isEmpty) {
        EasyLoading.dismiss();
        EasyLoading.showError("Authentication required. Please login again.");
        return;
      }

      // First upload thumbnail if new image was selected
      if (uploadedImagePath.value.isNotEmpty) {
        await _updateThumbnail(editingJobId.value);
      }

      // Prepare job update data
      final jobUpdateData = {
        'categoryId': selectedCategoryId.value,
        'subCategoryId': selectedSubCategoryId.value,
        'title': jobTitleController.text.trim(),
        'slug': jobTitleController.text.trim().toLowerCase().replaceAll(' ', '-'),
        'description': jobDescriptionController.text.trim(),
        'basePrice': basePriceController.text.trim(),
        'priceType': priceType.value == "Fixed" ? "FIXED" : priceType.value,
        'includeService': includedServices,
        'thumbnail': thumbnailUrl.value.isNotEmpty ? thumbnailUrl.value : (editingJob.value?.thumbnail ?? ''),
        'features': editingJob.value?.features,
        'images': editingJob.value?.images ?? [],
        'videos': editingJob.value?.videos ?? [],
        'serviceLocation': editingJob.value?.serviceLocation,
        'serviceRadius': editingJob.value?.serviceRadius,
        'status': editingJob.value?.status ?? 'DRAFT',
        'views': editingJob.value?.views ?? 0,
        'clicks': editingJob.value?.clicks ?? 0,
        'totalBookings': editingJob.value?.totalBookings ?? 0,
        'averageRating': editingJob.value?.averageRating,
        'metaTitle': editingJob.value?.metaTitle,
        'metaDescription': editingJob.value?.metaDescription,
        'publishedAt': editingJob.value?.publishedAt,
        'isPopuler': editingJob.value?.isPopuler ?? false,
      };

      final response = await _apiClient.patch<dynamic>(
        ApiEndpoints.updateJob(editingJobId.value),
        data: jobUpdateData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      EasyLoading.dismiss();

      AppLoggerHelper.info('Update job response status: ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jobData = _extractJobData(response.data);
        if (jobData != null) {
          createdJob.value = CreateJobModel.fromJson(jobData);
          AppLoggerHelper.info('Job updated successfully: ${createdJob.value?.id}');
          _showSuccessDialog(isUpdate: true);
          _resetForm();
        } else {
          EasyLoading.showError('Failed to parse job response');
        }
      } else {
        final errorMessage =
            _extractMessage(response.data) ?? 'Failed to update job';
        AppLoggerHelper.warning('Job update failed: $errorMessage');
        EasyLoading.showError(errorMessage);
      }
    } on DioException catch (error) {
      EasyLoading.dismiss();
      final errorMessage =
          _extractMessage(error.response?.data) ??
          error.message ??
          'Failed to update job';
      AppLoggerHelper.error('Job update error', error);
      EasyLoading.showError(errorMessage);
    } catch (error) {
      EasyLoading.dismiss();
      AppLoggerHelper.error('Unexpected job update error', error);
      EasyLoading.showError('An unexpected error occurred');
    } finally {
      isUpdatingJob.value = false;
    }
  }

  /// Delete a job by ID
  Future<bool> deleteJob(String jobId) async {
    try {
      isDeletingJob.value = true;
      EasyLoading.show(status: 'Deleting job...');

      final token = await SecureStorageService.getToken();
      if (token == null || token.isEmpty) {
        AppLoggerHelper.warning('Delete job: token not found');
        EasyLoading.showError('Authentication token not found');
        return false;
      }

      final response = await _apiClient.get<dynamic>(
        ApiEndpoints.deleteJob(jobId),
        options: Options(
          headers: {
            'accept': '*/*',
            'Authorization': 'Bearer $token',
          },
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      AppLoggerHelper.info(
        'Delete job response status: ${response.statusCode}',
      );

      if (response.statusCode == 200) {
        final deleteResponse = DeleteJobResponse.fromJson(response.data);

        if (deleteResponse.success) {
          AppLoggerHelper.info('Job deleted successfully');
          EasyLoading.showSuccess('Job deleted successfully');
          return true;
        } else {
          final errorMessage = deleteResponse.message ?? 'Failed to delete job';
          AppLoggerHelper.warning('Job deletion failed: $errorMessage');
          EasyLoading.showError(errorMessage);
          return false;
        }
      } else {
        final errorMessage =
            _extractMessage(response.data) ?? 'Failed to delete job';
        AppLoggerHelper.warning('Job deletion failed: $errorMessage');
        EasyLoading.showError(errorMessage);
        return false;
      }
    } on DioException catch (error) {
      EasyLoading.dismiss();
      final errorMessage =
          _extractMessage(error.response?.data) ??
          error.message ??
          'Failed to delete job';
      AppLoggerHelper.error('Job deletion error', error);
      EasyLoading.showError(errorMessage);
      return false;
    } catch (error) {
      EasyLoading.dismiss();
      AppLoggerHelper.error('Unexpected job deletion error', error);
      EasyLoading.showError('An unexpected error occurred');
      return false;
    } finally {
      isDeletingJob.value = false;
    }
  }

  void _showSuccessDialog({bool isUpdate = false}) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      Get.back(); // Back to job list screen
                    },
                    child: Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: const BoxDecoration(
                        color: Color(0xFFE2E8F0),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        size: 16.sp,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Container(
                width: 120.w,
                height: 120.w,
                decoration: const BoxDecoration(
                  color: Color(0xFF818CF8),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text('🎉', style: TextStyle(fontSize: 50.sp)),
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                isUpdate
                    ? 'Congratulations! Your Job has been updated.'
                    : 'Congratulations! Your Job has been published.',
                textAlign: TextAlign.center,
                style: getTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF09090B),
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  @override
  void onClose() {
    jobTitleController.dispose();
    jobDescriptionController.dispose();
    basePriceController.dispose();
    serviceInputController.dispose();
    super.onClose();
  }
}
