import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protiva502/features/more_bottom_sheet/more_bottom_sheet.dart';

class BottomNavController extends GetxController {
  // Current active tab index
  var selectedIndex = 0.obs;

  // Change tab with a simple update
  void changeTab(int index) {
    // If "More" tab (index 3) is tapped, show bottom sheet instead
    if (index == 3) {
      _showMoreBottomSheet();
      return;
    }
    selectedIndex.value = index;
  }

  // Show the More bottom sheet
  void _showMoreBottomSheet() {
    Get.bottomSheet(
      const MoreBottomSheet(),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
    );
  }

  // Icons and Labels for the tabs

}
