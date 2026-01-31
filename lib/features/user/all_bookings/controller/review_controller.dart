import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ReviewController extends GetxController {
  final TextEditingController feedbackController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  
  // Observable states
  var rating = 0.obs;
  var selectedImages = <File>[].obs;

  void updateRating(int newRating) {
    rating.value = newRating;
  }

  // Pick image from Gallery or Camera
  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      selectedImages.add(File(image.path));
    }
  }

  void removeImage(int index) {
    selectedImages.removeAt(index);
  }

  void submitReview() {
    // Logic to send rating.value, feedbackController.text, and selectedImages to API
    print("Submitting Rating: ${rating.value}");
    print("Feedback: ${feedbackController.text}");
    print("Images attached: ${selectedImages.length}");
    Get.back(); // Close dialog
  }

  @override
  void onClose() {
    feedbackController.dispose();
    super.onClose();
  }
}