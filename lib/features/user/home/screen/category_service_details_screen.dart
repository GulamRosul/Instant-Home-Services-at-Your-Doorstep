import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_appbar.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/core/utils/constants/icon_path.dart';
import 'package:protiva502/core/utils/constants/image_path.dart';
import 'package:protiva502/features/user/home/controller/category_service_details_controller.dart';
import 'package:protiva502/features/user/provoder_details/screen/provoder_details_screen.dart';

class CategoryServiceDetailsScreen extends StatelessWidget {
  const CategoryServiceDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryServiceDetailsController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: CustomAppBar(title: 'Service Details'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFeaturedHeader(),
            Transform.translate(
              offset: Offset(0, -50.h),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: _buildProviderCard(controller),
              ),
            ),
            // SizedBox(height: 20.h),
            _buildTabSection(controller),
            Obx(
              () => controller.activeTabIndex.value == 0
                  ? _buildServiceDetails()
                  : _buildReviewsSection(),
            ),
            SizedBox(height: 100.h), // Padding for bottom nav bar
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedHeader() {
    return Container(
      width: double.infinity,
      height: 180.h,
      padding: EdgeInsets.all(20.r),
      decoration: const BoxDecoration(color: Color(0xFF0085B1)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Featured Provider",
                  style: getTextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "Work with highly recommended experts who stand out for their quality, dedication, and proven track.",
                  style: getTextStyle(
                    color: Colors.white,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          // Illustration Placeholder
          // Icon(Icons.person_search, size: 80.sp, color: Colors.white24),
          SvgPicture.asset(IconPath.provider, width: 100.w, height: 120.h),
        ],
      ),
    );
  }

  Widget _buildProviderCard(CategoryServiceDetailsController controller) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.asset(
                  ImagePath.servicecard,
                  height: 100.h,
                  width: 100.w,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Home Renovation",
                      style: getTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => ProviderDetailsScreen());
                      },
                      child: Text(
                        "Mike Handyman service",
                        style: getTextStyle(
                          fontSize: 12.sp,
                          color: Colors.blue.shade900,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.blue.shade900,
                          fontWeight: FontWeight.w600,
                          lineHeight: 15.sp,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 12.sp,
                          color: Colors.blue,
                        ),
                        Text(
                          " Dhaka, Bangladesh",
                          style: getTextStyle(
                            fontSize: 10.sp,
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                "450.0 ৳",
                style: getTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      ...List.generate(
                        5,
                        (i) =>
                            Icon(Icons.star, color: Colors.orange, size: 14.sp),
                      ),
                    ],
                  ),

                  Text(
                    " 4.8 (170 Reviews)",
                    style: getTextStyle(fontSize: 11.sp, color: Colors.grey),
                  ),
                ],
              ),

              const Spacer(),
              _buildSmallButton(
                "Massage",
                Colors.black87,
                controller.handleMessaging,
              ),
              SizedBox(width: 8.w),
              _buildSmallButton(
                "Book",
                AppColors.textPurple,
                controller.handleBooking,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSmallButton(String text, Color color, VoidCallback onTap) {
    return SizedBox(
      height: 32.h,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6.r),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: getTextStyle(
              color: Colors.white,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabSection(CategoryServiceDetailsController controller) {
    return Material(
      color: const Color(0xFFF8F9FA),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: TabBar(
          controller: controller.tabController,
          labelColor: AppColors.textBlue,
          unselectedLabelColor: Colors.grey,
          indicatorColor: AppColors.textBlue,
          labelStyle: getTextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            lineHeight: 18.sp,
          ),
          tabs: const [
            Tab(text: "Service Details"),
            Tab(text: "Review"),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceDetails() {
    return Padding(
      padding: EdgeInsets.all(20.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Get professional carpentry and woodwork solutions for your home, office, or business. From custom furniture design and installation to repairing doors, windows, and wooden fixtures, our skilled carpenters deliver quality craftsmanship with attention to detail. Whether you need a new wardrobe, polished cabinets, or furniture restoration, we provide durable and tailored solutions that fit your space and style.",
            style: getTextStyle(
              fontSize: 13.sp,
              color: Colors.black87,
              lineHeight: 18.sp,
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            "What You will Get:",
            style: getTextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 12.h),
          _buildCheckItem("Custom tables, chairs, wardrobes, shelves"),
          _buildCheckItem("Modular kitchen cabinets & storage units"),
          _buildCheckItem("Fixing broken chairs, tables, and beds"),
        ],
      ),
    );
  }

  Widget _buildReviewsSection() {
    return Padding(
      padding: EdgeInsets.all(20.r),
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20.r,
                  backgroundImage: const AssetImage(ImagePath.profile),
                ),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Fabio",
                      style: getTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Row(
                      children: List.generate(
                        5,
                        (i) =>
                            Icon(Icons.star, color: Colors.orange, size: 14.sp),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  "August 14, 2025",
                  style: getTextStyle(fontSize: 12.sp, color: Colors.grey),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Text(
              "Mike Handyman Service is a great , he helped me through the problems that i really want .Mike did an excellent job fixing our kitchen cabinet doors and installing new handles. Very professional, arrived on time, and cleaned up after himself. Highly recommended! Very much recommended.",
              style: getTextStyle(
                fontSize: 13.sp,
                color: Colors.black87,
                lineHeight: 15.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckItem(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Icon(Icons.check_circle_outline, color: Colors.green, size: 18.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              text,
              style: getTextStyle(fontSize: 13.sp, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
