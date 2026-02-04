import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrackProviderController extends GetxController {
  // Map configuration
  // final LatLng providerLocation = const LatLng(43.6532, -79.3832); // Toronto
  // final LatLng userLocation = const LatLng(43.6600, -79.3900);

  // Provider Info
  final String providerName = "Mike Handyman";
  final String estimatedTime = "12 mins";
  final String distance = "2.4 km";

  void callProvider() {
    print("Initiating call to $providerName...");
  }

  void messageProvider() {
    print("Navigating to chat with $providerName...");
  }
}
