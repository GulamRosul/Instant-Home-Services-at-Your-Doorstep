import 'package:get/get.dart';

class NotificationController extends GetxController {
  // Mock data for notifications
  final List<Map<String, dynamic>> notifications = [
    {
      'title': 'Booking Accepted',
      'message': 'Mike Handyman has accepted your Carpentry request.',
      'time': '10:30 AM',
      'isRead': false,
      'type': 'booking',
      'dateGroup': 'Today',
    },
    {
      'title': 'Payment Successful',
      'message': 'Your payment of ৳ 450.00 was successful.',
      'time': '09:15 AM',
      'isRead': true,
      'type': 'payment',
      'dateGroup': 'Today',
    },
    {
      'title': 'New Service Available',
      'message': 'New plumbing services are now available in your area.',
      'time': 'Yesterday',
      'isRead': true,
      'type': 'system',
      'dateGroup': 'Yesterday',
    },
  ].obs;

  void markAsRead(int index) {
    notifications[index]['isRead'] = true;
    // notifications.refresh();
  }

  void clearAll() {
    notifications.clear();
  }
}
