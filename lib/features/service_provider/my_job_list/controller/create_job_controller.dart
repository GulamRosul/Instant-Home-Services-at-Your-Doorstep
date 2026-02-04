import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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
    if (validateStep()) {
      if (currentStep.value < 2) {
        currentStep.value++;
      }
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
        Get.snackbar(
          "Success",
          "Image selected successfully!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withValues(alpha: 0.1),
          colorText: Colors.green,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to pick image: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.1),
        colorText: Colors.red,
      );
    }
  }

  void publishJob() {
    if (validateStep()) {
      // Logic to save job
      Get.offAllNamed('/jobPublishSuccess');
    }
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
