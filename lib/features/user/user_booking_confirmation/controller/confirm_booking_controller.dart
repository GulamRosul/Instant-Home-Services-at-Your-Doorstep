import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protiva502/features/bottom_nav/controller/bottom_nav_controller.dart';
import 'package:protiva502/features/bottom_nav/screen/main_navigation_screen.dart';
import 'package:protiva502/features/user/user_booking_confirmation/screen/payment_screen.dart';

class ConfirmBookingController extends GetxController {
  // You can pass the booking data from the previous screen via Get.arguments
  final bookingData = Get.arguments;

  void confirmBooking() {
    // Navigate to payment screen
    Get.to(() => const PaymentScreen());
  }

  void goToHome() {
    // Navigates back to the Main Navigation Screen (where the bottom nav bar is)
    // and clears the booking stack.
    // Get.offAllNamed('/main-nav');
    Get.offAll(() => const MainNavigationScreen());
  }

  void viewBookings() {
    // Logic to navigate to the specific Booking tab
    // Get.offAllNamed('/main-nav', arguments: {'index': 1});

    Get.offAll(() => const MainNavigationScreen());
    // Switch to bookings tab (index 1) after navigation
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final navController = Get.find<BottomNavController>();
      navController.changeTab(1);
    });
  }
}
