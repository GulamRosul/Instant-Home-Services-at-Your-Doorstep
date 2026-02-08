import 'package:get/get.dart';
import 'package:protiva502/features/chat/screen/single_chat_screen.dart';

class BookingController extends GetxController {
  // Active Tab Index
  var selectedTabIndex = 0.obs;

  // Tabs labels with dynamic counts
  List<String> get dynamicTabs {
    int pendingCount = bookings.where((b) => b['status'] == 'Pending').length;
    int acceptedCount = bookings.where((b) => b['status'] == 'Accepted').length;
    int rejectedCount = bookings.where((b) => b['status'] == 'Rejected').length;
    int inProgressCount = bookings
        .where((b) => b['status'] == 'In-Progress')
        .length;

    return [
      'Pending (${pendingCount.toString().padLeft(2, '0')})',
      'Accepted (${acceptedCount.toString().padLeft(2, '0')})',
      'Rejected (${rejectedCount.toString().padLeft(2, '0')})',
      'In-Progress (${inProgressCount.toString().padLeft(2, '0')})',
    ];
  }

  // Filtered bookings based on selected tab
  List<Map<String, dynamic>> get filteredBookings {
    String status = '';
    switch (selectedTabIndex.value) {
      case 0:
        status = 'Pending';
        break;
      case 1:
        status = 'Accepted';
        break;
      case 2:
        status = 'Rejected';
        break;
      case 3:
        status = 'In-Progress';
        break;
    }
    return bookings.where((b) => b['status'] == status).toList();
  }

  // Dynamic stats
  List<Map<String, String>> get dynamicStats {
    int pendingCount = bookings.where((b) => b['status'] == 'Pending').length;
    int acceptedCount = bookings.where((b) => b['status'] == 'Accepted').length;
    int inProgressCount = bookings
        .where((b) => b['status'] == 'In-Progress')
        .length;
    double totalRevenue = bookings
        .where((b) => b['status'] == 'Accepted' || b['status'] == 'In-Progress')
        .fold(
          0.0,
          (sum, b) => sum + (double.tryParse(b['budget'].toString()) ?? 0.0),
        );

    return [
      {
        'value': pendingCount.toString().padLeft(2, '0'),
        'label': 'Request Pending',
        'icon': 'flag',
      },
      {
        'value': acceptedCount.toString().padLeft(2, '0'),
        'label': 'Confirm Bookings',
        'icon': 'confirmed',
      },
      {
        'value': inProgressCount.toString().padLeft(2, '0'),
        'label': 'Completed Service',
        'icon': 'star',
      },
      {
        'value': '${totalRevenue.toStringAsFixed(2)} \$',
        'label': 'Total Revenue',
        'icon': 'revenue',
      },
    ];
  }

  // Mock Bookings
  var bookings = <Map<String, dynamic>>[
    {
      'title': 'Carpentry & Woodwork',
      'date': 'Tuesday, January 30, 2024',
      'postDate': '20-10-2025',
      'budget': '350',
      'bookingId': '0185692',
      'clientName': 'Sarah Smith',
      'paymentMethod': 'card',
      'time': '10:00 AM - 1:00 PM',
      'location': 'Downtown Toronto, ON',
      'status': 'Pending',
    },
    {
      'title': 'Carpentry & Woodwork',
      'date': 'Tuesday, January 30, 2024',
      'postDate': '20-10-2025',
      'budget': '450',
      'bookingId': '0185693',
      'clientName': 'John Doe',
      'paymentMethod': 'card',
      'time': '10:00 AM - 1:00 PM',
      'location': 'Downtown Toronto, ON',
      'status': 'Accepted',
    },
    {
      'title': 'Electrical Repair',
      'date': 'Wednesday, Jan 31, 2024',
      'postDate': '21-10-2025',
      'budget': '200',
      'bookingId': '0185694',
      'clientName': 'Mike Ross',
      'paymentMethod': 'cash',
      'time': '2:00 PM - 4:00 PM',
      'location': 'Uptown Toronto, ON',
      'status': 'Rejected',
    },
  ].obs;

  void changeTab(int index) {
    selectedTabIndex.value = index;
  }

  void handleAccept(int index) {
    // Find the original index in 'bookings' list
    String targetId = filteredBookings[index]['bookingId'];
    int originalIndex = bookings.indexWhere((b) => b['bookingId'] == targetId);

    if (originalIndex != -1) {
      bookings[originalIndex]['status'] = 'Accepted';
      bookings.refresh();
      Get.snackbar(
        "Accepted",
        "Booking from ${bookings[originalIndex]['clientName']} has been accepted.",
      );
    }
  }

  void handleReject(int index) {
    String targetId = filteredBookings[index]['bookingId'];
    int originalIndex = bookings.indexWhere((b) => b['bookingId'] == targetId);

    if (originalIndex != -1) {
      bookings[originalIndex]['status'] = 'Rejected';
      bookings.refresh();
      Get.snackbar(
        "Rejected",
        "Booking from ${bookings[originalIndex]['clientName']} has been rejected.",
      );
    }
  }

  void handleMessage(int index) {
    // Get.snackbar(
    //   "Message",
    //   "Navigating to chat with ${filteredBookings[index]['clientName']}",
    // );
    Get.to(() => SingleChatScreen());
  }

  void handleViewDetails(int index) {
    Get.toNamed('/providerBookingDetails', arguments: filteredBookings[index]);
  }
}
