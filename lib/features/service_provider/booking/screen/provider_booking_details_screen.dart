import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_button.dart';
import 'package:protiva502/features/service_provider/booking/controller/booking_controller.dart';
import 'package:protiva502/features/service_provider/home/model/recent_booking_model.dart';

class ProviderBookingDetailsScreen extends StatelessWidget {
  const ProviderBookingDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RecentBookingModel booking = Get.arguments as RecentBookingModel;
    final controller = Get.find<BookingController>();
    final status = controller.statusLabelOf(booking);

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
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Booking Details',
                        style: getTextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Booking # ${booking.id}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: getTextStyle(
                          fontSize: 12.sp,
                          color: const Color(0xFF334155),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12.w),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(status).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: _getStatusColor(status).withValues(alpha: 0.3),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      status,
                      style: getTextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: _getStatusColor(status),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: const Color(0xFFCBD5E1)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildInfoBlock(
                          'Payment Method',
                          'Amount : ${booking.serviceAmount.toStringAsFixed(0)} ৳',
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: _buildInfoBlock(
                          'Schedule Date :',
                          _formatDate(booking.preferredDate),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Pay Via : ',
                        style: getTextStyle(
                          color: const Color(0xFF18181A),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        controller.paymentMethodLabelOf(booking),
                        style: getTextStyle(
                          color: const Color(0xFF18181A),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  _buildInfoBlock('Booking Summary', ''),
                  SizedBox(height: 20.h),
                  _buildServiceTable(booking),
                  SizedBox(height: 20.h),
                  const Divider(),
                  SizedBox(height: 12.h),
                  _buildSubtotalRow(
                    'Service amount (Vat Excluded)',
                    '${booking.serviceAmount.toStringAsFixed(2)} ৳',
                  ),
                  SizedBox(height: 24.h),
                  _buildTotalRow(
                    'Grand Total',
                    '${booking.serviceAmount.toStringAsFixed(2)} ৳',
                  ),
                ],
              ),
            ),
            SizedBox(height: 70.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F4F8),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: const Color(0xFFCBD5E1)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Service location',
                      style: getTextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF18181A),
                      ),
                    ),
                  ),
                  SizedBox(height: 36.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFBB38),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      'You need to go to the Customer Location to provide the service',
                      style: getTextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF18181A),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Service Location:',
                    style: getTextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFF18181A),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    booking.locationDetails.isEmpty
                        ? 'No location details'
                        : booking.locationDetails,
                    style: getTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            if (booking.message.isNotEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: const Color(0xFFCBD5E1)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Customer Message',
                      style: getTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      booking.message,
                      style: getTextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF334155),
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(height: 30.h),
            if (status == 'Pending')
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'Accept',
                      onPressed: () {
                        final index = controller.bookings.indexWhere(
                          (b) => b.id == booking.id,
                        );
                        if (index != -1) {
                          controller.handleAccept(index);
                          Get.back();
                        }
                      },
                      backgroundColor: const Color(0xFF22C55E),
                      textColor: Colors.white,
                      borderRadius: 6.r,
                      height: 48.h,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: CustomButton(
                      text: 'Reject',
                      onPressed: () {
                        final index = controller.bookings.indexWhere(
                          (b) => b.id == booking.id,
                        );
                        if (index != -1) {
                          controller.handleReject(index);
                          Get.back();
                        }
                      },
                      backgroundColor: const Color(0xFFEF4444),
                      textColor: Colors.white,
                      borderRadius: 6.r,
                      height: 48.h,
                    ),
                  ),
                ],
              ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoBlock(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: getTextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF18181A),
          ),
        ),
        if (value.isNotEmpty) SizedBox(height: 6.h),
        if (value.isNotEmpty)
          Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: getTextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        if (value.isNotEmpty) SizedBox(height: 6.h),
      ],
    );
  }

  Widget _buildServiceTable(RecentBookingModel booking) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F9FA),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.r),
              topRight: Radius.circular(8.r),
            ),
          ),
          child: Row(
            children: [
              Expanded(flex: 5, child: _buildTableHeader('Service')),
              Expanded(flex: 3, child: _buildTableHeader('Amount')),
              Expanded(flex: 2, child: _buildTableHeader('Total')),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(12.w),
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Text(
                  booking.serviceName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: getTextStyle(fontSize: 12.sp, color: Colors.black87),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  '৳ ${booking.serviceAmount.toStringAsFixed(2)}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: getTextStyle(fontSize: 12.sp, color: Colors.black87),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  '৳ ${booking.serviceAmount.toStringAsFixed(2)}',
                  textAlign: TextAlign.end,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: getTextStyle(fontSize: 12.sp, color: Colors.black87),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTableHeader(String text) {
    return Text(
      text,
      style: getTextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF334155),
      ),
    );
  }

  Widget _buildSubtotalRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            label,
            style: getTextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF334155),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Text(
          value,
          textAlign: TextAlign.end,
          style: getTextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildTotalRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            label,
            style: getTextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Text(
          value,
          textAlign: TextAlign.end,
          style: getTextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ],
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
