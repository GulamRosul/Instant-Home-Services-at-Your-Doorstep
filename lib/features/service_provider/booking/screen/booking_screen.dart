import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/utils/constants/image_path.dart';
import 'package:protiva502/features/service_provider/booking/controller/booking_controller.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BookingController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Bookings',
          style: getTextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              _buildStatsGrid(controller),
              SizedBox(height: 24.h),
              Text(
                'Booking service',
                style: getTextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'View All Bookings customers have Done',
                style: getTextStyle(
                  fontSize: 13.sp,
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(height: 20.h),
              _buildTabs(controller),
              SizedBox(height: 20.h),
              Obx(
                () => ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.bookings.length,
                  separatorBuilder: (context, index) => SizedBox(height: 16.h),
                  itemBuilder: (context, index) {
                    final booking = controller.bookings[index];
                    return _buildBookingCard(controller, booking, index);
                  },
                ),
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsGrid(BookingController controller) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15.w,
        mainAxisSpacing: 15.h,
        childAspectRatio: 1.4,
      ),
      itemCount: controller.stats.length,
      itemBuilder: (context, index) {
        final stat = controller.stats[index];
        return Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.grey.shade100),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildStatIcon(stat['icon']!),
              const Spacer(),
              Text(
                stat['value']!,
                style: getTextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                stat['label']!,
                style: getTextStyle(
                  fontSize: 11.sp,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatIcon(String type) {
    IconData iconData;
    Color bgColor;
    Color iconColor;

    switch (type) {
      case 'flag':
        iconData = Icons.flag_outlined;
        bgColor = const Color(0xFFFFF7ED);
        iconColor = Colors.orange;
        break;
      case 'confirmed':
        iconData = Icons.check_circle_outline_rounded;
        bgColor = const Color(0xFFF0FDF4);
        iconColor = Colors.green;
        break;
      case 'star':
        iconData = Icons.star_outline_rounded;
        bgColor = const Color(0xFFFFFBEB);
        iconColor = Colors.amber;
        break;
      default:
        iconData = Icons.account_balance_wallet_outlined;
        bgColor = const Color(0xFFF0F9FF);
        iconColor = Colors.blue;
    }

    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Icon(iconData, color: iconColor, size: 16.sp),
    );
  }

  Widget _buildTabs(BookingController controller) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Obx(
        () => Row(
          children: controller.tabs.asMap().entries.map((entry) {
            int idx = entry.key;
            String label = entry.value;
            bool isSelected = controller.selectedTabIndex.value == idx;
            return GestureDetector(
              onTap: () => controller.changeTab(idx),
              child: Container(
                margin: EdgeInsets.only(right: 12.w),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  border: isSelected
                      ? Border(
                          bottom: BorderSide(
                            color: const Color(0xFF7079F0),
                            width: 2.h,
                          ),
                        )
                      : null,
                ),
                child: Text(
                  label,
                  style: getTextStyle(
                    fontSize: 13.sp,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected
                        ? const Color(0xFF7079F0)
                        : Colors.grey.shade600,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildBookingCard(
    BookingController controller,
    Map<String, String> booking,
    int index,
  ) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Booking Summary',
            style: getTextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade800,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.asset(
                  ImagePath.servicecard,
                  width: 50.w,
                  height: 50.w,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      booking['title']!,
                      style: getTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Text(
                          'Job Post:${booking['postDate']} ',
                          style: getTextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        Text(
                          'Budget :${booking['budget']}',
                          style: getTextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Booking id:${booking['bookingId']}',
                      style: getTextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          const Divider(),
          SizedBox(height: 12.h),
          _buildInfoRow(null, 'Client: ${booking['clientName']}'),
          _buildInfoRow(null, 'Payment: ${booking['paymentMethod']}'),
          _buildInfoRow(Icons.calendar_month_outlined, booking['date']!),
          _buildInfoRow(Icons.access_time, booking['time']!),
          _buildInfoRow(Icons.location_on_outlined, booking['location']!),
          SizedBox(height: 16.h),
          Row(
            children: [
              GestureDetector(
                onTap: () => controller.handleMessage(index),
                child: Text(
                  'Massage',
                  style: getTextStyle(
                    fontSize: 13.sp,
                    color: Colors.grey.shade800,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              GestureDetector(
                onTap: () => controller.handleViewDetails(index),
                child: Text(
                  'View Details',
                  style: getTextStyle(
                    fontSize: 13.sp,
                    color: Colors.grey.shade800,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 44.h,
                  child: ElevatedButton(
                    onPressed: () => controller.handleAccept(index),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF22C55E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Accept',
                      style: getTextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: SizedBox(
                  height: 44.h,
                  child: ElevatedButton(
                    onPressed: () => controller.handleReject(index),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEF4444),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Reject',
                      style: getTextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData? icon, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16.sp, color: Colors.grey.shade500),
            SizedBox(width: 8.w),
          ],
          Text(
            text,
            style: getTextStyle(fontSize: 12.sp, color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }
}
