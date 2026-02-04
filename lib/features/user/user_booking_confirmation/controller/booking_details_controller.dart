import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protiva502/features/user/user_booking_confirmation/screen/confirm_booking_screen.dart';

class BookingDetailsController extends GetxController {
  final phoneController = TextEditingController(text: "+12505550199");
  final locationController = TextEditingController(
    text: "123 Main Street, Ontario",
  );
  final messageController = TextEditingController();

  var selectedLocationType = "My Location".obs; // Radio button state
  var isAgreed = false.obs;

  void selectLocation(String value) {
    selectedLocationType.value = value;
  }

  void goToNextStep() {
    if (isAgreed.value) {
      // Navigate to Confirm Screen
      // print("Proceeding to Confirm step...");
      Get.to(() => ConfirmBookingScreen());
    } else {
      // Get.snackbar("Notice", "Please agree to the Terms of Service");
    }
  }

  @override
  void onClose() {
    phoneController.dispose();
    locationController.dispose();
    messageController.dispose();
    super.onClose();
  }
}
