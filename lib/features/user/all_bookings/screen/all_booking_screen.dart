import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_appbar.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/core/utils/constants/image_path.dart';
import 'package:protiva502/features/user/all_bookings/controller/all_booking_controller.dart';
import 'package:protiva502/features/user/all_bookings/widget/review_widget.dart';
import 'package:protiva502/features/user/track_provider/screen/track_provider_screen.dart';
import 'package:protiva502/features/user/user_booking_confirmation/screen/booking_details_screen.dart';

class AllBookingScreen extends StatelessWidget {
  const AllBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllBookingController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: const CustomAppBar(title: '  Bookings'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            Text(
              "Booking service",
              style: getTextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              "Book Your Service in Just a Few Clicks",
              style: getTextStyle(
                fontSize: 12.sp,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 20.h),

            // Top Summary Grid
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 5.w,
              mainAxisSpacing: 5.h,
              childAspectRatio: 2.0,
              padding: EdgeInsets.zero,
              children: [
                _buildSummaryCard(
                  "20",
                  "Total Bookings",
                  Icons.assignment,
                  const Color.fromARGB(255, 255, 152, 0),
                ),
                _buildSummaryCard(
                  "02",
                  "Bookings Accepted",
                  Icons.check_circle,
                  const Color.fromARGB(255, 76, 175, 80),
                ),
                _buildSummaryCard(
                  "01",
                  "Service in-progress",
                  Icons.settings,
                  const Color.fromARGB(255, 255, 193, 7),
                ),
                _buildSummaryCard(
                  "05",
                  "Completed Service",
                  Icons.assignment_turned_in,
                  AppColors.textBlue,
                ),
              ],
            ),

            SizedBox(height: 30.h),
            _buildFilterHeader(controller),
            SizedBox(height: 16.h),

            // Reactive Booking List
            Obx(
              () => ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.filteredBookings.length,
                itemBuilder: (context, index) {
                  final booking = controller.filteredBookings[index];
                  return _buildBookingCard(context, booking);
                },
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(
    String count,
    String label,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.defaultBorder.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(icon, color: Colors.white, size: 20.sp),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  count,
                  style: getTextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                Text(
                  label,
                  style: getTextStyle(
                    fontSize: 11.sp,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w400,
                    lineHeight: 11.sp,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterHeader(AllBookingController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Booking Services",
          style: getTextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: AppColors.textPurple),
          ),
          child: Obx(
            () => DropdownButton<String>(
              dropdownColor: Colors.white,
              value: controller.selectedStatus.value,
              underline: const SizedBox(),
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.textPurple,
                size: 20.sp,
              ),
              items: controller.statusOptions.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: getTextStyle(
                      fontSize: 13.sp,
                      color: AppColors.textPurple,
                    ),
                  ),
                );
              }).toList(),
              onChanged: controller.updateStatus,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBookingCard(BuildContext context, Map<String, dynamic> booking) {
    Color statusColor = _getStatusColor(booking['status']);

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.asset(
                  ImagePath.servicecard,
                  width: 60.w,
                  height: 50.h,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          booking['name'],
                          style: getTextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          booking['status'],
                          style: getTextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: statusColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "– ${booking['location']}",
                      style: getTextStyle(
                        fontSize: 11.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      "Starting : \$${booking['price']}",
                      style: getTextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        ...List.generate(
                          5,
                          (i) => Icon(
                            Icons.star,
                            color: Colors.orange,
                            size: 12.sp,
                          ),
                        ),
                        Text(
                          " 4.8 (170 Reviews)",
                          style: getTextStyle(
                            fontSize: 10.sp,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (booking['status'] == 'Completed') ...[
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActionText("View Details", () {}),
                _buildActionText("Book Again", () {
                  Get.to(() => BookingDetailsScreen());
                }),
                _buildActionText("Write Review", () {
                  showDialog(
                    context: context,
                    builder: (context) => const ReviewWidget(),
                  );
                }),
              ],
            ),
          ] else
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  if (booking['status'] == 'Accepted') {
                    // Get.toNamed(AppRoute.getTrackProviderScreen());
                    Get.to(() => const TrackProviderScreen());
                  }
                },
                child: Text(
                  "View Details",
                  style: getTextStyle(
                    fontSize: 12.sp,
                    color: AppColors.textPurple,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.textPurple,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildActionText(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        label,
        style: getTextStyle(
          fontSize: 12.sp,
          color: AppColors.textPurple,
          decoration: TextDecoration.underline,
          decorationColor: AppColors.textPurple,
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'accepted':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      case 'in-progress':
        return Colors.purple;
      case 'completed':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
