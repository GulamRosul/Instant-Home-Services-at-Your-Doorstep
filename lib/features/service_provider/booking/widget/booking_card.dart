import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_button.dart';
import 'package:protiva502/core/services/booking_id_service.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/core/utils/constants/image_path.dart';
import 'package:protiva502/features/service_provider/booking/controller/booking_controller.dart';
import 'package:protiva502/features/service_provider/home/model/recent_booking_model.dart';
import 'package:protiva502/features/tracking/screen/tracking_screen.dart';

class BookingCard extends StatelessWidget {
  final BookingController controller;
  final RecentBookingModel booking;
  final int index;

  BookingCard({
    super.key,
    required this.controller,
    required this.booking,
    required this.index,
  });

  final bookingIdService = BookingIdService();

  @override
  Widget build(BuildContext context) {
    final status = controller.statusLabelOf(booking);
    final trackingBookingId = _resolveTrackingBookingId();

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
                'booking_summary'.tr,
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.asset(
                  ImagePath.servicecard,
                  width: 70.w,
                  height: 70.h,
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
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '${'booking_date'.tr}: ${_formatDate(booking.createdAt)}',
                      style: getTextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      '${'budget'.tr}: ${booking.serviceAmount.toStringAsFixed(0)} ৳',
                      style: getTextStyle(fontSize: 12.sp, color: Colors.black, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 4.h),
                    // Text(
                    //   '${'booking_id'.tr}: ${booking.id}',
                    //   style: getTextStyle(
                    //     fontSize: 12.sp,
                    //     color: Colors.black,
                    //     fontWeight: FontWeight.w400,
                    //   ),
                    // ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${'booking_id'.tr}: ${bookingIdService.getTrimmedBookingId(booking.id)}',
                            style: getTextStyle(
                              fontSize: 12.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        /// Copy Icon with ✔ feedback
                        ValueListenableBuilder<bool>(
                          valueListenable: bookingIdService.isCopied,
                          builder: (context, copied, _) {
                            return GestureDetector(
                              onTap: () =>
                                  bookingIdService.copyBookingId(booking.id),
                              child: Padding(
                                padding: EdgeInsets.only(left: 6.w),
                                child: Icon(
                                  copied ? Icons.check_circle : Icons.copy,
                                  size: 16.sp,
                                  color: copied ? Colors.green : Colors.grey,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          const Divider(color: Color(0xFFDBDBDB)),
          SizedBox(height: 12.h),
          // _buildInfoRow(null, 'Client: ${booking.contactPhone}'),
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
              // GestureDetector(
              //   onTap: () => controller.handleMessage(index),
              //   child: Text(
              //     'Massage',
              //     style: getTextStyle(
              //       fontSize: 14.sp,
              //       color: const Color(0xFF0F172A),
              //       decoration: TextDecoration.underline,
              //     ),
              //   ),
              // ),
              SizedBox(width: 16.w),
              GestureDetector(
                onTap: () => controller.handleViewDetails(index),
                child: Text(
                  'view_details'.tr,
                  style: getTextStyle(
                    fontSize: 14.sp,
                    color: AppColors.textPurple,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w600,
                    decorationColor: AppColors.textPurple,
                  ),
                ),
              ),
              if (status == 'Accepted') ...[
                SizedBox(width: 16.w),
                GestureDetector(
                  onTap: () {
                    if (trackingBookingId.isEmpty) {
                      Get.snackbar(
                        'Booking update',
                        'Booking ID is unavailable for tracking.',
                      );
                      return;
                    }

                    Get.to(
                      () => TrackProviderScreen(),
                      arguments: {
                        'providerName': 'Service Provider',
                        'serviceName': booking.serviceName,
                        'location': booking.locationDetails.isNotEmpty
                            ? booking.locationDetails
                            : 'Location not available',
                        'rating': '4.8 (170 Reviews)',
                        'cost': '৳ ${booking.serviceAmount.toStringAsFixed(2)}',
                        'bookingId': trackingBookingId,
                        'clientId': booking.clientId,
                        'providerId': booking.providerId,
                        'userId': booking.providerId,
                        'userRole': 'provider',
                        'userLocationLatitude': booking.locationLatitude,
                        'userLocationLongitude': booking.locationLongitude,
                        'userLocationDetails': booking.locationDetails,
                      },
                    );
                  },
                  child: Text(
                    'track_customer'.tr,
                    style: getTextStyle(
                      fontSize: 14.sp,
                      color: AppColors.textPurple,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w600,
                      decorationColor: AppColors.textPurple,
                    ),
                  ),
                ),
              ],
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
                        text: 'accept'.tr,
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
                        text: 'reject'.tr,
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
        onTap: () {
          if (trackingBookingId.isEmpty) {
            Get.snackbar('booking_update'.tr, 'booking_id_unavailable'.tr);
            return;
          }

          Get.to(
            () => TrackProviderScreen(),
            arguments: {
              'providerName': 'Service Provider',
              'serviceName': booking.serviceName,
              'location': booking.locationDetails.isNotEmpty
                  ? booking.locationDetails
                  : 'Location not available',
              'rating': '4.8 (170 Reviews)',
              'cost': '৳ ${booking.serviceAmount.toStringAsFixed(2)}',
              'bookingId': trackingBookingId,
              'clientId': booking.clientId,
              'providerId': booking.providerId,
              'userId': booking.providerId,
              'userRole': 'provider',
              'userLocationLatitude': booking.locationLatitude,
              'userLocationLongitude': booking.locationLongitude,
              'userLocationDetails': booking.locationDetails,
            },
          );
        },
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

  String _resolveTrackingBookingId() {
    if (booking.id.trim().isNotEmpty) {
      return booking.id.trim();
    }

    if (booking.bookingNumber.trim().isNotEmpty) {
      return booking.bookingNumber.trim();
    }

    return '';
  }
}
