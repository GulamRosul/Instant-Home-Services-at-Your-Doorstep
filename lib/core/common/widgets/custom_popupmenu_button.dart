import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/utils/constants/colors.dart';

class CustomPopupMenu extends StatelessWidget {
  final String value;
  final List<String> items;
  final void Function(String) onSelected;
  final String? backgroundcolor;

  const CustomPopupMenu({
    super.key,
    required this.value,
    required this.items,
    required this.onSelected,
    this.backgroundcolor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) async {
        final RenderBox button = context.findRenderObject() as RenderBox;
        final RenderBox overlay =
            Overlay.of(context).context.findRenderObject() as RenderBox;

        final RelativeRect position = RelativeRect.fromRect(
          Rect.fromPoints(
            button.localToGlobal(
              Offset(button.size.width, 0),
              ancestor: overlay,
            ),
            button.localToGlobal(
              Offset(button.size.width, button.size.height),
              ancestor: overlay,
            ),
          ),
          Offset.zero & overlay.size,
        );

        final selected = await showMenu<String>(
          context: context,
          position: position,
          color: backgroundcolor != null
              ? Color(int.parse(backgroundcolor!))
              : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          items: items
              .map(
                (e) => PopupMenuItem<String>(
                  value: e,
                  child: Text(
                    e,
                    style: getTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              )
              .toList(),
        );

        if (selected != null) {
          onSelected(selected);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(4.r),
          border: Border.all(
            color: AppColors.defaultBorder.withValues(alpha: 0.3),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                value,
                style: getTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.textGrey,
              size: 24.sp,
            ),
          ],
        ),
      ),
    );
  }
}
