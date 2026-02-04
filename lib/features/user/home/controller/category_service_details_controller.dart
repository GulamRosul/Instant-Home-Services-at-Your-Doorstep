import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protiva502/features/user/user_booking_confirmation/screen/booking_details_screen.dart';

class CategoryServiceDetailsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  // Observable for current tab index
  var activeTabIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize TabController with 2 tabs
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      activeTabIndex.value = tabController.index;
    });
  }

  void handleBooking() {
    // print("Proceeding to booking...");
    Get.to(() => BookingDetailsScreen());
  }

  void handleMessaging() {
    print("Opening chat with provider...");
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
