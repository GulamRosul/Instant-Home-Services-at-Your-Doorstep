import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:protiva502/core/utils/helpers/app_helper.dart';
import 'package:protiva502/features/service_provider/auhecntication/screen/provider_login_screen.dart';
import 'package:protiva502/features/service_provider/auhecntication/screen/provider_logo_bio_screen.dart';
import 'package:protiva502/features/service_provider/auhecntication/screen/provider_registration.dart';

class ProviderRegController extends GetxController {
  static const String _baseUrl = 'https://protiva-backend.onrender.com/api/v1';
  static const String _registerEndpoint = '$_baseUrl/auth/register';
  static const String _providerRole = 'PROVIDER';

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
  final isRegistering = false.obs;

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
    if (!_validateStepOne()) return;
    Get.to(() => const ProviderRegistration());
  }

  Future<void> handleNext2() async {
    if (!_validateStepTwo()) return;
    if (isRegistering.value) return;

    isRegistering.value = true;

    final nameParts = _splitName(companyNameController.text.trim());
    final payload = {
      'firstName': nameParts.$1,
      'lastName': nameParts.$2,
      'email': emailController.text.trim(),
      'phone': phoneController.text.trim(),
      'password': passwordController.text,
      'role': _providerRole,
    };

    final uri = Uri.parse(_registerEndpoint);
    final body = jsonEncode(payload);

    debugPrint('Provider register URL => $uri');
    debugPrint('Provider register body => $body');
    log('Provider register URL => $uri', name: 'ProviderRegister');
    log('Provider register body => $body', name: 'ProviderRegister');

    try {
      final response = await http.post(
        uri,
        headers: const {'accept': '*/*', 'Content-Type': 'application/json'},
        body: body,
      );

      debugPrint('Provider register status => ${response.statusCode}');
      debugPrint('Provider register response => ${response.body}');
      log(
        'Provider register status => ${response.statusCode}',
        name: 'ProviderRegister',
      );
      log(
        'Provider register response => ${response.body}',
        name: 'ProviderRegister',
      );

      final responseData = _tryDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final message =
            responseData?['data']?['message']?.toString() ??
            'Registration successful';

        Get.snackbar('Success', message);
        Get.to(() => const ProviderLogoBioScreen());
      } else {
        Get.snackbar('Registration failed', _extractMessage(responseData));
      }
    } catch (error, stackTrace) {
      debugPrint('Provider register error => $error');
      log(
        'Provider register error => $error',
        name: 'ProviderRegister',
        stackTrace: stackTrace,
      );
      Get.snackbar('Registration failed', 'Could not connect to the server');
    } finally {
      isRegistering.value = false;
    }
  }

  void goToLogin() {
    Get.off(() => const ProviderLoginScreen());
  }

  bool _validateStepOne() {
    if (emailController.text.trim().isEmpty ||
        phoneController.text.trim().isEmpty ||
        companyNameController.text.trim().isEmpty ||
        nidNumberController.text.trim().isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      Get.snackbar('Missing info', 'Please fill in all required fields');
      return false;
    }

    if (!GetUtils.isEmail(emailController.text.trim())) {
      Get.snackbar('Invalid email', 'Please enter a valid email address');
      return false;
    }

    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar(
        'Password mismatch',
        'Password and confirm password must match',
      );
      return false;
    }

    if (passwordController.text.length < 8) {
      Get.snackbar('Weak password', 'Password must be at least 8 characters');
      return false;
    }

    return true;
  }

  bool _validateStepTwo() {
    if (serviceLocationController.text.trim().isEmpty ||
        yearOfExperienceController.text.trim().isEmpty) {
      Get.snackbar('Missing info', 'Please complete business information');
      return false;
    }

    return true;
  }

  (String, String) _splitName(String fullName) {
    final parts = fullName
        .split(RegExp(r'\s+'))
        .where((e) => e.isNotEmpty)
        .toList();
    if (parts.isEmpty) return ('Provider', 'User');
    if (parts.length == 1) return (parts.first, 'Provider');
    return (parts.first, parts.sublist(1).join(' '));
  }

  Map<String, dynamic>? _tryDecode(String source) {
    try {
      final decoded = jsonDecode(source);
      return decoded is Map<String, dynamic> ? decoded : null;
    } catch (_) {
      return null;
    }
  }

  String _extractMessage(Map<String, dynamic>? responseData) {
    return responseData?['message']?.toString() ??
        responseData?['data']?['message']?.toString() ??
        responseData?['error']?.toString() ??
        'Something went wrong';
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
