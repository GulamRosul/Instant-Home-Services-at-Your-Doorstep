import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/utils/constants/icon_path.dart';

class BookingSuccessDialog extends StatelessWidget {
  const BookingSuccessDialog({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
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
              'congratulations'.tr,
              style: getTextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 12.h),

            // Success Message
            Text(
              message,
              textAlign: TextAlign.center,
              style: getTextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey.shade600,
                lineHeight: 15.sp,
              ),
            ),
            SizedBox(height: 32.h),
            Text(
              "redirecting_to_bookings".tr,
              textAlign: TextAlign.center,
              style: getTextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
