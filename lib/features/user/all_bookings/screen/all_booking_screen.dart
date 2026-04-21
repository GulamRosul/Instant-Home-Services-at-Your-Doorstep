import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_appbar.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/core/utils/constants/image_path.dart';
import 'package:protiva502/features/user/all_bookings/controller/all_booking_controller.dart';
import 'package:protiva502/features/user/all_bookings/model/all_booking_model.dart';
import 'package:protiva502/features/user/all_bookings/widget/review_widget.dart';
import 'package:protiva502/features/tracking/screen/tracking_screen.dart';
import 'package:protiva502/features/user/user_booking_confirmation/screen/booking_details_screen.dart';
import 'package:protiva502/features/user/user_booking_confirmation/screen/payment_screen.dart';

class AllBookingScreen extends StatelessWidget {
  const AllBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllBookingController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: const CustomAppBar(title: '  Bookings'),
      body: Obx(() {
        final hasNoData = controller.bookings.isEmpty;
        final isInitialLoading = controller.isLoading.value && hasNoData;
        final hasBlockingError =
            controller.errorMessage.value.isNotEmpty && hasNoData;

        if (isInitialLoading) {
          return _buildLoadingState();
        }

        if (hasBlockingError) {
          return _buildErrorState(controller);
        }

        return RefreshIndicator(
          onRefresh: controller.refreshBookings,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                Text(
                  'Booking service',
                  style: getTextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  'Book Your Service in Just a Few Clicks',
                  style: getTextStyle(
                    fontSize: 12.sp,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 20.h),
                _buildSummaryGrid(controller.stats.value),
                SizedBox(height: 30.h),
                _buildFilterHeader(controller),
                SizedBox(height: 12.h),
                if (controller.isLoading.value)
                  Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: LinearProgressIndicator(
                      minHeight: 3.h,
                      color: AppColors.textPurple,
                      backgroundColor: AppColors.textPurple.withValues(
                        alpha: 0.12,
                      ),
                    ),
                  ),
                if (controller.errorMessage.value.isNotEmpty)
                  _buildInlineMessage(
                    message: controller.errorMessage.value,
                    actionLabel: 'Retry',
                    onTap: controller.refreshBookings,
                    isError: true,
                  ),
                Obx(() {
                  final bookings = controller.filteredBookings;

                  if (bookings.isEmpty) {
                    return _buildEmptyState(controller.selectedStatus.value);
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: bookings.length,
                    itemBuilder: (context, index) {
                      return _buildBookingCard(context, bookings[index]);
                    },
                  );
                }),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildSummaryGrid(BookingSummaryStats stats) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 8.w,
      mainAxisSpacing: 8.h,
      childAspectRatio: 2.05,
      padding: EdgeInsets.zero,
      children: [
        _buildSummaryCard(
          stats.totalBooking.toString().padLeft(2, '0'),
          'Total Bookings',
          Icons.assignment_outlined,
          const Color(0xFFF59E0B),
        ),
        _buildSummaryCard(
          stats.totalAccepted.toString().padLeft(2, '0'),
          'Bookings Accepted',
          Icons.check_circle_outline,
          const Color(0xFF22C55E),
        ),
        _buildSummaryCard(
          stats.totalInProgress.toString().padLeft(2, '0'),
          'Service In-Progress',
          Icons.build_circle_outlined,
          const Color(0xFFEAB308),
        ),
        _buildSummaryCard(
          stats.totalComplete.toString().padLeft(2, '0'),
          'Completed Service',
          Icons.assignment_turned_in_outlined,
          AppColors.textBlue,
        ),
      ],
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
          color: AppColors.defaultBorder.withValues(alpha: 0.25),
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  count,
                  style: getTextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    lineHeight: 18,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  label,
                  style: getTextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w400,
                    lineHeight: 14,
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
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Booking Services',
                style: getTextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4.h),
              Obx(
                () => Text(
                  '${controller.filteredBookings.length} booking${controller.filteredBookings.length == 1 ? '' : 's'}',
                  style: getTextStyle(
                    fontSize: 12.sp,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: AppColors.textPurple),
          ),
          child: Obx(
            () => DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                dropdownColor: Colors.white,
                value: controller.selectedStatus.value,
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.textPurple,
                  size: 20.sp,
                ),
                items: controller.statusOptions.map((value) {
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
        ),
      ],
    );
  }

  Widget _buildBookingCard(BuildContext context, UserBookingItem booking) {
    final statusColor = _getStatusColor(booking.status);

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Image.asset(
                  ImagePath.servicecard,
                  width: 62.w,
                  height: 58.h,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            booking.serviceName,
                            style: getTextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        _buildStatusChip(
                          label: booking.displayStatus,
                          color: statusColor,
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      booking.locationText,
                      style: getTextStyle(
                        fontSize: 11.sp,
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'Starting : ${_formatCurrency(booking.totalAmount)}',
                      style: getTextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              _buildInfoPill(
                icon: Icons.calendar_today_outlined,
                text: _formatDate(booking.preferredDate),
              ),
              _buildInfoPill(
                icon: Icons.access_time_outlined,
                text: booking.preferredTime ?? 'Time not set',
              ),
              _buildInfoPill(
                icon: Icons.payments_outlined,
                text: booking.displayPaymentStatus,
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Text(
            'Booking ID: ${_shortReference(booking.reference)}',
            style: getTextStyle(
              fontSize: 11.sp,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (booking.message != null && booking.message!.isNotEmpty) ...[
            SizedBox(height: 8.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(
                booking.message!,
                style: getTextStyle(
                  fontSize: 11.sp,
                  color: const Color(0xFF475569),
                ),
              ),
            ),
          ],
          if (booking.isCompleted) ...[
            Divider(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActionText('View Details', () {
                  _showBookingStateMessage(booking);
                }),
                _buildActionText('Book Again', () {
                  Get.to(() => const BookingDetailsScreen());
                }),
                _buildActionText('Write Review', () {
                  showDialog(
                    context: context,
                    builder: (context) => const ReviewWidget(),
                  );
                }),
              ],
            ),
          ] else ...[
            Divider(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (normalizeBookingStatus(booking.status) == 'ACCEPTED') ...[
                  // SizedBox(width: 16.w),
                  GestureDetector(
                    onTap: () => _handlePayment(booking),
                    child: Text(
                      'Make Payment',
                      style: getTextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xFF7079F0),
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => _handleBookingAction(booking),
                    child: Text(
                      booking.canTrack ? 'Track Provider' : 'View Details',
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
          ],
        ],
      ),
    );
  }

  Widget _buildStatusChip({required String label, required Color color}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999.r),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Text(
        label,
        style: getTextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  Widget _buildInfoPill({required IconData icon, required String text}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(999.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.sp, color: const Color(0xFF64748B)),
          SizedBox(width: 6.w),
          Text(
            text,
            style: getTextStyle(
              fontSize: 11.sp,
              color: const Color(0xFF475569),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInlineMessage({
    required String message,
    required String actionLabel,
    required VoidCallback onTap,
    bool isError = false,
  }) {
    final color = isError ? const Color(0xFFDC2626) : const Color(0xFF0F766E);

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: color.withValues(alpha: 0.18)),
      ),
      child: Row(
        children: [
          Icon(
            isError ? Icons.info_outline : Icons.check_circle_outline,
            color: color,
            size: 18.sp,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              message,
              style: getTextStyle(fontSize: 12.sp, color: color),
            ),
          ),
          TextButton(
            onPressed: onTap,
            child: Text(
              actionLabel,
              style: getTextStyle(
                fontSize: 12.sp,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 28.w,
            height: 28.w,
            child: CircularProgressIndicator(
              strokeWidth: 2.6,
              color: AppColors.textPurple,
            ),
          ),
          SizedBox(height: 14.h),
          Text(
            'Loading your bookings...',
            style: getTextStyle(
              fontSize: 13.sp,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(AllBookingController controller) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 28.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 46.sp,
              color: AppColors.textSecondary,
            ),
            SizedBox(height: 14.h),
            Text(
              'Could not load bookings',
              textAlign: TextAlign.center,
              style: getTextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 8.h),
            Text(
              controller.errorMessage.value,
              textAlign: TextAlign.center,
              style: getTextStyle(
                fontSize: 12.sp,
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: 16.h),
            OutlinedButton(
              onPressed: controller.refreshBookings,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.textPurple),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              ),
              child: Text(
                'Try again',
                style: getTextStyle(
                  fontSize: 13.sp,
                  color: AppColors.textPurple,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(String selectedStatus) {
    final isFiltered = selectedStatus != 'All status';

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 28.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Icon(
            Icons.bookmark_border_rounded,
            size: 42.sp,
            color: AppColors.textSecondary,
          ),
          SizedBox(height: 12.h),
          Text(
            isFiltered ? 'No $selectedStatus bookings yet' : 'No bookings yet',
            textAlign: TextAlign.center,
            style: getTextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 6.h),
          Text(
            isFiltered
                ? 'Try a different status filter to see your other bookings.'
                : 'Your bookings will appear here once you place a service order.',
            textAlign: TextAlign.center,
            style: getTextStyle(
              fontSize: 12.sp,
              color: AppColors.textSecondary,
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

  void _handleBookingAction(UserBookingItem booking) {
    final trackingBookingId = _resolveTrackingBookingId(booking);

    if (trackingBookingId.isEmpty) {
      Get.snackbar('Booking update', 'Booking ID is unavailable for tracking.');
      return;
    }

    if (booking.canTrack) {
      Get.to(
        () => const TrackProviderScreen(),
        arguments: {
          'providerName':
              'Service Provider', // You may need to fetch actual provider name from API
          'serviceName': booking.serviceName,
          'location': booking.locationText,
          'rating':
              '4.8 (170 Reviews)', // You may need to fetch actual rating from API
          'cost': '\$${booking.totalAmount.toStringAsFixed(2)}',
          'bookingId': trackingBookingId,
          'providerId': booking.providerId,
          'clientId': booking.clientId,
          'userId': booking.clientId,
          'userRole': 'user',
          'userLocationLatitude': booking.locationLatitude,
          'userLocationLongitude': booking.locationLongitude,
          'userLocationDetails': booking.locationText,
        },
      );
      return;
    }

    _showBookingStateMessage(booking);
  }

  void _handlePayment(UserBookingItem booking) {
    Get.to(
      () => const PaymentScreen(),
      arguments: {
        'bookingId': booking.reference,
        'amount': booking.totalAmount.toInt(),
      },
    );
  }

  void _showBookingStateMessage(UserBookingItem booking) {
    final normalized = normalizeBookingStatus(booking.status);

    String message;
    if (normalized == 'PENDING') {
      message =
          'Tracking will be available after the provider accepts this booking.';
    } else if (normalized == 'REJECTED') {
      message = 'This booking was rejected by the provider.';
    } else if (normalized == 'CANCELLED') {
      message = 'This booking has been cancelled.';
    } else {
      message = 'Booking status: ${booking.displayStatus}.';
    }

    Get.snackbar('Booking update', message);
  }

  Color _getStatusColor(String? status) {
    switch (normalizeBookingStatus(status)) {
      case 'PENDING':
        return const Color(0xFFF59E0B);
      case 'ACCEPTED':
        return const Color(0xFF16A34A);
      case 'REJECTED':
        return const Color(0xFFDC2626);
      case 'IN_PROGRESS':
        return const Color(0xFF7C3AED);
      case 'COMPLETE':
      case 'COMPLETED':
        return AppColors.textBlue;
      case 'CANCELLED':
        return const Color(0xFF64748B);
      default:
        return Colors.grey;
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) {
      return 'Date not set';
    }

    return DateFormat('dd MMM yyyy').format(date.toLocal());
  }

  String _formatCurrency(double amount) {
    if (amount == amount.truncateToDouble()) {
      return '${amount.toStringAsFixed(0)}';
    }

    return '${amount.toStringAsFixed(2)}';
  }

  String _shortReference(String reference) {
    if (reference.length <= 12) {
      return reference;
    }

    return '${reference.substring(0, 12)}...';
  }

  String _resolveTrackingBookingId(UserBookingItem booking) {
    if (booking.id.trim().isNotEmpty) {
      return booking.id.trim();
    }

    final bookingNumber = booking.bookingNumber?.trim() ?? '';
    if (bookingNumber.isNotEmpty) {
      return bookingNumber;
    }

    return '';
  }
}
