import 'package:flutter/material.dart' hide SearchController;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_appbar.dart';
import 'package:protiva502/core/common/widgets/custom_textfield.dart';
import 'package:protiva502/core/common/widgets/shimmer_effect.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/core/utils/constants/image_path.dart';
import 'package:protiva502/features/user/home/model/home_job_model.dart';
import 'package:protiva502/features/user/home/search_screen/controller/search_controller.dart';
import 'package:protiva502/features/user/provoder_details/screen/provoder_details_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchController());
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: const CustomAppBar(title: "Search Services", centerTitle: false),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: CustomTextField(
              controller: controller.searchTextController,
              hintText: "Search Service",
              suffixIcon: Container(
                margin: EdgeInsets.all(4.r),
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.search, color: Colors.white, size: 18.sp),
              ),
              backgroundColor: Colors.white,
              borderRadius: 50.r,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  controller.searchJobs(value);
                } else {
                  controller.clearSearch();
                }
              },
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.searchQuery.isEmpty) {
                return Center(
                  child: Text(
                    'Search for services',
                    style: getTextStyle(
                      fontSize: 14.sp,
                      color: AppColors.textSecondary,
                    ),
                  ),
                );
              }

              if (controller.isLoading.value) {
                return _buildShimmerLoader();
              }

              if (controller.errorMessage.isNotEmpty &&
                  controller.searchResults.isEmpty) {
                return Center(
                  child: Text(
                    controller.errorMessage.value,
                    style: getTextStyle(
                      fontSize: 14.sp,
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              }

              if (controller.searchResults.isEmpty) {
                return Center(
                  child: Text(
                    'No services found',
                    style: getTextStyle(
                      fontSize: 14.sp,
                      color: AppColors.textSecondary,
                    ),
                  ),
                );
              }

              return _buildSearchResultsList(controller.searchResults);
            }),
          ),
        ],
      ),
    );
  }

  static Widget _buildSearchResultsList(List<HomeJobModel> results) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      itemCount: results.length,
      itemBuilder: (context, index) => _buildSearchResultCard(results[index]),
    );
  }

  static Widget _buildSearchResultCard(HomeJobModel service) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ProviderDetailsScreen(providerId: service.userId));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                bottomLeft: Radius.circular(12.r),
              ),
              child: service.thumbnail.isNotEmpty
                  ? Image.network(
                      service.thumbnail,
                      width: 100.w,
                      height: 100.h,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Image.asset(
                        ImagePath.servicecard,
                        width: 100.w,
                        height: 100.h,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Image.asset(
                      ImagePath.servicecard,
                      width: 100.w,
                      height: 100.h,
                      fit: BoxFit.cover,
                    ),
            ),
            // Details
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(12.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Title
                    Text(
                      service.title,
                      style: getTextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    // Provider name
                    Text(
                      service.userFirstName.isNotEmpty
                          ? service.userFirstName
                          : 'Service Provider',
                      style: getTextStyle(
                        fontSize: 11.sp,
                        color: AppColors.textBlue,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 6.h),
                    // Rating and Price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Rating
                        Row(
                          children: [
                            ...List.generate(
                              5,
                              (i) => Icon(
                                i < service.averageRating.round()
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Colors.orange,
                                size: 12.sp,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              service.averageRating.toStringAsFixed(1),
                              style: getTextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        // Price
                        Text(
                          "৳${service.basePrice.toStringAsFixed(0)}",
                          style: getTextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildShimmerLoader() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      itemCount: 6,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(bottom: 12.h),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              ShimmerEffect(
                width: 100.w,
                height: 100.h,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(12.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerEffect(
                        width: double.infinity,
                        height: 12.h,
                      ),
                      SizedBox(height: 8.h),
                      ShimmerEffect(
                        width: 100.w,
                        height: 10.h,
                      ),
                      SizedBox(height: 8.h),
                      ShimmerEffect(
                        width: 150.w,
                        height: 10.h,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
