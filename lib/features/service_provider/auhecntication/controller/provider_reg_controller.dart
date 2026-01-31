import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protiva502/features/service_provider/auhecntication/screen/provider_logo_bio_screen.dart';

class ProviderRegController extends GetxController {
  // Business Information
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

  void handleNext() {
    Get.to(() => const ProviderLogoBioScreen());
  }

  @override
  void onClose() {
    serviceLocationController.dispose();
    yearOfExperienceController.dispose();
    super.onClose();
  }
}
