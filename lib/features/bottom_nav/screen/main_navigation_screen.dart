import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protiva502/features/bottom_nav/bottom_nav_bar.dart';
import 'package:protiva502/features/bottom_nav/controller/bottom_nav_controller.dart';
import 'package:protiva502/features/notification/screen/notification_screen.dart';
import 'package:protiva502/features/user/all_bookings/screen/all_booking_screen.dart';
import 'package:protiva502/features/user/home/screen/user_home_screen.dart';

// Import your actual page widgets here
// import 'package:protiva502/features/home/home_page.dart';
// import 'package:protiva502/features/booking/booking_page.dart';

class MainNavigationScreen extends StatelessWidget {
  const MainNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the existing controller or create it
    final controller = Get.put(BottomNavController());

    // Define the pages corresponding to your tabs
    final List<Widget> pages = [
      const Center(child: UserHomeScreen()), // Replace with actual HomePage()
      const Center(
        child: AllBookingScreen(),
      ), // Replace with actual BookingPage()
      const Center(
        child: NotificationScreen(),
      ), // Replace with actual NotificationPage()
      const Center(child: Text("More Page")), // Replace with actual MorePage()
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      // Use Obx to update the body automatically when a tab is clicked
      body: Obx(
        () => IndexedStack(
          index: controller.selectedIndex.value,
          children: pages,
        ),
      ),
      // Your custom floating nav bar
      bottomNavigationBar: const BottomNavBar(),
      extendBody:
          true, // This allows the body to flow behind the floating nav bar
    );
  }
}
