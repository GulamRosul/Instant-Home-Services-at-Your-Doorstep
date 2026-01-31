import 'package:get/get.dart';

class ProviderNavbarController extends GetxController {
  // Current active tab index
  var selectedIndex = 0.obs;

  // Change tab
  void changeTab(int index) {
    selectedIndex.value = index;
  }

  // Icons and Labels for the tabs
  final List<Map<String, dynamic>> navItems = [
    {'label': 'Home'},
    {'label': 'My Job'},
    {'label': 'Bookings'},
    {'label': 'More'},
  ];
}
