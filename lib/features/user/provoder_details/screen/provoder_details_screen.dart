import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_appbar.dart';
import 'package:protiva502/core/common/widgets/custom_button.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/core/utils/constants/image_path.dart';
import 'package:protiva502/features/user/provoder_details/controller/provoder_details_controller.dart';
import 'package:protiva502/features/user/provoder_details/model/provider_details_model.dart';

class ProviderDetailsScreen extends StatelessWidget {
  const ProviderDetailsScreen({super.key, this.providerId = ''});

  final String providerId;

  @override
  Widget build(BuildContext context) {
    final tag = providerId.isEmpty
        ? 'provider-details-screen'
        : 'provider-details-$providerId';
    final controller = Get.isRegistered<ProviderDetailsController>(tag: tag)
        ? Get.find<ProviderDetailsController>(tag: tag)
        : Get.put(ProviderDetailsController(providerId: providerId), tag: tag);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: const CustomAppBar(title: 'Service Profile'),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.value.isNotEmpty) {
          return _buildStatusState(
            title: controller.errorMessage.value,
            buttonText: 'Retry',
            onPressed: controller.fetchProviderDetails,
          );
        }

        final details = controller.provider.value;
        if (details == null) {
          return _buildStatusState(title: 'Provider details not found');
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20.h),
              _buildProfileHeader(controller, details),
              SizedBox(height: 24.h),
              _buildAboutSection(controller),
              SizedBox(height: 24.h),
              _buildProvideServicesSection(controller),
              SizedBox(height: 24.h),
              _buildReviewFeed(controller),
              SizedBox(height: 40.h),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildProfileHeader(
    ProviderDetailsController controller,
    ProviderDetailsModel details,
  ) {
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
                    backgroundImage: (details.avatar ?? '').trim().isNotEmpty
                        ? NetworkImage(details.avatar!.trim())
                        : const AssetImage(ImagePath.profile) as ImageProvider,
                  ),
                  if (controller.isVerified)
                    CircleAvatar(
                      radius: 12.r,
                      backgroundColor: Colors.amber,
                      child: Icon(
                        Icons.check,
                        size: 14.sp,
                        color: Colors.white,
                      ),
                    ),
                ],
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.displayName,
                      style: getTextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 18.sp,
                          color: Colors.blue,
                        ),
                        Expanded(
                          child: Text(
                            ' ${controller.locationText}',
                            style: getTextStyle(
                              fontSize: 13.sp,
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      controller.isServiceAvailable
                          ? 'Available for service'
                          : 'Currently unavailable',
                      style: getTextStyle(
                        fontSize: 12.sp,
                        color: controller.isServiceAvailable
                            ? const Color(0xFF16A34A)
                            : AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
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
                        (i) => Icon(
                          i < details.avgReview.round()
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.orange,
                          size: 14.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "${controller.ratingText} (${controller.reviewCount} Reviews)",
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
            controller.aboutTitle,
            style: getTextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 8.h),
          Text(
            controller.aboutDescription,
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
          if (controller.skills.isEmpty)
            Text(
              'No skills available',
              style: getTextStyle(fontSize: 12.sp, color: Colors.black54),
            )
          else
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
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
                controller.jobs.isEmpty
                    ? "No published services available right now."
                    : "Professional solutions tailored to your needs.",
                style: getTextStyle(fontSize: 12.sp, color: Colors.grey),
              ),
            ],
          ),
        ),
        if (controller.jobs.isEmpty) ...[
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: _buildInfoCard('This provider has no services to show yet.'),
          ),
        ] else ...[
          SizedBox(height: 16.h),
          Obx(
            () => Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: List.generate(controller.jobs.length, (index) {
                      final isLast = index == controller.jobs.length - 1;
                      return Padding(
                        padding: EdgeInsets.only(right: isLast ? 0 : 12.w),
                        child: _buildServiceTab(
                          controller.jobs[index].title,
                          index,
                          controller,
                        ),
                      );
                    }),
                  ),
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  height: 250.h,
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.selectedJob == null ? 0 : 1,
                    itemBuilder: (context, index) =>
                        _buildServiceCard(controller, controller.selectedJob!),
                  ),
                ),
              ],
            ),
          ),
        ],
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

  Widget _buildServiceCard(
    ProviderDetailsController controller,
    ProviderJobModel service,
  ) {
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
            child: service.thumbnail.trim().isNotEmpty
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
              children: [
                Text(
                  service.title,
                  style: getTextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  service.description.isNotEmpty
                      ? service.description
                      : 'Professional service from this provider.',
                  style: getTextStyle(
                    fontSize: 10.sp,
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
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
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  "Start From ${service.basePrice.toStringAsFixed(service.basePrice % 1 == 0 ? 0 : 2)} ৳",
                  style: getTextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8.h),
                CustomButton(
                  text: "Book For Service",
                  onPressed: () => controller.bookSpecificService(service.id),
                  backgroundColor: AppColors.textPurple,
                  textColor: Colors.white,
                  height: 30.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewFeed(ProviderDetailsController controller) {
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
          if (controller.reviews.isEmpty)
            _buildInfoCard('No reviews available yet.')
          else
            ...controller.reviews.map((review) => _buildSingleReview(review)),
        ],
      ),
    );
  }

  Widget _buildSingleReview(ProviderReviewModel review) {
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
                    "Customer Review",
                    style: getTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    children: List.generate(
                      5,
                      (i) => Icon(
                        i < review.rating ? Icons.star : Icons.star_border,
                        color: Colors.orange,
                        size: 12.sp,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                review.createdAt == null
                    ? 'Recently'
                    : DateFormat(
                        'dd MMM yyyy',
                      ).format(review.createdAt!.toLocal()),
                style: getTextStyle(fontSize: 11.sp, color: Colors.grey),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            review.comment.isNotEmpty
                ? review.comment
                : 'No written feedback provided.',
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

  Widget _buildStatusState({
    required String title,
    String? buttonText,
    VoidCallback? onPressed,
  }) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: getTextStyle(
                fontSize: 14.sp,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (buttonText != null && onPressed != null) ...[
              SizedBox(height: 16.h),
              CustomButton(
                text: buttonText,
                onPressed: onPressed,
                backgroundColor: AppColors.textPurple,
                textColor: Colors.white,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String message) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Text(
        message,
        style: getTextStyle(
          fontSize: 13.sp,
          color: AppColors.textSecondary,
          lineHeight: 18.sp,
        ),
      ),
    );
  }
}
