import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProviderDetailsController extends GetxController {
  // Stats
  final String rating = "4.8";
  final String reviewCount = "170";
  final String servicesProvided = "30";

  // Skills
  final List<String> skills = ["Handyman", "Gardening", "Renovation"];

  // Tab state for provided services
  var selectedServiceTab = 0.obs;

  void changeServiceTab(int index) {
    selectedServiceTab.value = index;
  }

  void sendMessage() {
    // Logic to open chat with Mike Handyman
    debugPrint("Navigating to chat...");
  }

  void bookSpecificService(String serviceName) {
    debugPrint("Booking: $serviceName");
  }
}