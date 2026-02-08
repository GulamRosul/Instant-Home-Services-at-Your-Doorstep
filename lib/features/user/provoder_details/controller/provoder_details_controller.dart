import 'package:get/get.dart';
import 'package:protiva502/features/chat/screen/single_chat_screen.dart';
import 'package:protiva502/features/user/user_booking_confirmation/screen/booking_details_screen.dart';

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
    // debugPrint("Navigating to chat...");
    Get.to(() => SingleChatScreen());
  }

  void bookSpecificService(String serviceName) {
    // debugPrint("Booking: $serviceName");
    Get.to(() => BookingDetailsScreen());
  }
}
