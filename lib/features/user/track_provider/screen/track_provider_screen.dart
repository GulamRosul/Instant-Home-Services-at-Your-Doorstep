import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/widgets/custom_appbar.dart';
import 'package:protiva502/features/google_map/screen/map_screen.dart';
import 'package:protiva502/features/user/track_provider/controller/track_provider_controller.dart';

class TrackProviderScreen extends StatelessWidget {
  const TrackProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TrackProviderController());

    return Scaffold(
      appBar: const CustomAppBar(title: 'Track'),
      body: MapScreen(
        trackingController: controller,
        isPickerMode: false,
      ),
    );
  }
}
