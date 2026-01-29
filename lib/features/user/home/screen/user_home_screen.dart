import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_button.dart';
import 'package:protiva502/core/common/widgets/custom_textfield.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/core/utils/constants/image_path.dart';
import 'package:protiva502/features/user/home/controller/user_home_controller.dart';
import 'package:protiva502/features/user/home/screen/available_category_screen.dart';
import 'package:protiva502/features/user/provoder_details/screen/provoder_details_screen.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserHomeController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child: Column(
          children: [
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                child: _buildHeader(),
              ),
            ),
            Divider(
              color: AppColors.textSecondary.withValues(alpha: 0.2),
              height: 1.0.h,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.h),
              _buildSearchBar(),
              SizedBox(height: 20.h),
              _buildPromoBanner(controller),
              SizedBox(height: 24.h),
              _buildSectionHeader(
                "All Categories",
                onSeeAllTap: () {
                  Get.to(() => const AvailableCategoryScreen());
                },
              ),
              SizedBox(height: 16.h),
              _buildCategoryGrid(controller),
              SizedBox(height: 24.h),
              _buildSectionHeader(
                "Popular Services",
                onSeeAllTap: () {
                  Get.to(() => const AvailableCategoryScreen());
                },
              ),
              SizedBox(height: 16.h),
              _buildServiceHorizontalList(),
              SizedBox(height: 24.h),
              _buildSectionHeader(
                "Recommended Expert For You",
                onSeeAllTap: () {
                  Get.to(() => const AvailableCategoryScreen());
                },
              ),
              SizedBox(height: 16.h),
              _buildExpertCard(),
              SizedBox(height: 24.h),
              _buildSectionHeader(
                "All Services",
                onSeeAllTap: () {
                  Get.to(() => const AvailableCategoryScreen());
                },
              ),
              _buildServiceGrid(), // From the bottom split screenshot
              SizedBox(height: 100.h), // Space for floating nav bar
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 22.r,
          backgroundImage: const AssetImage(ImagePath.profile),
        ),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good Morning!',
              style: getTextStyle(
                fontSize: 16.sp,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Charlotte Davis',
              style: getTextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ],
        ),
        // const Spacer(),
        // Stack(
        //   children: [
        //     Icon(Icons.notifications_none_rounded, size: 28.sp),
        //     Positioned(
        //       right: 4,
        //       top: 4,
        //       child: CircleAvatar(radius: 4.r, backgroundColor: Colors.red),
        //     ),
        //   ],
        // ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return CustomTextField(
      hintText: "Search Service",
      suffixIcon: Container(
        // padding: EdgeInsets.all(6.r),
        margin: EdgeInsets.all(4.r),
        decoration: const BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.search, color: Colors.white, size: 18.sp),
      ),
      backgroundColor: Colors.white,
      borderRadius: 50.r,
    );
  }

  Widget _buildPromoBanner(UserHomeController controller) {
    return Column(
      children: [
        SizedBox(
          height: 140.h, // Set a fixed height for the carousel
          child: PageView.builder(
            controller: controller.bannerController,
            onPageChanged: (index) =>
                controller.currentBannerIndex.value = index,
            itemCount: 3, // Number of banners
            itemBuilder: (context, index) {
              return Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(
                  horizontal: 2.w,
                ), // Optional: spacing between cards
                padding: EdgeInsets.all(20.r),
                decoration: BoxDecoration(
                  color: const Color(0xFF0085B1),
                  borderRadius: BorderRadius.circular(16.r),
                  // image: const DecorationImage(
                  //   image: AssetImage(
                  //     'assets/images/banner_bg.png',
                  //   ), // If you have a bg pattern
                  //   fit: BoxFit.cover,
                  // ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Best Handyman\nService",
                            style: getTextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              lineHeight: 22.sp,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            "Trusted & Professional provider",
                            style: getTextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Banner Image
                    // Image.asset(
                    //   'assets/images/worker_banner.png', // Replace with actual worker image
                    //   height: 100.h,
                    // ),
                    Icon(Icons.handyman, size: 60.sp, color: Colors.white24),
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(height: 12.h),
        // Dots Indicator
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              3,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: 2.w),
                width: controller.currentBannerIndex.value == index
                    ? 24.w
                    : 8.w,
                height: 6.h,
                decoration: BoxDecoration(
                  color: controller.currentBannerIndex.value == index
                      ? Colors.black
                      : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, {VoidCallback? onSeeAllTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: getTextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        GestureDetector(
          onTap: onSeeAllTap,
          child: Text(
            "See All",
            style: getTextStyle(
              fontSize: 12.sp,
              color: AppColors.textBlue,
              // decoration: TextDecoration.underline,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryGrid(UserHomeController controller) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.categories.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 10.h,
        crossAxisSpacing: 6.w,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        final category = controller.categories[index];
        return Container(
          padding: EdgeInsets.all(5.r),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF6FF),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                category['icon']!,
                width: 24.w,
                height: 24.h,
                // colorFilter: ColorFilter.mode(
                //   Colors.blue.shade700,
                //   BlendMode.srcIn,
                // ),
              ),
              SizedBox(height: 8.h),
              Text(
                category['name']!,
                textAlign: TextAlign.center,
                style: getTextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        );
      },
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
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
            child: Image.asset(
              ImagePath.servicecard,
              height: 100.h,
              width: double.infinity,
              fit: BoxFit.cover,
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
                    fontSize: 12.sp,
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
                      decorationColor: AppColors.textBlue,
                      decoration: TextDecoration.underline,
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
                  onPressed: () {},
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceHorizontalList() {
    return SizedBox(
      height: 260.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) => _buildServiceCard(),
      ),
    );
  }

  Widget _buildExpertCard() {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25.r,
            backgroundImage: const AssetImage(ImagePath.profile),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Mike Handyman carpentry service",
                  style: getTextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "– Dhaka, Canada",
                  style: getTextStyle(
                    fontSize: 11.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.orange, size: 14.sp),
                    SizedBox(width: 4.w),
                    Text("Verified", style: getTextStyle(fontSize: 11.sp)),
                    const Spacer(),
                    Text(
                      "Starting : ",
                      style: getTextStyle(
                        fontSize: 11.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "৳ 20.00",
                      style: getTextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceGrid() {
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
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
