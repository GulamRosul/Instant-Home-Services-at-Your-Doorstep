import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_button.dart';
import 'package:protiva502/core/utils/constants/image_path.dart';
import 'package:protiva502/features/service_provider/booking/controller/booking_controller.dart';

class BookingCard extends StatelessWidget {
  final BookingController controller;
  final Map<String, dynamic> booking;
  final int index;

  const BookingCard({
    super.key,
    required this.controller,
    required this.booking,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Color(0xFFCBD5E1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Booking Summary',
                style: getTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade800,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: _getStatusColor(
                    booking['status'],
                  ).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  booking['status'],
                  style: getTextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor(booking['status']),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          /// Job Info
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
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Text(
                          'Job Post:${booking['postDate']} ',
                          style: getTextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Budget :${booking['budget']}',
                          style: getTextStyle(
                            fontSize: 12.sp,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Booking id:${booking['bookingId']}',
                      style: getTextStyle(
                        fontSize: 12.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),
          const Divider(color: Color(0xFFDBDBDB)),
          SizedBox(height: 12.h),

          /// Details
          _buildInfoRow(null, 'Client: ${booking['clientName']}'),
          _buildInfoRow(null, 'Payment: ${booking['paymentMethod']}'),
          _buildInfoRow(Icons.calendar_month_outlined, booking['date']!),
          _buildInfoRow(Icons.access_time, booking['time']!),
          _buildInfoRow(Icons.location_on_outlined, booking['location']!),

          SizedBox(height: 16.h),

          /// Actions
          Row(
            children: [
              GestureDetector(
                onTap: () => controller.handleMessage(index),
                child: Text(
                  'Massage',
                  style: getTextStyle(
                    fontSize: 14.sp,
                    color: Color(0xFF0F172A),
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
                    fontSize: 14.sp,
                    color: Color(0xFF0F172A),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),

          /// Pending Buttons
          if (booking['status'] == 'Pending') ...[
            SizedBox(height: 20.h),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 44.h,
                    child: CustomButton(
                      text: 'Accept',
                      onPressed: () => controller.handleAccept(index),
                      backgroundColor: const Color(0xFF22C55E),
                      textColor: Colors.white,
                      borderRadius: 6.r,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),

                Expanded(
                  child: SizedBox(
                    height: 44.h,
                    child: CustomButton(
                      text: 'Reject',
                      onPressed: () => controller.handleReject(index),
                      backgroundColor: const Color(0xFFEF4444),
                      textColor: Colors.white,
                      borderRadius: 6.r,
                    ),
                  ),
                ),
              ],
            ),
          ],
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
            Icon(icon, size: 16.sp, color: Colors.black),
            SizedBox(width: 8.w),
          ],
          Text(
            text,
            style: getTextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return const Color(0xFFEAB308);
      case 'Accepted':
        return const Color(0xFF22C55E);
      case 'Rejected':
        return const Color(0xFFEF4444);
      case 'In-Progress':
        return const Color(0xFF3B82F6);
      default:
        return Colors.grey;
    }
  }
}
