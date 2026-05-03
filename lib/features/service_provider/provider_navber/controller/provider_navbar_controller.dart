import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protiva502/features/more_bottom_sheet/more_bottom_sheet.dart';

class ProviderNavbarController extends GetxController {
  // Current active tab index
  var selectedIndex = 0.obs;

  // Change tab
  void changeTab(int index) {
    if (index == 4) {
      _showMoreBottomSheet();
      return;
    }
    selectedIndex.value = index;
  }

  void setSelectedIndex(int index) {
    selectedIndex.value = index;
  }

  // Handle sub-pages (like Wallet) while keeping the navbar
  var homeSubPage = Rxn<Widget>();

  void showHomeSubPage(Widget page) {
    homeSubPage.value = page;
  }

  void resetHomeSubPage() {
    homeSubPage.value = null;
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
  // final List<Map<String, dynamic>> navItems = [
  //   {'label': 'home'.tr},
  //   {'label': 'my_job'.tr},
  //   {'label': 'bookings'.tr},
  //   {'label': 'notification'.tr},
  //   {'label': 'more'.tr},
  // ];
}
