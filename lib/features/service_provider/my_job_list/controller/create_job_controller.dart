import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateJobController extends GetxController {
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

  void nextStep() {
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

  void pickImage() {
    // Mock image picking
    uploadedImagePath.value = "assets/images/placeholder.png";
    Get.snackbar("Success", "Image uploaded successfully!");
  }

  void publishJob() {
    // Logic to save job
    Get.offAllNamed('/jobPublishSuccess');
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
