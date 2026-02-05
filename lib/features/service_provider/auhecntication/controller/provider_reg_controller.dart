import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:protiva502/core/utils/helpers/app_helper.dart';
import 'package:protiva502/features/service_provider/auhecntication/screen/provider_logo_bio_screen.dart';
import 'package:protiva502/features/service_provider/auhecntication/screen/provider_registration.dart';

class ProviderRegController extends GetxController {
  // Personal Information
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final companyNameController = TextEditingController();
  final nidNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final Rx<XFile?> nidImage = Rx<XFile?>(null);
  final Rx<XFile?> faceVerificationImage = Rx<XFile?>(null);

  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;

  // Business Information (Existing or for later steps)
  final serviceLocationController = TextEditingController();
  final yearOfExperienceController = TextEditingController();

  final selectedServiceCategory = 'Handyman'.obs;
  final selectedSubCategory = 'Handyman'.obs;

  final List<String> serviceCategories = [
    'Handyman',
    'Electrician',
    'Plumber',
    'Painter',
    'Cleaner',
    'Technician',
  ];

  final List<String> subCategories = [
    'Handyman',
    'General Repair',
    'Assembly',
    'Mounting',
  ];

  void onServiceCategoryChanged(String? value) {
    if (value != null) selectedServiceCategory.value = value;
  }

  void onSubCategoryChanged(String? value) {
    if (value != null) selectedSubCategory.value = value;
  }

  Future<void> pickNidImage() async {
    final XFile? image = await AppHelperFunctions.showImageSourceDialog();
    if (image != null) {
      nidImage.value = image;
    }
  }

  Future<void> pickFaceVerificationImage() async {
    final XFile? image = await AppHelperFunctions.showImageSourceDialog();
    if (image != null) {
      faceVerificationImage.value = image;
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void handleNext() {
    // Validation logic can go here
    Get.to(() => const ProviderRegistration());
  }

  void handleNext2() {
    // Validation logic can go here
    Get.to(() => const ProviderLogoBioScreen());
  }

  @override
  void onClose() {
    emailController.dispose();
    phoneController.dispose();
    companyNameController.dispose();
    nidNumberController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    serviceLocationController.dispose();
    yearOfExperienceController.dispose();
    super.onClose();
  }
}
