import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_appbar.dart';
import 'package:protiva502/core/common/widgets/custom_button.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/core/utils/constants/image_path.dart';
import 'package:protiva502/features/user/provoder_details/controller/provoder_details_controller.dart';

class ProviderDetailsScreen extends StatelessWidget {
  const ProviderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProviderDetailsController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: const CustomAppBar(title: 'Service Profile'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            _buildProfileHeader(controller),
            SizedBox(height: 24.h),
            _buildAboutSection(controller),
            SizedBox(height: 24.h),
            _buildProvideServicesSection(controller),
            SizedBox(height: 24.h),
            _buildReviewFeed(),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(ProviderDetailsController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          Row(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 45.r,
                    backgroundImage: AssetImage(ImagePath.profile),
                  ),
                  CircleAvatar(
                    radius: 12.r,
                    backgroundColor: Colors.amber,
                    child: Icon(Icons.check, size: 14.sp, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(width: 16.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Mike Handyman service",
                    style: getTextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 18.sp,
                        color: Colors.blue,
                      ),
                      Text(
                        " Dhaka, Bangladesh",
                        style: getTextStyle(
                          fontSize: 13.sp,
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 24.h),
          // Stats Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        5,
                        (i) =>
                            Icon(Icons.star, color: Colors.orange, size: 14.sp),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "${controller.rating} (${controller.reviewCount} Reviews)",
                      textAlign: TextAlign.center,
                      style: getTextStyle(
                        fontSize: 13.sp,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(width: 1.w, height: 50.h, color: Colors.grey.shade300),
              Expanded(
                child: Text(
                  "${controller.servicesProvided}\nService Provided",
                  textAlign: TextAlign.center,
                  style: getTextStyle(
                    fontSize: 13.sp,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          CustomButton(
            text: "Send Message",
            onPressed: controller.sendMessage,
            backgroundColor: AppColors.textPurple,
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection(ProviderDetailsController controller) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "About Mike Handyman Service",
            style: getTextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 8.h),
          Text(
            "Get professional carpentry and woodwork solutions for your home, office, or business. From custom furniture design and installation...",
            style: getTextStyle(
              fontSize: 13.sp,
              color: Colors.black54,
              lineHeight: 15.sp,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            "Skills",
            style: getTextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 8.h),
          Wrap(
            spacing: 8.w,
            children: controller.skills
                .map(
                  (skill) => Chip(
                    label: Text(skill, style: getTextStyle(fontSize: 12.sp)),
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.grey.shade200),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildProvideServicesSection(ProviderDetailsController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Provide services",
                style: getTextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "Professional solutions tailored to your needs.",
                style: getTextStyle(fontSize: 12.sp, color: Colors.grey),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        Obx(
          () => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                _buildServiceTab("Carpentry & Woodwork", 0, controller),
                SizedBox(width: 12.w),
                _buildServiceTab("Maintenance", 1, controller),
              ],
            ),
          ),
        ),
        SizedBox(height: 16.h),
        // Horizontal list of service cards
        SizedBox(
          height: 250.h,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            scrollDirection: Axis.horizontal,
            itemCount: 2,
            itemBuilder: (context, index) => _buildServiceCard(controller),
          ),
        ),
      ],
    );
  }

  Widget _buildServiceTab(
    String title,
    int index,
    ProviderDetailsController controller,
  ) {
    bool isSelected = controller.selectedServiceTab.value == index;
    return GestureDetector(
      onTap: () => controller.changeServiceTab(index),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFE0E7FF) : Colors.transparent,
              borderRadius: BorderRadius.circular(8.r),
              border: isSelected ? null : Border.all(color: Colors.transparent),
            ),
            child: Column(
              children: [
                Text(
                  title,
                  style: getTextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.black : Colors.grey,
                  ),
                ),
                // if (isSelected)
                //   Container(
                //     margin: EdgeInsets.only(top: 4.h),
                //     height: 2.h,
                //     width: 40.w,
                //     color: AppColors.textPurple,
                //   ),
              ],
            ),
          ),
          if (isSelected)
            Container(
              margin: EdgeInsets.only(top: 4.h),
              height: 2.h,
              width: 100.w,
              color: AppColors.textPurple,
            ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(ProviderDetailsController controller) {
    return Container(
      width: 180.w,
      margin: EdgeInsets.only(right: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
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
                  "Basic Woodwork",
                  style: getTextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Building and repairing small structures...",
                  style: getTextStyle(
                    fontSize: 10.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  "Start From 450.0 ৳",
                  style: getTextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8.h),
                CustomButton(
                  text: "Book For Service",
                  onPressed: () =>
                      controller.bookSpecificService("Basic Woodwork"),
                  backgroundColor: AppColors.textPurple,
                  textColor: Colors.white,
                  height: 30.h,
                  // fontSize: 10.sp,
                ),
                // SizedBox(
                //   width: double.infinity,
                //   height: 30.h,
                //   child: ElevatedButton(
                //     onPressed: () =>
                //         controller.bookSpecificService("Basic Woodwork"),
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: AppColors.textPurple,
                //     ),
                //     child: Text(
                //       "Book For Service",
                //       style: getTextStyle(color: Colors.white, fontSize: 10.sp),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewFeed() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Review",
            style: getTextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 12.h),
          // Reusing your Review Card logic
          ...List.generate(3, (index) => _buildSingleReview()),
        ],
      ),
    );
  }

  Widget _buildSingleReview() {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundImage: AssetImage(ImagePath.profile),
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
                          Icon(Icons.star, color: Colors.orange, size: 12.sp),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                "August 14, 2025",
                style: getTextStyle(fontSize: 11.sp, color: Colors.grey),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            "Mike Handyman Service is a great, he helped me through the problems that i really want...",
            style: getTextStyle(
              fontSize: 12.sp,
              color: AppColors.textSecondary,
              lineHeight: 15.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
