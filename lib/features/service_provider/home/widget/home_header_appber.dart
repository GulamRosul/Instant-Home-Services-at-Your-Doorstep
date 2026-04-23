import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/utils/constants/icon_path.dart';
import 'package:protiva502/core/utils/helpers/app_helper.dart';
import 'package:protiva502/features/profile/screen/profile_screen.dart';
import 'package:protiva502/features/service_provider/home/controller/provider_home_controller.dart';

class HomeHeaderAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeHeaderAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(60.h);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProviderHomeController>();

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                // Handle profile tap
                Get.to(() => ProfileScreen());
              },

              child: Obx(
                () => CircleAvatar(
                  radius: 24.r,
                  backgroundImage: controller.profileImage.value.isNotEmpty
                      ? NetworkImage(controller.profileImage.value)
                      : Image.asset(IconPath.profile).image,
                  onBackgroundImageError: (exception, stackTrace) {
                    // Fallback to asset image if network image fails
                  },
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppHelperFunctions.getDynamicGreeting(),
                  style: getTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF3F3F3F),
                  ),
                ),
                SizedBox(height: 4.h),
                Obx(
                  () => Text(
                    controller.profileName.value.isNotEmpty
                        ? controller.profileName.value
                        : 'Provider',
                    style: getTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF334155),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const Spacer(),
            SvgPicture.asset(
              IconPath.kaajbd,
              width: 24.w,
              height: 24.h,
              // color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
