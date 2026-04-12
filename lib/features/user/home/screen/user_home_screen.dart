import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_button.dart';
import 'package:protiva502/core/common/widgets/custom_textfield.dart';
import 'package:protiva502/core/services/storage_service.dart';
import 'package:protiva502/core/utils/device/device_utility.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/core/utils/constants/image_path.dart';
import 'package:protiva502/features/user/home/controller/user_home_controller.dart';
import 'package:protiva502/features/user/home/model/home_job_model.dart';
import 'package:protiva502/features/user/home/model/user_banner_model.dart';
import 'package:protiva502/features/user/home/screen/available_category_screen.dart';
import 'package:protiva502/features/user/provoder_details/screen/provoder_details_screen.dart';
import 'package:protiva502/features/user/user_booking_confirmation/screen/booking_details_screen.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserHomeController());

    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child: Column(
          children: [
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
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
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
              // SizedBox(height: 16.h),
              Obx(
                () => _buildCategoryGrid(controller),
              ),
              SizedBox(height: 24.h),
              _buildSectionHeader(
                "Popular Services",
                onSeeAllTap: () {
                  Get.to(() => const AvailableCategoryScreen());
                },
              ),
              SizedBox(height: 16.h),
              Obx(
                () => _buildSectionBody(
                  isLoading: controller.isServicesLoading.value,
                  errorMessage: controller.servicesErrorMessage.value,
                  isEmpty: controller.popularServices.isEmpty,
                  child: _buildServiceHorizontalList(
                    controller.popularServices,
                  ),
                ),
              ),
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
              Obx(
                () => _buildSectionBody(
                  isLoading: controller.isServicesLoading.value,
                  errorMessage: controller.servicesErrorMessage.value,
                  isEmpty: controller.allServices.isEmpty,
                  child: _buildServiceGrid(controller.allServices),
                ),
              ),
              SizedBox(height: 100.h), // Space for floating nav bar
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final displayName = StorageService.getDisplayName();

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
              displayName,
              style: getTextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ],
        ),
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
    final bannerHeight = 140.h;

    return Obx(() {
      if (controller.isBannerLoading.value) {
        return _buildBannerPlaceholder(message: 'Loading banners...');
      }

      if (controller.banners.isEmpty) {
        return _buildBannerPlaceholder(
          message: controller.bannerErrorMessage.value.isEmpty
              ? 'No banners available right now'
              : controller.bannerErrorMessage.value,
        );
      }

      return Column(
        children: [
          SizedBox(
            height: bannerHeight,
            child: PageView.builder(
              controller: controller.bannerController,
              onPageChanged: controller.updateBannerIndex,
              itemCount: controller.banners.length,
              itemBuilder: (context, index) {
                final banner = controller.banners[index];
                return _buildBannerCard(banner);
              },
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              controller.banners.length,
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
        ],
      );
    });
  }

  Widget _buildBannerCard(UserBannerModel banner) {
    final title = banner.title.trim();
    final description = banner.description.trim();
    final imageUrl = banner.image.trim();
    final link = banner.link.trim();
    final bannerImageSize = 72.r;

    return GestureDetector(
      onTap: link.isNotEmpty ? () => AppDeviceUtility.launchUrl(link) : null,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 2.w),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: const Color(0xFF0085B1),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title.isNotEmpty ? title : 'Best Handyman Service',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: getTextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      lineHeight: 20.sp,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    description.isNotEmpty
                        ? description
                        : 'Trusted & Professional provider',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: getTextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: imageUrl.isNotEmpty
                  ? Image.network(
                      imageUrl,
                      width: bannerImageSize,
                      height: bannerImageSize,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          _buildBannerImageFallback(size: bannerImageSize),
                    )
                  : _buildBannerImageFallback(size: bannerImageSize),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBannerPlaceholder({required String message}) {
    return Container(
      height: 140.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFF0085B1),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              message,
              style: getTextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          _buildBannerImageFallback(size: 72.r),
        ],
      ),
    );
  }

  Widget _buildBannerImageFallback({double? size}) {
    final resolvedSize = size ?? 72.r;

    return Container(
      width: resolvedSize,
      height: resolvedSize,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Icon(Icons.handyman, size: 42.sp, color: Colors.white70),
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
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.categories.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 5.h,
        crossAxisSpacing: 6.w,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        final category = controller.categories[index];
        return GestureDetector(
          onTap: () {
            Get.to(() => AvailableCategoryScreen(initialCategoryIndex: index));
          },
          child: Container(
            padding: EdgeInsets.all(5.r),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Load category icon as network image since it's a URL from API
                category.icon.isNotEmpty
                    ? Image.network(
                        category.icon,
                        width: 24.w,
                        height: 24.h,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.category,
                            size: 24.sp,
                            color: Colors.grey,
                          );
                        },
                      )
                    : Icon(
                        Icons.category,
                        size: 24.sp,
                        color: Colors.grey,
                      ),
                SizedBox(height: 8.h),
                Text(
                  category.name,
                  textAlign: TextAlign.center,
                  style: getTextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionBody({
    required bool isLoading,
    required String errorMessage,
    required bool isEmpty,
    required Widget child,
  }) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage.isNotEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Text(
          errorMessage,
          style: getTextStyle(fontSize: 12.sp, color: AppColors.textSecondary),
        ),
      );
    }

    if (isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Center(
          child: Text(
            'No services found',
            textAlign: TextAlign.center,
            style: getTextStyle(
              fontSize: 12.sp,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      );
    }

    return child;
  }

  Widget _buildServiceCard(HomeJobModel service) {
    return Container(
      width: 160.w,
      margin: EdgeInsets.only(right: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
            child: service.thumbnail.isNotEmpty
                ? Image.network(
                    service.thumbnail,
                    height: 100.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Image.asset(
                      ImagePath.servicecard,
                      height: 100.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                : Image.asset(
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
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  service.title,
                  style: getTextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    lineHeight: 15.sp,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => ProviderDetailsScreen());
                  },
                  child: Text(
                    service.description.isNotEmpty
                        ? service.description
                        : 'Service details',
                    style: getTextStyle(
                      fontSize: 10.sp,
                      color: AppColors.textBlue,
                      decorationColor: AppColors.textBlue,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w600,
                      lineHeight: 15.sp,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 10.sp, color: Colors.blue),
                    Text(
                      " Remote Service",
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
                      (i) => Icon(
                        i < service.averageRating.round()
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.orange,
                        size: 10.sp,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        " ${service.averageRating.toStringAsFixed(1)} (${service.totalBookings} Bookings)",
                        style: getTextStyle(
                          fontSize: 9.sp,
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                // SizedBox(height: 4.h),
                Text(
                  "Start From ${service.basePrice.toStringAsFixed(0)} ৳",
                  style: getTextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 6.h),
                CustomButton(
                  text: "Book Now",
                  height: 30.h,
                  // width: double.infinity,
                  // fontSize: 10.sp,
                  backgroundColor: AppColors.textPurple,
                  borderRadius: 6.r,
                  onPressed: () {
                    Get.to(() => BookingDetailsScreen(service: service));
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

  Widget _buildServiceHorizontalList(List<HomeJobModel> services) {
    return SizedBox(
      height: 260.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: services.length,
        itemBuilder: (context, index) => _buildServiceCard(services[index]),
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

  Widget _buildServiceGrid(List<HomeJobModel> services) {
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: services.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10.h,
        crossAxisSpacing: 0.w,
        mainAxisExtent: 260.h,
      ),
      itemBuilder: (context, index) => _buildServiceCard(services[index]),
    );
  }
}
