import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/utils/constants/image_path.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // SizedBox(height: 60.h),
            // Image Container
            Stack(
              alignment: Alignment
                  .bottomCenter, // Aligns children to the bottom center
              children: [
                Container(
                  height: 450.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(ImagePath.onboarding),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 40.h,
                  ), // Adjust distance from the very bottom
                  child: Text(
                    'Find the Right Expert, Right Away',
                    textAlign: TextAlign.center,
                    style: getTextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            // SizedBox(height: 16.h),
            // Subtitle
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 40.w),
            //   child: Text(
            //     'Connect with verified professionals for all your service needs',
            //     textAlign: TextAlign.center,
            //     style: getTextStyle(
            //       fontSize: 14.sp,
            //       fontWeight: FontWeight.w400,
            //       lineHeight: 20.sp,
            //       color: Colors.grey.shade600,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
