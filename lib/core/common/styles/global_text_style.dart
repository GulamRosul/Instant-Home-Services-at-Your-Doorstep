import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle getTextStyle({
  double fontSize = 14.0,
  FontWeight fontWeight = FontWeight.w400,
  double lineHeight = 21.0,
  Color color = Colors.black,
  TextDecoration? decoration,
  TextDecorationStyle? decorationStyle,
  Color? decorationColor,
}) {
  return TextStyle(
    fontFamily: 'Geist',
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
    height: lineHeight / fontSize,
    color: color,
    decoration: decoration,
    decorationStyle: decorationStyle,
    decorationColor: decorationColor,
  );
 
}
