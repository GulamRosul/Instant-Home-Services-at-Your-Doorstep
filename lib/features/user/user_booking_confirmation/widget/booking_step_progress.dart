import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';

class BookingStepProgress extends StatelessWidget {
  final int currentStep; // 1, 2, or 3

  const BookingStepProgress({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildStepIcon("01", const Color(0xFF8B5CF6), currentStep >= 1),
            _buildDivider(),
            _buildStepIcon("02", const Color(0xFFF97316), currentStep >= 2),
            _buildDivider(),
            _buildStepIcon("03", const Color(0xFF14B8A6), currentStep >= 3),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStepText("Boking details", currentStep == 1), // "Boking" as per screenshot
            _buildStepText("Confirm", currentStep == 2),
            _buildStepText("Payment", currentStep == 3),
          ],
        ),
      ],
    );
  }

  Widget _buildStepIcon(String step, Color color, bool isActive) {
    return Container(
      width: 45.w,
      height: 45.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isActive ? color : Colors.grey.shade300,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.r),
          topRight: Radius.circular(12.r),
          bottomRight: Radius.circular(12.r),
        ),
      ),
      child: Text(step, style: getTextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Text(".......", style: TextStyle(color: Colors.grey.shade400, fontSize: 20.sp)),
    );
  }

  Widget _buildStepText(String label, bool isSelected) {
    return Expanded(
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: getTextStyle(
          fontSize: 14.sp,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          color: isSelected ? const Color(0xFF007B92) : Colors.black87,
        ),
      ),
    );
  }
}