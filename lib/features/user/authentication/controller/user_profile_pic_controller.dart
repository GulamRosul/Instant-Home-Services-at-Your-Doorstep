import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart' as dio_package;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:protiva502/core/services/api_client.dart';
import 'package:protiva502/core/utils/constants/apiendpoint.dart';
import 'package:protiva502/core/utils/helpers/app_helper.dart';
import 'package:protiva502/features/user/authentication/controller/user_reg_controller.dart';
import 'package:protiva502/features/user/authentication/screen/user_otp_screen.dart';

class UserProfilePicController extends GetxController {
  UserProfilePicController({ApiClient? apiClient})
    : _apiClient = apiClient ?? ApiClient();

  final ApiClient _apiClient;
  final bioController = TextEditingController();
  final Rx<File?> selectedImage = Rx<File?>(null);
  final isLoading = false.obs;

  // Function to pick image using the helper dialog
  Future<void> pickImage(BuildContext context) async {
    try {
      final XFile? pickedFile =
          await AppHelperFunctions.showImageSourceDialog();

      if (pickedFile != null) {
        selectedImage.value = File(pickedFile.path);
      }
    } catch (e) {
      _showSnackBar('error'.tr, '${'failed_pick_image'.tr}: ${e.toString()}');
    }
  }

  Future<void> handleNext({String? registeredEmail}) async {
    final regController = Get.find<UserRegController>();

    if (isLoading.value) {
      return;
    }

    final fullPhone =
        '${regController.selectedCountryCode.value}${regController.phoneController.text.trim()}';

    try {
      isLoading.value = true;

      final formData = dio_package.FormData.fromMap({
        'firstName': regController.firstNameController.text.trim(),
        'lastName': regController.lastNameController.text.trim(),
        'email': regController.emailController.text.trim(),
        'password': regController.passwordController.text,
        'phone': fullPhone,
        'city': regController.cityController.text.trim(),
        if (bioController.text.trim().isNotEmpty)
          'bio': bioController.text.trim(),
        if (selectedImage.value != null)
          'avatar': await dio_package.MultipartFile.fromFile(
            selectedImage.value!.path,
            filename: selectedImage.value!.path.split('/').last,
          ),
      });

      log('Registering user with avatar and city');

      final response = await _apiClient.post<dynamic>(
        ApiEndpoints.clientRegistration,
        data: formData,
        options: dio_package.Options(contentType: 'multipart/form-data'),
      );

      final statusCode = response.statusCode ?? 0;
      log(
        'Registration response. Status code: $statusCode, response: ${response.data}',
      );

      if (statusCode < 200 || statusCode >= 300) {
        final errorMessage =
            _extractMessage(response.data) ??
            'registration_failed_try_again'.tr;

        _showSnackBar('registration_failed'.tr, errorMessage);
        return;
      }

      final message =
          _extractMessage(response.data) ?? 'registration_success'.tr;

      _showSnackBar('success'.tr, message);
      Get.to(() => UserOtpScreen(email: registeredEmail));
    } on dio_package.DioException catch (error, stackTrace) {
      log('Registration failed', error: error, stackTrace: stackTrace);

      final errorMessage =
          _extractMessage(error.response?.data) ??
          error.message ??
          'registration_failed_try_again'.tr;

      _showSnackBar('registration_failed'.tr, errorMessage);
    } catch (error, stackTrace) {
      log(
        'Unexpected registration error',
        error: error,
        stackTrace: stackTrace,
      );
      _showSnackBar('registration_failed'.tr, 'something_went_wrong'.tr);
    } finally {
      isLoading.value = false;
    }
  }

  String? _extractMessage(dynamic responseData) {
    final responseMap = _asMap(responseData);
    if (responseMap == null) {
      return null;
    }

    final data = _asMap(responseMap['data']);
    final nestedMessage = data?['message'];
    if (nestedMessage is String && nestedMessage.trim().isNotEmpty) {
      return nestedMessage;
    }

    if (nestedMessage is List && nestedMessage.isNotEmpty) {
      final joined = nestedMessage
          .map((item) => item.toString().trim())
          .where((item) => item.isNotEmpty)
          .join(', ');
      if (joined.isNotEmpty) {
        return joined;
      }
    }

    final message = responseMap['message'];
    if (message is String && message.trim().isNotEmpty) {
      return message;
    }

    if (message is List && message.isNotEmpty) {
      final joined = message
          .map((item) => item.toString().trim())
          .where((item) => item.isNotEmpty)
          .join(', ');
      if (joined.isNotEmpty) {
        return joined;
      }
    }

    final error = responseMap['error'];
    if (error is String && error.trim().isNotEmpty) {
      return error;
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

  void _showSnackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(12),
    );
  }

  @override
  void onClose() {
    bioController.dispose();
    super.onClose();
  }
}
