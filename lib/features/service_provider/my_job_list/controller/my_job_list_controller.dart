import 'package:get/get.dart';
import 'package:protiva502/routes/app_routes.dart';

class MyJobListController extends GetxController {
  // Mock data for listings with explicit types
  var listings = <Map<String, String>>[
    {
      'title': 'Carpentry & Woodwork',
      'location': 'Toronto, Canada',
      'rating': '4.8',
      'price': '450.0\$',
      'views': '89',
      'applications': '12',
      'bookings': '8',
    },
    {
      'title': 'Home Cleaning',
      'location': 'Vancouver, BC',
      'rating': '4.9',
      'price': '150.0\$',
      'views': '120',
      'applications': '25',
      'bookings': '15',
    },
  ].obs;

  void handleNewListing() {
    Get.toNamed(AppRoute.postJob);
  }

  void handleEditListing(int index) {
    Get.snackbar("Action", "Editing: ${listings[index]['title']}");
  }

  void handleDeleteListing(int index) {
    String title = listings[index]['title'] ?? "Unknown";
    listings.removeAt(index);
    Get.snackbar("Deleted", "$title has been removed from listings");
  }
}
