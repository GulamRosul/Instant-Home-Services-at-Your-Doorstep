import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:protiva502/core/utils/helpers/app_helper.dart';
import 'package:protiva502/features/user/authentication/screen/user_otp_screen.dart';
import 'package:protiva502/routes/app_routes.dart';

class UserProfilePicController extends GetxController {
  final bioController = TextEditingController();
  final Rx<File?> selectedImage = Rx<File?>(null);

  // Function to pick image using the helper dialog
  Future<void> pickImage(BuildContext context) async {
    try {
      final XFile? pickedFile =
          await AppHelperFunctions.showImageSourceDialog();

      if (pickedFile != null) {
        selectedImage.value = File(pickedFile.path);
      }
    } catch (e) {
      AppHelperFunctions.showSnackBar('Failed to pick image: ${e.toString()}');
    }
  }

  void handleNext() {
    // // Logic for next step
    // debugPrint("Bio: ${bioController.text}");
    // debugPrint("Image Path: ${selectedImage.value?.path}");
    // Get.toNamed(AppRoute.getUserOtpScreen());
    Get.to(() => UserOtpScreen());
  }

  @override
  void onClose() {
    bioController.dispose();
    super.onClose();
  }
}
