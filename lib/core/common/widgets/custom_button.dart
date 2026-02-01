import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/utils/constants/colors.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final VoidCallback? onPressed;
  final double? borderRadius;
  final double? height;
  final IconData? iconData;
  final String? assetIcon;
  final String? imageAsset;
  const CustomButton({
    super.key,
    this.text,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.onPressed,
    this.borderRadius,
    this.height,
    this.iconData,
    this.assetIcon,
    this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height ?? 50.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.primary,
          borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
          border: borderColor != null
              ? Border.all(color: borderColor!, width: 1.0)
              : null,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (iconData != null) ...[
                Icon(iconData, color: textColor ?? Colors.white, size: 20.sp),
                SizedBox(width: 8.w),
              ],
              if (assetIcon != null) ...[
                SvgPicture.asset(
                  assetIcon!,
                  height: 20.h,
                  width: 20.w,
                  colorFilter: textColor != null
                      ? ColorFilter.mode(textColor!, BlendMode.srcIn)
                      : null,
                ),
                SizedBox(width: 8.w),
              ],
              if (imageAsset != null) ...[
                Image.asset(imageAsset!, height: 20.h, width: 20.w),
                SizedBox(width: 8.w),
              ],
              if (text != null) ...[
                Text(
                  text!,
                  style: getTextStyle(
                    color: textColor ?? Colors.black,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
