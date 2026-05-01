import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';

class BookingStepProgress extends StatelessWidget {
  final int currentStep;

  const BookingStepProgress({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            children: [
              _buildStepIcon("01".tr, const Color(0xFF8B5CF6), currentStep >= 1),
              _buildCurveDivider(),
              _buildStepIcon("02".tr, const Color(0xFFF97316), currentStep >= 2),
              _buildCurveDivider(
                // isUpward: false,
              ), // Alternating curve direction
              _buildStepIcon("03".tr, const Color(0xFF14B8A6), currentStep >= 3),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStepText('booking_details'.tr, currentStep == 1),
            _buildStepText('confirm'.tr, currentStep == 2),
            _buildStepText('payment'.tr, currentStep == 3),
          ],
        ),
      ],
    );
  }

  Widget _buildStepIcon(String step, Color color, bool isActive) {
    return Container(
      width: 48.w,
      height: 48.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isActive ? color : Colors.grey.shade300,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.r),
          topRight: Radius.circular(15.r),
          bottomRight: Radius.circular(15.r),
          bottomLeft: Radius.zero,
        ),
      ),
      child: Text(
        step,
        style: getTextStyle(
          color: Colors.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildCurveDivider({bool isUpward = true}) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        child: CustomPaint(
          size: Size(30.w, 30.h),
          painter: DashCurvePainter(isUpward: isUpward),
        ),
      ),
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
          color: isSelected ? const Color(0xFF007B92) : const Color(0xFF1E293B),
        ),
      ),
    );
  }
}

class DashCurvePainter extends CustomPainter {
  final bool isUpward;
  DashCurvePainter({required this.isUpward});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final path = Path();

    if (isUpward) {
      // Curve going from bottom-left to top-right
      path.moveTo(0, size.height * 0.8);
      path.quadraticBezierTo(size.width / 2, 0, size.width, size.height * 0.2);
    } else {
      // Curve going from top-left to bottom-right
      path.moveTo(0, size.height * 0.2);
      path.quadraticBezierTo(
        size.width / 2,
        size.height,
        size.width,
        size.height * 0.8,
      );
    }

    // Drawing the dashed effect
    double dashWidth = 3, dashSpace = 3, distance = 0;
    for (var i = 0; i < path.computeMetrics().first.length; i = i + 1) {
      final metric = path.computeMetrics().first;
      if (distance < metric.length) {
        final extract = metric.extractPath(distance, distance + dashWidth);
        canvas.drawPath(extract, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
