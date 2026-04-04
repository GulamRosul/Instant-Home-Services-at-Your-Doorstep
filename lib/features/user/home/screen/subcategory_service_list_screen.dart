import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_appbar.dart';
import 'package:protiva502/core/common/widgets/custom_button.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/core/utils/constants/image_path.dart';
import 'package:protiva502/features/user/home/controller/subcategory_service_list_controller.dart';
import 'package:protiva502/features/user/home/screen/category_service_details_screen.dart';
import 'package:protiva502/features/user/provoder_details/screen/provoder_details_screen.dart';
import 'package:protiva502/features/user/user_booking_confirmation/screen/booking_details_screen.dart';

class SubcategoryServiceListScreen extends StatelessWidget {
  const SubcategoryServiceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SubcategoryServiceListController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: CustomAppBar(title: controller.subcategoryTitle.value),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.h),
              _buildHeader(),
              SizedBox(height: 15.h),
              _buildServiceGrid(controller), // From the bottom split screenshot
              SizedBox(height: 100.h), // Space for floating nav bar
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Featured Provider',
          style: getTextStyle(
            fontSize: 18.sp,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          'Work with highly recommended experts who stand out for their quality, dedication, and proven track record.',
          style: getTextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildServiceCard() {
    return Container(
      width: 160.w,
      margin: EdgeInsets.only(right: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Get.to(() => CategoryServiceDetailsScreen());
            },
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
              child: Image.asset(
                ImagePath.servicecard,
                height: 100.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Carpentry & Woodwork",
                  style: getTextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    lineHeight: 15.sp,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => ProviderDetailsScreen());
                  },
                  child: Text(
                    "Mike Handyman service",
                    style: getTextStyle(
                      fontSize: 10.sp,
                      color: AppColors.textBlue,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.textBlue,
                      fontWeight: FontWeight.w600,
                      lineHeight: 15.sp,
                    ),
                  ),
                ),
                // SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 10.sp, color: Colors.blue),
                    Text(
                      " Dhaka, Bangladesh",
                      style: getTextStyle(
                        fontSize: 10.sp,
                        color: AppColors.textSecondary,
                        lineHeight: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                // SizedBox(height: 4.h),
                Row(
                  children: [
                    ...List.generate(
                      5,
                      (i) =>
                          Icon(Icons.star, color: Colors.orange, size: 10.sp),
                    ),
                    Text(
                      " 4.8 (170 Reviews)",
                      style: getTextStyle(
                        fontSize: 9.sp,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                // SizedBox(height: 4.h),
                Text(
                  "Start From 450.0 ৳",
                  style: getTextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4.h),
                CustomButton(
                  text: "Book Now",
                  height: 30.h,
                  // width: double.infinity,
                  // fontSize: 10.sp,
                  backgroundColor: AppColors.textPurple,
                  borderRadius: 6.r,
                  onPressed: () {
                    Get.to(() => BookingDetailsScreen());
                  },
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceGrid(SubcategoryServiceListController controller) {
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.serviceCount.value,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10.h,
        crossAxisSpacing: 0.w,
        mainAxisExtent: 260.h,
      ),
      itemBuilder: (context, index) => _buildServiceCard(),
    );
  }
}
