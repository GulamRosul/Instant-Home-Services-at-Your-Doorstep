import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/features/service_provider/payment_system/controller/payment_method_controller.dart';

class MobileServiceOption extends StatelessWidget {
  final String label;
  final MobileBankingService service;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const MobileServiceOption({
    super.key,
    required this.label,
    required this.service,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  static const Color _primaryDark = Color(0xFF334155);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          Container(
            width: 20.w,
            height: 20.w,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(4.r),
              border: Border.all(
                color: isSelected
                    ? _primaryDark
                    : AppColors.textGrey.withValues(alpha: 0.5),
                width: 1.5,
              ),
              color: isSelected ? _primaryDark : Colors.transparent,
            ),
            child: isSelected
                ? Icon(Icons.check, color: Colors.white, size: 14.sp)
                : null,
          ),
          SizedBox(width: 12.w),
          Container(
            width: 36.w,
            height: 24.h,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Center(
              child: Text(
                label[0].toUpperCase(),
                style: getTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Text(
            label,
            style: getTextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.black : AppColors.textGrey,
            ),
          ),
        ],
      ),
    );
  }
}
