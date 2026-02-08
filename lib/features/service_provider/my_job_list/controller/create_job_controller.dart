import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';

class CreateJobController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  // Step Management
  var currentStep = 0.obs;

  // Step 1: Job Details
  final jobTitleController = TextEditingController();
  var selectedCategory = "".obs;
  var selectedSpecificService = "".obs;
  final jobDescriptionController = TextEditingController();
  final basePriceController = TextEditingController();
  var priceType = "Fixed".obs;

  // Step 2: Service Details
  var includedServices = <String>["Basic cleaning service"].obs;
  final serviceInputController = TextEditingController();
  var uploadedImagePath = "".obs;

  // Categories and Services Mock
  final categories = ["Home Improvement", "Cleaning", "Plumbing", "Electrical"];
  final specificServices = ["Installation", "Repair", "Maintenance"];

  bool validateStep() {
    if (currentStep.value == 0) {
      if (jobTitleController.text.trim().isEmpty) {
        EasyLoading.showError("Please enter job title");
        return false;
      }
      if (selectedCategory.value.isEmpty) {
        EasyLoading.showError("Please select a category");
        return false;
      }
      if (selectedSpecificService.value.isEmpty) {
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
