import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:protiva502/features/user/home/model/home_job_model.dart';
import 'package:protiva502/features/user/user_booking_confirmation/model/booking_confirmation_data.dart';
import 'package:protiva502/features/user/user_booking_confirmation/screen/confirm_booking_screen.dart';

class BookingDetailsController extends GetxController {
  BookingDetailsController();

  final phoneController = TextEditingController();
  final preferredDateTimeController = TextEditingController();
  final locationController = TextEditingController();
  final messageController = TextEditingController();
  final selectedPreferredDateTime = Rxn<DateTime>();
  final selectedCountryCode = "+1".obs;
  final selectedLocationLatitude = RxnDouble();
  final selectedLocationLongitude = RxnDouble();

  var selectedLocationType = "My Location".obs; // Radio button state
  var isAgreed = false.obs;

  void selectLocation(String value) {
    selectedLocationType.value = value;
  }

  void updateCountryCode(String dialCode) {
    if (dialCode.trim().isEmpty) {
      return;
    }
    selectedCountryCode.value = dialCode;
  }

  String get fullPhoneNumber =>
      '${selectedCountryCode.value}${phoneController.text.trim()}';

  void updateSelectedLocation({
    required String address,
    required double latitude,
    required double longitude,
  }) {
    locationController.text = address;
    selectedLocationLatitude.value = latitude;
    selectedLocationLongitude.value = longitude;
  }

  BookingConfirmationData buildBookingConfirmationData(HomeJobModel? service) {
    return BookingConfirmationData(
      service: service,
      preferredDateTime: selectedPreferredDateTime.value!,
      phoneNumber: fullPhoneNumber,
      locationType: selectedLocationType.value,
      locationLatitude: selectedLocationLatitude.value!,
      locationLongitude: selectedLocationLongitude.value!,
      locationDetails: locationController.text.trim(),
      message: messageController.text.trim(),
    );
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
      title: const Text("\nSelect Date & Time"),
      barrierColor: Colors.white.withValues(alpha: 0.8),
      // backgroundColor: Colors.white,
      // theme: ThemeData.light(),
      theme: ThemeData(
        colorScheme: const ColorScheme.light(surface: Colors.white),
        dialogTheme: DialogThemeData(backgroundColor: Colors.white),
      ),
    );

    if (pickedDateTime == null) {
      return;
    }

    selectedPreferredDateTime.value = pickedDateTime;
    preferredDateTimeController.text = DateFormat(
      'dd MMM yyyy || hh:mm a',
    ).format(pickedDateTime);
  }

  String? validateBookingDetails() {
    if (serviceMissingMessage != null) {
      return serviceMissingMessage;
    }

    if (selectedPreferredDateTime.value == null) {
      return 'Please select your preferred date and time';
    }

    if (phoneController.text.trim().isEmpty) {
      return 'Please enter your phone number';
    }

    if (locationController.text.trim().isEmpty) {
      return 'Please select your location details';
    }

    if (selectedLocationLatitude.value == null ||
        selectedLocationLongitude.value == null) {
      return 'Please pick your location from the map';
    }

    if (!isAgreed.value) {
      return 'Please agree to the Terms of Service';
    }

    return null;
  }

  void goToNextStep(HomeJobModel? service) {
    final validationMessage = validateBookingDetailsFor(service);
    if (validationMessage != null) {
      Get.snackbar(
        'Incomplete Information',
        validationMessage,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(12),
      );
      return;
    }

    final bookingData = buildBookingConfirmationData(service);
    Get.to(() => ConfirmBookingScreen(bookingData: bookingData));
  }

  String? validateBookingDetailsFor(HomeJobModel? service) {
    serviceMissingMessage = null;

    if (service == null) {
      serviceMissingMessage = 'Please select a service before continuing';
    } else if (service.id.trim().isEmpty || service.userId.trim().isEmpty) {
      serviceMissingMessage =
          'This service is missing provider information. Please try another one.';
    }

    return validateBookingDetails();
  }

  String? serviceMissingMessage;

  @override
  void onClose() {
    phoneController.dispose();
    preferredDateTimeController.dispose();
    locationController.dispose();
    messageController.dispose();
    super.onClose();
  }
}
