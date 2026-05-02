import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_appbar.dart';
import 'package:protiva502/core/common/widgets/custom_button.dart';
import 'package:protiva502/core/services/storage_service.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/core/utils/constants/image_path.dart';
import 'package:protiva502/features/service_provider/my_job_list/model/job_model.dart';
import 'package:protiva502/features/service_provider/my_job_list/screen/job_details_view_screen.dart';
import 'package:protiva502/features/user/authentication/widget/log_in_alert_dialogue.dart';
import 'package:protiva502/features/user/home/controller/subcategory_service_list_controller.dart';
import 'package:protiva502/features/user/home/model/subcategory_service_model.dart';
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
        child: Obx(() {
          if (controller.isLoading.value && controller.services.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.errorMessage.value.isNotEmpty &&
              controller.services.isEmpty) {
            return Center(
              child: Text(
                controller.errorMessage.value,
                style: getTextStyle(
                  fontSize: 14.sp,
                  color: AppColors.textSecondary,
                ),
              ),
            );
          }

          if (controller.services.isEmpty) {
            return Center(
              child: Text(
                'no_services_available'.tr,
                style: getTextStyle(
                  fontSize: 14.sp,
                  color: AppColors.textSecondary,
                ),
              ),
            );
          }

          return ListView(
            controller: controller.scrollController,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
            children: [
              _buildHeader(),
              SizedBox(height: 15.h),
              _buildServiceGrid(controller),
              if (controller.isLoadingMore.value)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: const Center(child: CircularProgressIndicator()),
                ),
              SizedBox(height: 100.h), // Space for floating nav bar
            ],
          );
        }),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'featured_provider'.tr,
          style: getTextStyle(
            fontSize: 18.sp,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          'featured_provider_description'.tr,
          style: getTextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildServiceCard(
    SubcategoryServiceListController controller,
    int index,
    SubcategoryServiceModel service, // ✅ correct type
  ) {
    // final service = controller.services[index];

    return Container(
      margin: EdgeInsets.all(5.w),
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
          GestureDetector(
            onTap: () {
              // Get.to(() => const CategoryServiceDetailsScreen());
              Get.to(
                () => const JobDetailsViewScreen(),
                arguments: _mapHomeJobToJobModel(service),
                // arguments: _mapHomeJobToJobModel(service),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
              child: service.thumbnail.isNotEmpty
                  ? Image.network(
                      service.thumbnail,
                      height: 100.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          ImagePath.servicecard,
                          height: 100.h,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        );
                      },
                    )
                  : Image.asset(
                      ImagePath.servicecard,
                      height: 100.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.all(8.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    service.title,
                    style: getTextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      lineHeight: 15.sp,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(
                        () => ProviderDetailsScreen(providerId: service.userId),
                      );
                    },
                    child: Text(
                      'view_provider'.tr,
                      style: getTextStyle(
                        fontSize: 10.sp,
                        color: AppColors.textBlue,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.textBlue,
                        fontWeight: FontWeight.w600,
                        lineHeight: 15.sp,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Icon(Icons.star_half, size: 10.sp, color: Colors.orange),
                      Flexible(
                        child: Text(
                          " ${service.averageRating ?? 'N/A'} (${service.totalBookings} ${'bookings_text'.tr})",
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
                  SizedBox(height: 2.h),
                  Text(
                    '${'start_from'.tr} ৳${service.basePrice}',
                    style: getTextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  CustomButton(
                    text: 'book_now'.tr,
                    height: 28.h,
                    backgroundColor: AppColors.textPurple,
                    borderRadius: 6.r,
                    onPressed: () {
                      if (!StorageService.isLoggedIn) {
                        showLoginAlertDialog();
                        return;
                      }
                      Get.to(() => const BookingDetailsScreen());
                    },
                    textColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showLoginAlertDialog() {
    Get.dialog(const LoginAlertDialog(), barrierDismissible: true);
  }

  JobModel _mapHomeJobToJobModel(SubcategoryServiceModel service) {
    return JobModel(
      id: service.id,
      userId: service.userId,
      title: service.title,
      description: service.description,
      basePrice: service.basePrice,
      thumbnail: service.thumbnail,
      totalBookings: service.totalBookings,
      averageRating: service.averageRating,
      isPopuler: service.isPopuler,
      // ... map remaining fields
      categoryId: '',
      subCategoryId: '',
      slug: '',
      priceType: '',
      includeService: const [],
      images: const [],
      videos: const [],
      status: 'ACTIVE',
      views: 0,
      clicks: 0,
      createdAt: '',
      updatedAt: '',
    );
  }

  Widget _buildServiceGrid(SubcategoryServiceListController controller) {
    return GridView.builder(
      // itemCount: controller.services.length
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.services.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 5.h,
        crossAxisSpacing: 5.w,
        mainAxisExtent: 260.h,
      ),
      itemBuilder: (context, index) => _buildServiceCard(
        controller,
        index,
        controller.services[index], // ✅ RxList<SubcategoryServiceModel>
      ),
    );
  }

  // Widget _buildServiceGrid(SubcategoryServiceListController controller, List<HomeJobModel> services) {
  //   return GridView.builder(
  //     shrinkWrap: true,
  //     padding: EdgeInsets.zero,
  //     physics: const NeverScrollableScrollPhysics(),
  //     itemCount: controller.services.length,
  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //       crossAxisCount: 2,
  //       mainAxisSpacing: 5.h,
  //       crossAxisSpacing: 5.w,
  //       mainAxisExtent: 260.h,
  //     ),
  //     itemBuilder: (context, index) => _buildServiceCard(controller, index, services[index]),
  //   );
  // }
}
