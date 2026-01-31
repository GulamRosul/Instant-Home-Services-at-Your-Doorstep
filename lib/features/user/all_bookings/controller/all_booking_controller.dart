import 'package:get/get.dart';

class AllBookingController extends GetxController {
  // Current selected status for filtering
  var selectedStatus = "All status".obs;

  // Dropdown options
  final List<String> statusOptions = [
    "All status",
    "Pending",
    "Accepted",
    "Rejected",
    "in-progress",
    "Completed"
  ];

  // Mock data for bookings
  final List<Map<String, dynamic>> allBookings = [
    {'name': 'Handyman service', 'status': 'Pending', 'price': '20.00', 'location': 'Toronto, Canada'},
    {'name': 'Handyman service', 'status': 'Accepted', 'price': '20.00', 'location': 'Toronto, Canada'},
    {'name': 'Handyman service', 'status': 'Rejected', 'price': '20.00', 'location': 'Toronto, Canada'},
    {'name': 'Handyman service', 'status': 'in-progress', 'price': '20.00', 'location': 'Toronto, Canada'},
    {'name': 'Handyman service', 'status': 'Completed', 'price': '20.00', 'location': 'Toronto, Canada'},
  ];

  // Computed list based on selection
  List<Map<String, dynamic>> get filteredBookings {
    if (selectedStatus.value == "All status") {
      return allBookings;
    }
    return allBookings.where((b) => b['status'] == selectedStatus.value).toList();
  }

  void updateStatus(String? newStatus) {
    if (newStatus != null) {
      selectedStatus.value = newStatus;
    }
  }
}