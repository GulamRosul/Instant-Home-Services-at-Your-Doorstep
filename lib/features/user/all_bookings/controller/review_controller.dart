import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:protiva502/core/services/api_client.dart';
import 'package:protiva502/core/services/secure_storage_service.dart';
import 'package:protiva502/core/services/storage_service.dart';
import 'package:protiva502/core/utils/constants/apiendpoint.dart';
import 'package:protiva502/core/utils/logging/logger.dart';

class ReviewController extends GetxController {
  final TextEditingController feedbackController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final ApiClient _apiClient = ApiClient();

  // Observable states
  var rating = 0.obs;
  var selectedImages = <File>[].obs;
  var isSubmitting = false.obs;
  var errorMessage = ''.obs;

  // Data passed from booking context
  late String bookingId;
  late String receiverId;
  late String jobId;

  void initializeWithBookingData({
    required String bookingId,
    required String receiverId,
    required String jobId,
  }) {
    this.bookingId = bookingId;
    this.receiverId = receiverId;
    this.jobId = jobId;
  }

  void updateRating(int newRating) {
    rating.value = newRating;
  }

  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      selectedImages.add(File(image.path));
    }
  }

  void removeImage(int index) {
    selectedImages.removeAt(index);
  }

  Future<void> submitReview() async {
    if (rating.value == 0) {
      Get.snackbar('error'.tr, 'please_select_rating'.tr);
      return;
    }

    if (feedbackController.text.trim().isEmpty) {
      Get.snackbar('error'.tr, 'please_add_feedback'.tr);
      return;
    }

    try {
      isSubmitting.value = true;
      errorMessage.value = '';

      final token = await SecureStorageService.getToken();
      if (token == null || token.isEmpty) {
        errorMessage.value = 'please_sign_in'.tr;
        Get.snackbar('error'.tr, errorMessage.value);
        return;
      }

      final userId = StorageService.getUserId();
      if (userId == null || userId.isEmpty) {
        errorMessage.value = 'user_not_found'.tr;
        Get.snackbar('error'.tr, errorMessage.value);
        return;
      }

      final formData = FormData();
      formData.fields.addAll([
        MapEntry('bookingId', bookingId),
        MapEntry('receiverId', receiverId),
        MapEntry('jobId', jobId),
        MapEntry('rating', rating.value.toString()),
        MapEntry('comment', feedbackController.text.trim()),
      ]);

      AppLoggerHelper.info(
        '📤 [REVIEW] Submitting review with data:\n'
        '  bookingId: $bookingId\n'
        '  receiverId: $receiverId\n'
        '  jobId: $jobId\n'
        '  rating: ${rating.value}\n'
        '  comment: ${feedbackController.text.trim()}\n'
        '  images: ${selectedImages.length}',
      );

      if (selectedImages.isNotEmpty) {
        final imageFile = selectedImages.first;
        formData.files.add(
          MapEntry(
            'image',
            await MultipartFile.fromFile(
              imageFile.path,
              filename: imageFile.path.split('/').last,
            ),
          ),
        );
        AppLoggerHelper.info('📸 Image added: ${imageFile.path.split('/').last}');
      }

      final response = await _apiClient.post<dynamic>(
        ApiEndpoints.postReview,
        data: formData,
        options: Options(
          headers: {'Accept': '*/*', 'Authorization': 'Bearer $token'},
          contentType: 'multipart/form-data',
        ),
      );

      AppLoggerHelper.info(
        '📡 [REVIEW API] Response received:\n'
        '  Status: ${response.statusCode}\n'
        '  Endpoint: ${ApiEndpoints.postReview}\n'
        '  Response: ${response.data}',
      );

      final responseMap = _asMap(response.data) ?? {};
      final data = _asMap(responseMap['data']);

      if (response.statusCode == 201 &&
          data != null &&
          data['success'] == true) {
        AppLoggerHelper.info('Review submitted successfully: ${response.data}');
        Get.snackbar(
          'success'.tr,
          'review_submitted_successfully'.tr,
          backgroundColor: const Color(0xFF22C55E),
          colorText: Colors.white,
        );
        Get.back();
        _resetForm();
      } else {
        final message =
            _extractMessage(response.data) ?? 'failed_to_submit_review'.tr;
        errorMessage.value = message;
        Get.snackbar('error'.tr, message);
        AppLoggerHelper.warning('Review submission failed: ${response.data}');
      }
    } on DioException catch (error) {
      final message =
          _extractMessage(error.response?.data) ??
          error.message ??
          'failed_to_submit_review'.tr;
      errorMessage.value = message;
      Get.snackbar('error'.tr, message);
      AppLoggerHelper.error('Review submission DioException', error);
    } catch (error) {
      const message = 'failed_to_submit_review';
      errorMessage.value = message;
      Get.snackbar('error'.tr, message);
      AppLoggerHelper.error('Review submission unexpected error', error);
    } finally {
      isSubmitting.value = false;
    }
  }

  void _resetForm() {
    rating.value = 0;
    feedbackController.clear();
    selectedImages.clear();
    errorMessage.value = '';
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

  @override
  void onClose() {
    feedbackController.dispose();
    super.onClose();
  }
}
