import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:protiva502/features/user/user_booking_confirmation/screen/confirm_booking_screen.dart';

class BookingDetailsController extends GetxController {
  BookingDetailsController();

  final phoneController = TextEditingController(text: "+12505550199");
  final preferredDateTimeController = TextEditingController();
  final locationController = TextEditingController(
    text: "123 Main Street, Ontario",
  );
  final messageController = TextEditingController();
  final selectedPreferredDateTime = Rxn<DateTime>();

  var selectedLocationType = "My Location".obs; // Radio button state
  var isAgreed = false.obs;

  void selectLocation(String value) {
    selectedLocationType.value = value;
  }

  Future<void> pickPreferredDateTime(BuildContext context) async {
    final now = DateTime.now();
    final initialDate =
        selectedPreferredDateTime.value ?? now.add(const Duration(minutes: 30));

    final pickedDateTime = await showOmniDateTimePicker(
      context: context,
      type: OmniDateTimePickerType.dateAndTime,
      initialDate: initialDate.isBefore(now) ? now : initialDate,
      firstDate: DateTime(now.year, now.month, now.day),
      lastDate: now.add(const Duration(days: 365)),
      is24HourMode: false,
      isShowSeconds: false,
      minutesInterval: 5,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      title: const Text("Select Date & Time"),
    );

    if (pickedDateTime == null) {
      return;
    }

    selectedPreferredDateTime.value = pickedDateTime;
    preferredDateTimeController.text = DateFormat(
      'dd MMM yyyy || hh:mm a',
    ).format(pickedDateTime);
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
    preferredDateTimeController.dispose();
    locationController.dispose();
    messageController.dispose();
    super.onClose();
  }
}
