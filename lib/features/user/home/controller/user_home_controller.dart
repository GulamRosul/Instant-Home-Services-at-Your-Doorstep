import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/utils/constants/icon_path.dart';

class UserHomeController extends GetxController {
  // For the banner carousel dots
  var currentBannerIndex = 0.obs;
  final PageController bannerController = PageController();

  // Mock data for categories
  final List<Map<String, String>> categories = [
    {'name': 'Electrician', 'icon': IconPath.electrician},
    {'name': 'Mechanic', 'icon': IconPath.mechanic},
    {'name': 'Plumber', 'icon': IconPath.plumber},
    {'name': 'Carpenter', 'icon': IconPath.carpenter},
    {'name': 'Automotive', 'icon': IconPath.automotive},
    {'name': 'Cleaner', 'icon': IconPath.cleaner},
    {'name': 'Painter', 'icon': IconPath.painter},
    {'name': 'Technician', 'icon': IconPath.technician},
  ];

  void updateBannerIndex(int index) {
    currentBannerIndex.value = index;
  }
}
