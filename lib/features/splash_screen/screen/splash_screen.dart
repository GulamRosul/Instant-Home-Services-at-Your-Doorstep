import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:protiva502/core/utils/constants/icon_path.dart';
import 'package:protiva502/core/utils/constants/image_path.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Layer 1: The Background Image
          Container(
            // height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImagePath.splash),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Layer 2: The Center Image
          Center(
            child: SvgPicture.asset(
              IconPath.kaajbd, // Replace with your center image path
              width: 300.w, // Set a specific width/height as needed
            ),
          ),
        ],
      ),
    );
  }
}
