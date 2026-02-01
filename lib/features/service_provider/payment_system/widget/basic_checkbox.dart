import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BasicCheckbox extends StatelessWidget {
  final bool checked;
  final VoidCallback? onTap;

  const BasicCheckbox({super.key, required this.checked, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 18.w,
        height: 18.w,
        decoration: BoxDecoration(
          color: checked ? const Color(0xFF09090B) : Colors.white,
          borderRadius: BorderRadius.circular(7.r),
          border: Border.all(
            color: checked ? const Color(0xFF334155) : Color(0xFF09090B),
            width: 1.5,
          ),
        ),
        child: checked
            ? Center(
                child: Icon(Icons.check, size: 16.sp, color: Colors.white),
              )
            : null,
      ),
    );
  }
}
