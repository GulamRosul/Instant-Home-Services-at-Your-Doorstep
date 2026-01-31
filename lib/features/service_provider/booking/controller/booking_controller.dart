import 'package:get/get.dart';

class BookingController extends GetxController {
  // Active Tab Index
  var selectedTabIndex = 0.obs;

  // Tabs
  final List<String> tabs = [
    'Pending (02)',
    'Accepted (02)',
    'Rejected (02)',
    'In-Progress (01)',
  ];

  // Stats
  final List<Map<String, String>> stats = [
    {'value': '20', 'label': 'Request Pending', 'icon': 'flag'},
    {'value': '02', 'label': 'Confirm Bookings', 'icon': 'confirmed'},
    {'value': '05', 'label': 'Completed Service', 'icon': 'star'},
    {'value': '1200.00 \$', 'label': 'Total Revenue', 'icon': 'revenue'},
  ];

  // Mock Bookings
  var bookings = [
    {
      'title': 'Carpentry & Woodwork',
      'date': 'Tuesday, January 30, 2024',
      'postDate': '20-10-2025',
      'budget': '\$350',
      'bookingId': '0185692',
      'clientName': 'Sarah Smith',
      'paymentMethod': 'card',
      'time': '10:00 AM - 1:00 PM',
      'location': 'Downtown Toronto, ON',
    },
    {
      'title': 'Carpentry & Woodwork',
      'date': 'Tuesday, January 30, 2024',
      'postDate': '20-10-2025',
      'budget': '\$350',
      'bookingId': '0185692',
      'clientName': 'Sarah Smith',
      'paymentMethod': 'card',
      'time': '10:00 AM - 1:00 PM',
      'location': 'Downtown Toronto, ON',
    },
  ].obs;

  void changeTab(int index) {
    selectedTabIndex.value = index;
  }

  void handleAccept(int index) {
    Get.snackbar(
      "Accepted",
      "Booking from ${bookings[index]['clientName']} has been accepted.",
    );
  }

  void handleReject(int index) {
    Get.snackbar(
      "Rejected",
      "Booking from ${bookings[index]['clientName']} has been rejected.",
    );
  }

  void handleMessage(int index) {
    Get.snackbar(
      "Message",
      "Navigating to chat with ${bookings[index]['clientName']}",
    );
  }

  void handleViewDetails(int index) {
    Get.snackbar(
      "Details",
      "Showing details for Booking ID: ${bookings[index]['bookingId']}",
    );
  }
}
