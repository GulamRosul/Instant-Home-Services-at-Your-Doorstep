import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_button.dart';
import 'package:protiva502/core/services/storage_service.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/features/service_provider/my_job_list/model/job_model.dart';
import 'package:protiva502/features/service_provider/my_job_list/controller/my_job_list_controller.dart';
import 'package:protiva502/features/user/user_booking_confirmation/screen/booking_details_screen.dart';

class JobDetailsViewScreen extends StatelessWidget {
  const JobDetailsViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final JobModel job = Get.arguments;
    final controller = Get.find<MyJobListController>();
    final userRole = StorageService.getRole();
    final isProvider = userRole == 'PROVIDER';

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF09090B),
            size: 20,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Service Details',
          style: getTextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xFF3F3F3F),
          ),
        ),
        centerTitle: false,
        actions: [
          if (isProvider)
            PopupMenuButton(
              icon: const Icon(Icons.more_vert, color: Color(0xFF09090B)),
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'edit',
                  child: Text(
                    'Edit',
                    style: getTextStyle(fontSize: 14.sp, color: Colors.black87),
                  ),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Text(
                    'Delete',
                    style: getTextStyle(fontSize: 14.sp, color: Colors.red),
                  ),
                ),
              ],
              onSelected: (value) {
                if (value == 'edit') {
                  // Find the index of the job in the controller's listings
                  final index = controller.listings.indexWhere(
                    (j) => j.id == job.id,
                  );
                  if (index != -1) {
                    controller.handleEditListing(index);
                  }
                } else if (value == 'delete') {
                  _showDeleteConfirmation(context, controller, job.id);
                }
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(color: Color(0xFFCBD5E1), height: 1),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail Image
            _buildThumbnailSection(job),

            // Service Details
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Price
                  Text(
                    job.title,
                    style: getTextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Start From ${job.basePrice} ৳',
                        style: getTextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPurple,
                        ),
                      ),
                      if (job.priceType.isNotEmpty)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFFE8EAFF),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text(
                            job.priceType,
                            style: getTextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textPurple,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 12.h),

                  // Rating and Status
                  Row(
                    children: [
                      ...List.generate(
                        5,
                        (i) => Icon(
                          i < (job.averageRating?.toInt() ?? 0)
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.orange,
                          size: 14.sp,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        '${job.averageRating ?? 0.0}',
                        style: getTextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                      const Spacer(),
                      _buildStatusBadge(job.status),
                    ],
                  ),
                  SizedBox(height: 16.h),

                  // Description
                  _buildSectionTitle('Description'),
                  SizedBox(height: 8.h),
                  Text(
                    job.description.isEmpty
                        ? 'No description available'
                        : job.description,
                    style: getTextStyle(
                      fontSize: 13.sp,
                      color: Color(0xFF475569),
                      lineHeight: 18.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Service Includes
                  if (job.includeService.isNotEmpty) ...[
                    _buildSectionTitle('What\'s Included'),
                    SizedBox(height: 8.h),
                    ...job.includeService.map(
                      (service) => Padding(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: AppColors.textPurple,
                              size: 18.sp,
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                service,
                                style: getTextStyle(
                                  fontSize: 13.sp,
                                  color: Color(0xFF475569),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                  ],

                  // Gallery
                  if (job.images.isNotEmpty || job.videos.isNotEmpty)
                    _buildGallerySection(job),

                  SizedBox(height: 16.h),

                  // Analytics (for providers) or Booking Button (for users)
                  if (isProvider)
                    _buildAnalyticsSection(job)
                  else
                    CustomButton(
                      text: 'Booking',
                      onPressed: () =>
                          Get.to(() => BookingDetailsScreen(), arguments: job),
                      backgroundColor: AppColors.textPurple,
                      textColor: Colors.white,
                    ),

                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThumbnailSection(JobModel job) {
    return Container(
      width: double.infinity,
      height: 250.h,
      color: Colors.grey.shade200,
      child: job.thumbnail.trim().isNotEmpty
          ? Image.network(
              job.thumbnail,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Center(
                child: Icon(
                  Icons.image_not_supported,
                  size: 50.sp,
                  color: Colors.grey,
                ),
              ),
            )
          : Center(
              child: Icon(Icons.image, size: 50.sp, color: Colors.grey),
            ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color bgColor;
    Color textColor;

    switch (status.toUpperCase()) {
      case 'ACTIVE':
        bgColor = Color(0xFFD1FAE5);
        textColor = Color(0xFF065F46);
        break;
      case 'DRAFT':
        bgColor = Color(0xFFFEF3C7);
        textColor = Color(0xFF78350F);
        break;
      case 'INACTIVE':
        bgColor = Color(0xFFFEE2E2);
        textColor = Color(0xFF7F1D1D);
        break;
      default:
        bgColor = Color(0xFFE5E7EB);
        textColor = Color(0xFF374151);
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        status,
        style: getTextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: getTextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
    );
  }

  Widget _buildGallerySection(JobModel job) {
    final allMedia = [
      ...job.images.where((img) => img != null && img.toString().isNotEmpty),
      ...job.videos.where((vid) => vid != null && vid.toString().isNotEmpty),
    ];

    if (allMedia.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Gallery'),
        SizedBox(height: 12.h),
        SizedBox(
          height: 100.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: allMedia.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(right: 12.w),
                width: 100.w,
                height: 100.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: Colors.grey.shade200,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.network(
                    allMedia[index].toString(),
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Center(
                      child: Icon(
                        Icons.broken_image,
                        color: Colors.grey,
                        size: 24.sp,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }

  Widget _buildAnalyticsSection(JobModel job) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Analytics'),
          SizedBox(height: 12.h),
          _buildAnalyticsItem(
            'Views',
            '${job.views}',
            Icons.visibility_outlined,
          ),
          SizedBox(height: 12.h),
          _buildAnalyticsItem(
            'Clicks',
            '${job.clicks}',
            Icons.touch_app_outlined,
          ),
          SizedBox(height: 12.h),
          _buildAnalyticsItem(
            'Bookings',
            '${job.totalBookings}',
            Icons.calendar_month_outlined,
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsItem(String label, String value, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, size: 18.sp, color: AppColors.textPurple),
            SizedBox(width: 8.w),
            Text(
              label,
              style: getTextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
        Text(
          value,
          style: getTextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textPurple,
          ),
        ),
      ],
    );
  }

  void _showDeleteConfirmation(
    BuildContext context,
    MyJobListController controller,
    String jobId,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Delete Service',
          style: getTextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
        ),
        content: Text(
          'Are you sure you want to delete this service? This action cannot be undone.',
          style: getTextStyle(fontSize: 14.sp, color: Color(0xFF475569)),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: getTextStyle(fontSize: 14.sp, color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              // Find the index of the job in the controller's listings
              final index = controller.listings.indexWhere(
                (job) => job.id == jobId,
              );
              if (index != -1) {
                controller.handleDeleteListing(index);
              }
            },
            child: Text(
              'Delete',
              style: getTextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
