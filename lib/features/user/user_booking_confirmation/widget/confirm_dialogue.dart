import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_button.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/core/utils/constants/icon_path.dart';
import 'package:protiva502/features/user/user_booking_confirmation/controller/confirm_booking_controller.dart';

class BookingSuccessDialog extends StatelessWidget {
  const BookingSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ConfirmBookingController());

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      elevation: 0,
      backgroundColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Wraps content tightly
          children: [
            // Celebration GIF
            Container(
              width: 60.w,
              height: 60.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFFFEA9F),
              ),
              child: SizedBox(
                height: 20.h,
                child: Image.asset(
                  IconPath.celebration, // Replace with your actual GIF path
                  fit: BoxFit.contain,
                ),
              ),
            ),
            // SizedBox(
            //   height: 120.h,
            //   child: Image.asset(
            //     'assets/gifs/celebration.gif', // Replace with your actual GIF path
            //     fit: BoxFit.contain,
            //   ),
            // ),
            SizedBox(height: 20.h),

            // Success Header
            Text(
              "Congratulations!",
              style: getTextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 12.h),

            // Success Message
            Text(
              "Your booking has been successfully placed. You can check your booking status in the bookings section.",
              textAlign: TextAlign.center,
              style: getTextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey.shade600,
                lineHeight: 15.sp,
              ),
            ),
            SizedBox(height: 32.h),

            // Back to Home Button
            // SizedBox(
            //   width: double.infinity,
            //   height: 50.h,
            //   child: ElevatedButton(
            //     onPressed: controller.goToHome,
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: AppColors.textPurple,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(10.r),
            //       ),
            //       elevation: 0,
            //     ),
            //     child: Text(
            //       "Back to Home",
            //       style: getTextStyle(
            //         color: Colors.white,
            //         fontSize: 16.sp,
            //         fontWeight: FontWeight.w600,
            //       ),
            //     ),
            //   ),
            // ),
            CustomButton(
              text: 'Back to Home',
              onPressed: controller.goToHome,
              textColor: Colors.white,
              backgroundColor: AppColors.textPurple,
            ),

            // Optional: Secondary link to View Bookings
            SizedBox(height: 16.h),
            GestureDetector(
              onTap: controller.viewBookings,
              child: Text(
                "View My Bookings",
                style: getTextStyle(
                  fontSize: 14.sp,
                  color: AppColors.textPurple,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.textPurple,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
