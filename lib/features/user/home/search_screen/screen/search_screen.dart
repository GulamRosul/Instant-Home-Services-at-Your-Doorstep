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
import 'package:protiva502/features/service_provider/my_job_list/model/job_model.dart';
import 'package:protiva502/features/service_provider/my_job_list/screen/job_details_view_screen.dart';
import 'package:protiva502/features/user/home/screen/available_category_screen.dart';

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
              hintText: "Search Service or Category",
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
                    'Search for services or categories',
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
    // Separate results into services and categories
    final services = results.where((item) => item.type == 'job').toList();
    final categories = results
        .where((item) => item.type == 'category')
        .toList();

    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      children: [
        // Services Section
        if (services.isNotEmpty) ...[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 8.h, 0, 12.h),
            child: Text(
              'Service',
              style: getTextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
          ...services.map((service) => _buildServiceCard(service)),
        ],
        // Categories Section
        if (categories.isNotEmpty) ...[
          if (services.isNotEmpty) SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 8.h, 0, 12.h),
            child: Text(
              'Category',
              style: getTextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
          ...categories.map((category) => _buildCategoryCard(category)),
        ],
      ],
    );
  }

  static Widget _buildServiceCard(HomeJobModel service) {
    return GestureDetector(
      onTap: () {
        // Create a JobModel from HomeJobModel for navigation
        final jobModel = JobModel(
          id: service.id,
          userId: service.userId,
          categoryId: service.categoryId,
          subCategoryId: '',
          title: service.title,
          slug: service.slug,
          description: service.description,
          basePrice: service.basePrice.toString(),
          priceType: '',
          includeService: [],
          thumbnail: service.thumbnail,
          images: [],
          videos: [],
          status: 'ACTIVE',
          views: 0,
          clicks: 0,
          totalBookings: service.totalBookings,
          isPopuler: service.isPopular,
          createdAt: '',
          updatedAt: '',
          averageRating: service.averageRating,
        );
        Get.to(() => const JobDetailsViewScreen(), arguments: jobModel);
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
                      width: 70.w,
                      height: 70.h,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Image.asset(
                        ImagePath.servicecard,
                        width: 70.w,
                        height: 70.h,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Image.asset(
                      ImagePath.servicecard,
                      width: 70.w,
                      height: 70.h,
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
                    // Text(
                    //   service.userFirstName.isNotEmpty
                    //       ? service.userFirstName
                    //       : 'Service Provider',
                    //   style: getTextStyle(
                    //     fontSize: 11.sp,
                    //     color: AppColors.textBlue,
                    //     fontWeight: FontWeight.w500,
                    //   ),
                    //   maxLines: 1,
                    //   overflow: TextOverflow.ellipsis,
                    // ),
                    Text(
                      service.description.isNotEmpty
                          ? service.description
                          : 'No description available',
                      style: getTextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    SizedBox(height: 6.h),
                    // Rating and Price
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     // Rating
                    //     Row(
                    //       children: [
                    //         ...List.generate(
                    //           5,
                    //           (i) => Icon(
                    //             i < service.averageRating.round()
                    //                 ? Icons.star
                    //                 : Icons.star_border,
                    //             color: Colors.orange,
                    //             size: 12.sp,
                    //           ),
                    //         ),
                    //         SizedBox(width: 4.w),
                    //         Text(
                    //           service.averageRating.toStringAsFixed(1),
                    //           style: getTextStyle(
                    //             fontSize: 10.sp,
                    //             fontWeight: FontWeight.w500,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //     // Price
                    //     Text(
                    //       "৳${service.basePrice.toStringAsFixed(0)}",
                    //       style: getTextStyle(
                    //         fontSize: 12.sp,
                    //         fontWeight: FontWeight.w700,
                    //         color: Colors.black,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildCategoryCard(HomeJobModel category) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => const AvailableCategoryScreen(),
          arguments: {'categoryId': category.id},
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.r),
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
            // Category Icon/Thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: category.thumbnail.isNotEmpty
                  ? Image.network(
                      category.thumbnail,
                      width: 60.w,
                      height: 60.h,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 60.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(
                          Icons.category,
                          size: 32.sp,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : Container(
                      width: 60.w,
                      height: 60.h,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Icon(
                        Icons.category,
                        size: 32.sp,
                        color: Colors.grey,
                      ),
                    ),
            ),
            SizedBox(width: 12.w),
            // Category Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Title
                  Text(
                    category.title,
                    style: getTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 6.h),
                  // Description
                  Text(
                    category.description.isNotEmpty
                        ? category.description
                        : 'Explore this category',
                    style: getTextStyle(
                      fontSize: 11.sp,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            // Arrow Icon
            Icon(
              Icons.arrow_forward_ios,
              size: 16.sp,
              color: AppColors.textBlue,
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
              ShimmerEffect(width: 100.w, height: 100.h),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(12.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerEffect(width: double.infinity, height: 12.h),
                      SizedBox(height: 8.h),
                      ShimmerEffect(width: 100.w, height: 10.h),
                      SizedBox(height: 8.h),
                      ShimmerEffect(width: 150.w, height: 10.h),
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
