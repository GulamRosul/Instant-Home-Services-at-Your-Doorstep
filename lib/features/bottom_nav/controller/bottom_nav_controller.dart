import 'package:get/get.dart';

class BottomNavController extends GetxController {
  // Current active tab index
  var selectedIndex = 0.obs;

  // Change tab with a simple update
  void changeTab(int index) {
    selectedIndex.value = index;
  }

  // Icons and Labels for the tabs
  final List<Map<String, dynamic>> navItems = [
    {'icon': 'assets/icons/home.png', 'label': 'Home'},
    {'icon': 'assets/icons/booking.png', 'label': 'Booking'},
    {'icon': 'assets/icons/notification.png', 'label': 'Notification'},
    {'icon': 'assets/icons/more.png', 'label': 'More'},
  ];
}