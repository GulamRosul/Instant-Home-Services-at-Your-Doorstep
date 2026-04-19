import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:protiva502/core/utils/helpers/app_helper.dart';
import 'package:protiva502/core/utils/logging/logger.dart';
import 'package:protiva502/features/service_provider/auhecntication/screen/provider_login_screen.dart';
import 'package:protiva502/features/service_provider/auhecntication/screen/provider_logo_bio_screen.dart';
import 'package:protiva502/features/service_provider/auhecntication/screen/provider_registration.dart';

class ProviderRegController extends GetxController {
  static const String _baseUrl =
      'https://protiva-backend-ukw2.onrender.com/api/v1';
  static const String _addProviderEndpoint = '$_baseUrl/auth/add-provider';
  static const int maxBioLength = 300;

  // Personal Information
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final companyNameController = TextEditingController();
  final nidNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final Rx<XFile?> nidImage = Rx<XFile?>(null);
  final Rx<XFile?> avatarImage = Rx<XFile?>(null);
  final Rx<XFile?> faceVerificationImage = Rx<XFile?>(null);

  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;
  final isRegistering = false.obs;
  final bioCharCount = 0.obs;

  // Business Information (Existing or for later steps)
  final serviceLocationController = TextEditingController();
  final cityController = TextEditingController();
  final yearOfExperienceController = TextEditingController();
  final bioController = TextEditingController();

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

  Future<void> pickAvatarImage() async {
    final XFile? image = await AppHelperFunctions.showImageSourceDialog();
    if (image != null) {
      avatarImage.value = image;
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void updateBioCount(int count) {
    bioCharCount.value = count;
  }

  void handleNext() {
    if (!_validateStepOne()) return;
    Get.to(() => const ProviderRegistration());
  }

  Future<void> handleNext2() async {
    if (!_validateStepTwo()) return;
    Get.to(() => const ProviderLogoBioScreen());
  }

  Future<void> submitProviderRegistration() async {
    if (!_validateFinalStep()) return;
    if (isRegistering.value) return;

    isRegistering.value = true;

    final nameParts = _splitName(companyNameController.text.trim());
    final request = http.MultipartRequest(
      'POST',
      Uri.parse(_addProviderEndpoint),
    );

    request.headers['accept'] = '*/*';
    request.fields.addAll({
      'firstName': nameParts.$1,
      'lastName': nameParts.$2,
      'email': emailController.text.trim(),
      'phone': phoneController.text.trim(),
      'password': passwordController.text,
      'serviceLocation': serviceLocationController.text.trim(),
      'yearOfExprience': yearOfExperienceController.text.trim(),
      'city': cityController.text.trim(),
      'nidNumber': nidNumberController.text.trim(),
    });

    final bio = bioController.text.trim();
    if (bio.isNotEmpty) {
      request.fields['bio'] = bio;
    }

    if (nidImage.value != null) {
      request.files.add(
        await http.MultipartFile.fromPath('nidImage', nidImage.value!.path),
      );
    }

    if (avatarImage.value != null) {
      request.files.add(
        await http.MultipartFile.fromPath('avatar', avatarImage.value!.path),
      );
    }

    AppLoggerHelper.info('Provider register URL => ${request.url}');
    AppLoggerHelper.info(
      'Provider register fields => ${jsonEncode(request.fields)}',
    );
    AppLoggerHelper.info(
      'Provider register files => ${request.files.map((file) => file.field).toList()}',
    );

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      AppLoggerHelper.info(
        'Provider register status => ${response.statusCode}',
      );
      AppLoggerHelper.info('Provider register response => ${response.body}');

      final responseData = _tryDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final message =
            responseData?['message']?.toString() ??
            'Provider registration successful';

        Get.snackbar('Success', message);
        _resetForm();
        Get.offAll(() => const ProviderLoginScreen());
      } else {
        AppLoggerHelper.warning(
          'Provider registration failed: ${_extractMessage(responseData)}',
        );
        Get.snackbar('Registration failed', _extractMessage(responseData));
      }
    } catch (error, stackTrace) {
      AppLoggerHelper.error(
        'Provider register error: $error\n$stackTrace',
        error,
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

    if (nidImage.value == null) {
      Get.snackbar('Missing info', 'Please upload your NID image');
      return false;
    }

    return true;
  }

  bool _validateStepTwo() {
    if (serviceLocationController.text.trim().isEmpty ||
        cityController.text.trim().isEmpty ||
        yearOfExperienceController.text.trim().isEmpty) {
      Get.snackbar('Missing info', 'Please complete business information');
      return false;
    }

    return true;
  }

  bool _validateFinalStep() {
    if (!_validateStepOne() || !_validateStepTwo()) {
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
        responseData?['error']?['message']?.toString() ??
        responseData?['error']?.toString() ??
        'Something went wrong';
  }

  void _resetForm() {
    emailController.clear();
    phoneController.clear();
    companyNameController.clear();
    nidNumberController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    serviceLocationController.clear();
    cityController.clear();
    yearOfExperienceController.clear();
    bioController.clear();
    nidImage.value = null;
    avatarImage.value = null;
    faceVerificationImage.value = null;
    bioCharCount.value = 0;
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
    cityController.dispose();
    yearOfExperienceController.dispose();
    bioController.dispose();
    super.onClose();
  }
}
