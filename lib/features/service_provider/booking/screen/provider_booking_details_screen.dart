import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/features/service_provider/booking/controller/booking_controller.dart';

import 'package:protiva502/core/common/widgets/custom_button.dart';

class ProviderBookingDetailsScreen extends StatelessWidget {
  const ProviderBookingDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> booking = Get.arguments;
    final controller = Get.find<BookingController>();
    final String status = booking['status'] ?? 'Pending';

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
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Booking Details',
                      style: getTextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Booking # ${booking['bookingId']}',
                      style: getTextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
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
            SizedBox(height: 20.h),

            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildInfoBlock(
                        'Payment Method',
                        'Amount : ${booking['budget']}\$',
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: _buildInfoBlock(
                          'Schedule Date :',
                          booking['date'],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildInfoBlock('Booking Summary', ''),
                      Align(
                        alignment: Alignment.centerRight,
                        child: _buildInfoBlock(
                          'Pay Via : ',
                          booking['paymentMethod'],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  _buildServiceTable(booking),
                  SizedBox(height: 20.h),
                  const Divider(),
                  SizedBox(height: 12.h),
                  _buildSubtotalRow(
                    'Service amount (Vat Excluded)',
                    '315.00\$',
                  ),
                  SizedBox(height: 24.h),
                  _buildTotalRow('Grand Total', '482.50\$'),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F4F8),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Service location',
                      style: getTextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFDBA74).withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      'You need to go to the Customer Location to provide the service',
                      style: getTextStyle(
                        fontSize: 12.sp,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Service Location:',
                    style: getTextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    booking['location'],
                    style: getTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: status == 'Pending'
          ? Container(
              padding: EdgeInsets.all(16.w),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'Accept',
                      onPressed: () {
                        final index = controller.bookings.indexWhere(
                          (b) => b['bookingId'] == booking['bookingId'],
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
                          (b) => b['bookingId'] == booking['bookingId'],
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
            )
          : null,
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
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        if (value.isNotEmpty) SizedBox(height: 8.h),
        if (value.isNotEmpty)
          SizedBox(
            width: 150.w,
            child: Text(
              value,
              style: getTextStyle(fontSize: 13.sp, color: Colors.grey.shade600),
            ),
          ),
      ],
    );
  }

  Widget _buildServiceTable(Map<String, dynamic> booking) {
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
              Expanded(child: _buildTableHeader('Service')),
              SizedBox(width: 60.w, child: _buildTableHeader('Amount')),
              SizedBox(width: 60.w, child: _buildTableHeader('Total')),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(12.w),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  booking['title'],
                  style: getTextStyle(fontSize: 13.sp, color: Colors.black87),
                ),
              ),
              SizedBox(
                width: 60.w,
                child: Text(
                  '350.00\$',
                  style: getTextStyle(fontSize: 13.sp, color: Colors.black87),
                ),
              ),
              SizedBox(
                width: 60.w,
                child: Text(
                  '315.00\$',
                  style: getTextStyle(fontSize: 13.sp, color: Colors.black87),
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
        fontWeight: FontWeight.w500,
        color: Colors.grey.shade600,
      ),
    );
  }

  Widget _buildSubtotalRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: getTextStyle(fontSize: 13.sp, color: Colors.grey.shade700),
        ),
        Text(
          value,
          style: getTextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildTotalRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: getTextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        Text(
          value,
          style: getTextStyle(
            fontSize: 16.sp,
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
}
