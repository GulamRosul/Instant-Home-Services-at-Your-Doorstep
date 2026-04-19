import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_button.dart';
import 'package:protiva502/core/utils/constants/image_path.dart';
import 'package:protiva502/features/service_provider/booking/controller/booking_controller.dart';
import 'package:protiva502/features/service_provider/home/model/recent_booking_model.dart';
import 'package:protiva502/features/tracking/screen/tracking_screen.dart';
import 'package:protiva502/features/user/user_booking_confirmation/screen/payment_screen.dart';

class BookingCard extends StatelessWidget {
  final BookingController controller;
  final RecentBookingModel booking;
  final int index;

  const BookingCard({
    super.key,
    required this.controller,
    required this.booking,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final status = controller.statusLabelOf(booking);

    final cardContent = Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFCBD5E1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                  color: _getStatusColor(status).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  status,
                  style: getTextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor(status),
                  ),
                ),
              ),
            ],
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
                      booking.serviceName,
                      style: getTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Booking Date: ${_formatDate(booking.createdAt)}',
                            style: getTextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Budget: ${booking.serviceAmount.toStringAsFixed(0)} ৳',
                          style: getTextStyle(
                            fontSize: 12.sp,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Booking id: ${booking.id}',
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
          _buildInfoRow(null, 'Client: ${booking.contactPhone}'),
          _buildInfoRow(
            null,
            'Payment: ${controller.paymentMethodLabelOf(booking)}',
          ),
          _buildInfoRow(
            Icons.calendar_month_outlined,
            _formatDate(booking.preferredDate),
          ),
          _buildInfoRow(Icons.access_time, booking.preferredTime),
          _buildInfoRow(
            Icons.location_on_outlined,
            booking.locationDetails.isEmpty
                ? 'No location details'
                : booking.locationDetails,
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              GestureDetector(
                onTap: () => controller.handleMessage(index),
                child: Text(
                  'Massage',
                  style: getTextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xFF0F172A),
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
                    color: const Color(0xFF0F172A),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              // if (status == 'ACCEPTED') ...[
              //   SizedBox(width: 16.w),
              //   GestureDetector(
              //     onTap: () => Get.to(
              //       () => const PaymentScreen(),
              //       arguments: {
              //         'bookingId': booking.id,
              //         'amount': booking.serviceAmount.toInt(),
              //       },
              //     ),
              //     child: Text(
              //       'Make Payment',
              //       style: getTextStyle(
              //         fontSize: 14.sp,
              //         color: const Color(0xFF7079F0),
              //         decoration: TextDecoration.underline,
              //         fontWeight: FontWeight.w600,
              //       ),
              //     ),
              //   ),
              // ],
            ],
          ),
          if (status == 'Pending') ...[
            SizedBox(height: 20.h),
            Obx(
              () => Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 44.h,
                      child: CustomButton(
                        text: 'Accept',
                        onPressed: controller.isLoading.value
                            ? null
                            : () => controller.handleAccept(index),
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
                        onPressed: controller.isLoading.value
                            ? null
                            : () => controller.handleReject(index),
                        backgroundColor: const Color(0xFFEF4444),
                        textColor: Colors.white,
                        borderRadius: 6.r,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );

    if (status == 'Accepted') {
      return GestureDetector(
        onTap: () => Get.to(
          () => TrackProviderScreen(),
          arguments: {
            'providerName': 'Service Provider',
            'serviceName': booking.serviceName,
            'location': booking.locationDetails.isNotEmpty
                ? booking.locationDetails
                : 'Location not available',
            'rating': '4.8 (170 Reviews)',
            'cost': '৳ ${booking.serviceAmount.toStringAsFixed(2)}',
            'bookingId': booking.id,
            'clientId': booking.clientId,
            'providerId': booking.providerId,
            'userId': booking.providerId,
            'userRole': 'provider',
          },
        ),
        child: cardContent,
      );
    }

    return cardContent;
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
          Expanded(
            child: Text(
              text,
              style: getTextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
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

  String _formatDate(DateTime? date) {
    if (date == null) {
      return 'N/A';
    }

    return '${date.day}/${date.month}/${date.year}';
  }
}
