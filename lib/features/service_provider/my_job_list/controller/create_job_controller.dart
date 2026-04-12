import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/services/api_client.dart';
import 'package:protiva502/core/utils/constants/apiendpoint.dart';
import 'package:protiva502/core/utils/logging/logger.dart';
import 'package:protiva502/features/user/home/model/categories_model.dart';
import 'package:protiva502/features/user/home/model/sub_category_model.dart';

class CreateJobController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  final ApiClient _apiClient = ApiClient();

  // Step Management
  var currentStep = 0.obs;

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

  // Categories and Services Observable
  final isCategoriesLoading = false.obs;
  final categoriesErrorMessage = ''.obs;
  final categories = <CategoryModel>[].obs;

  final isSubCategoriesLoading = false.obs;
  final subCategoriesErrorMessage = ''.obs;
  final subCategories = <SubCategoryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
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
      // Logic to save job
      _showSuccessDialog();
    }
  }

  void _showSuccessDialog() {
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
                'Congratulations! Your Job has been published.',
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
