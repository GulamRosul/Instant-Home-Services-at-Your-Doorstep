import 'package:get/get.dart';
import 'package:protiva502/core/utils/constants/icon_path.dart';

class BottomNavController extends GetxController {
  // Current active tab index
  var selectedIndex = 0.obs;

  // Change tab with a simple update
  void changeTab(int index) {
    selectedIndex.value = index;
  }

  // Icons and Labels for the tabs
  final List<Map<String, dynamic>> navItems = [
    {'icon': IconPath.home, 'label': 'Home'},
    {'icon': IconPath.booking, 'label': 'Booking'},
    {'icon': IconPath.notification, 'label': 'Notification'},
    {'icon': IconPath.more, 'label': 'More'},
  ];
}
