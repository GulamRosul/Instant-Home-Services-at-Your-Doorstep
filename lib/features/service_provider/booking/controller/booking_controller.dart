import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/services/api_client.dart';
import 'package:protiva502/core/services/secure_storage_service.dart';
import 'package:protiva502/core/utils/constants/apiendpoint.dart';
import 'package:protiva502/features/chat/screen/single_chat_screen.dart';
import 'package:protiva502/features/service_provider/booking/model/booking_status_response_model.dart';
import 'package:protiva502/features/service_provider/home/model/recent_booking_model.dart';

class BookingController extends GetxController {
  final ApiClient _apiClient = ApiClient();

  final selectedTabIndex = 0.obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final bookings = <RecentBookingModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchBookings();
  }

  List<String> get dynamicTabs {
    final pendingCount = bookings
        .where((b) => statusLabelOf(b) == 'Pending')
        .length;
    final acceptedCount = bookings
        .where((b) => statusLabelOf(b) == 'Accepted')
        .length;
    final rejectedCount = bookings
        .where((b) => statusLabelOf(b) == 'Rejected')
        .length;
    final completedCount = bookings
        .where((b) => statusLabelOf(b) == 'Completed')
        .length;

    return [
      '${'pending'.tr} (${pendingCount.toString().padLeft(2, '0')})',
      '${'accepted'.tr} (${acceptedCount.toString().padLeft(2, '0')})',
      '${'rejected'.tr} (${rejectedCount.toString().padLeft(2, '0')})',
      '${'completed'.tr} (${completedCount.toString().padLeft(2, '0')})',
    ];
  }

  List<RecentBookingModel> get filteredBookings {
    String status = '';
    switch (selectedTabIndex.value) {
      case 0:
        status = 'Pending';
        break;
      case 1:
        status = 'Accepted';
        break;
      case 2:
        status = 'Rejected';
        break;
      case 3:
        status = 'Completed';
        break;
    }

    return bookings.where((b) => statusLabelOf(b) == status).toList();
  }

  List<Map<String, String>> get dynamicStats {
    final pendingCount = bookings
        .where((b) => statusLabelOf(b) == 'Pending')
        .length;
    final acceptedCount = bookings
        .where((b) => statusLabelOf(b) == 'Accepted')
        .length;
    final completedCount = bookings
        .where((b) => statusLabelOf(b) == 'Completed')
        .length;
    final totalRevenue = bookings
        .where(
          (b) =>
              // statusLabelOf(b) == 'Accepted' ||
              statusLabelOf(b) == 'Completed',
        )
        .fold<double>(0.0, (sum, b) => sum + b.serviceAmount);

    return [
      {
        'value': pendingCount.toString().padLeft(2, '0'),
        'label': 'request_pending'.tr,
        'icon': 'flag',
      },
      {
        'value': acceptedCount.toString().padLeft(2, '0'),
        'label': 'confirm_bookings'.tr,
        'icon': 'confirmed',
      },
      {
        'value': completedCount.toString().padLeft(2, '0'),
        'label': 'completed_service'.tr,
        'icon': 'star',
      },
      {
        'value': '${totalRevenue.toStringAsFixed(2)} ৳',
        'label': 'total_revenue'.tr,
        'icon': 'revenue',
      },
    ];
  }

  Future<void> fetchBookings() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final token = await SecureStorageService.getToken();
      if (token == null || token.isEmpty) {
        errorMessage.value = 'Provider token not found';
        return;
      }

      final response = await _apiClient.get<dynamic>(
        ApiEndpoints.recentBookings,
        queryParameters: {'page': 1, 'limit': 100},
        options: Options(
          headers: {'accept': '*/*', 'Authorization': 'Bearer $token'},
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      debugPrint(
        'Provider booking request => ${ApiEndpoints.baseUrl}${ApiEndpoints.recentBookings}?page=1&limit=100',
      );
      debugPrint('Provider booking status => ${response.statusCode}');
      const JsonEncoder encoder = JsonEncoder.withIndent('  ');
      debugPrint(
        'Provider booking response => ${encoder.convert(response.data)}',
      );

      if (response.statusCode != 200) {
        errorMessage.value = 'failed_to_load_bookings'.tr;
        bookings.clear();
        return;
      }

      final responseMap = _asMap(response.data) ?? <String, dynamic>{};
      final data = _asMap(responseMap['data']) ?? <String, dynamic>{};
      final items = data['data'];

      if (items is! List) {
        bookings.clear();
        return;
      }

      debugPrint('Raw items list: $items');

      final latestBookings =
          items
              .whereType<Map>()
              .map(
                (item) => RecentBookingModel.fromJson(
                  item.map((key, value) => MapEntry(key.toString(), value)),
                ),
              )
              .toList()
            ..sort(_compareLatestFirst);

      bookings.assignAll(latestBookings);

      debugPrint('Provider booking length => ${bookings.length}');
      for (int i = 0; i < bookings.length; i++) {
        try {
          final booking = bookings[i];
          debugPrint('Booking $i Details:');
          debugPrint('  Service: ${booking.serviceName}');
          debugPrint('  Status: ${booking.status}');
          debugPrint('  Amount: ${booking.serviceAmount}');
          debugPrint('  Client ID: ${booking.clientId}');
          debugPrint('  Provider ID: ${booking.providerId}');
        } catch (e) {
          debugPrint('Error printing booking $i: $e');
        }
      }
    } on DioException catch (_) {
      errorMessage.value = 'failed_to_load_bookings'.tr;
      bookings.clear();
    } catch (_) {
      errorMessage.value = 'failed_to_load_bookings'.tr;
      bookings.clear();
    } finally {
      isLoading.value = false;
    }
  }

  Map<String, dynamic>? _asMap(dynamic value) {
    if (value is Map<String, dynamic>) {
      return value;
    }

    if (value is Map) {
      return value.map((key, item) => MapEntry(key.toString(), item));
    }

    return null;
  }

  String statusLabelOf(RecentBookingModel booking) {
    switch (booking.status.toUpperCase()) {
      case 'PENDING':
        return 'Pending';
      case 'ACCEPTED':
        return 'Accepted';
      case 'REJECTED':
        return 'Rejected';
      case 'IN_PROGRESS':
      case 'COMPLETED':
        return 'Completed';
      default:
        return booking.status.isEmpty ? 'Pending' : booking.status;
    }
  }

  String paymentMethodLabelOf(RecentBookingModel booking) {
    if (booking.paymentMethod.isEmpty) {
      return 'N/A';
    }

    final normalized = booking.paymentMethod.replaceAll('_', ' ').toLowerCase();
    return normalized
        .split(' ')
        .map((part) {
          if (part.isEmpty) {
            return part;
          }
          return '${part[0].toUpperCase()}${part.substring(1)}';
        })
        .join(' ');
  }

  void changeTab(int index) {
    selectedTabIndex.value = index;
  }

  Future<void> handleAccept(int index) async {
    final booking = filteredBookings[index];
    await handleAcceptBooking(booking);
  }

  Future<void> handleReject(int index) async {
    final booking = filteredBookings[index];
    await handleRejectBooking(booking);
  }

  Future<void> handleAcceptBooking(RecentBookingModel booking) async {
    await _updateBookingStatus(booking, 'ACCEPTED');
  }

  Future<void> handleRejectBooking(RecentBookingModel booking) async {
    await _updateBookingStatus(booking, 'REJECTED');
  }

  Future<void> _updateBookingStatus(
    RecentBookingModel booking,
    String status,
  ) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final token = await SecureStorageService.getToken();
      if (token == null || token.isEmpty) {
        errorMessage.value = 'Provider token not found';
        Get.snackbar('Error', 'Authentication failed. Please login again.');
        return;
      }

      final response = await _apiClient.patch<dynamic>(
        ApiEndpoints.updateBookingStatus(booking.id, status),
        options: Options(
          headers: {'accept': '*/*', 'Authorization': 'Bearer $token'},
          validateStatus: (statusCode) =>
              statusCode != null && statusCode < 500,
        ),
      );

      debugPrint(
        'Booking status update request => ${ApiEndpoints.baseUrl}${ApiEndpoints.updateBookingStatus(booking.id, status)}',
      );
      debugPrint('Booking status update response => ${response.statusCode}');
      debugPrint('Booking status update data => ${response.data}');

      if (response.statusCode != 200) {
        errorMessage.value = 'failed_to_update_booking_status'.tr;
        Get.snackbar('Error', 'failed_to_update_booking_status'.tr);
        return;
      }

      final responseMap = _asMap(response.data) ?? <String, dynamic>{};
      final innerDataMap = _asMap(responseMap['data']) ?? <String, dynamic>{};

      final bookingResponse = BookingStatusResponseModel.fromJson(innerDataMap);

      if (bookingResponse.success && bookingResponse.data != null) {
        final originalIndex = bookings.indexWhere((b) => b.id == booking.id);

        if (originalIndex != -1) {
          bookings[originalIndex] = bookings[originalIndex].copyWith(
            status: status,
          );
          bookings.sort(_compareLatestFirst);
          bookings.refresh();

          final statusLabel = status == 'ACCEPTED' ? 'accepted' : 'rejected';
          Get.snackbar(
            status == 'ACCEPTED' ? 'Accepted' : 'Rejected',
            'Booking for ${bookings[originalIndex].serviceName} has been $statusLabel.',
            snackPosition: SnackPosition.TOP,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            borderRadius: 12,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            backgroundColor: status == 'ACCEPTED'
                ? const Color(0xFF22C55E)
                : const Color(0xFFEF4444),
            colorText: Colors.white,
            icon: Icon(
              status == 'ACCEPTED' ? Icons.check_circle : Icons.error,
              color: Colors.white,
            ),
            duration: const Duration(seconds: 2),
            animationDuration: const Duration(milliseconds: 300),
            boxShadows: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
            isDismissible: true,
            forwardAnimationCurve: Curves.easeOutBack,
          );
          Future.delayed(const Duration(milliseconds: 300), () {
            Get.back();
          });
        }
      } else {
        final message = bookingResponse.message.isEmpty
            ? 'Failed to update booking status'
            : bookingResponse.message;
        errorMessage.value = message;
        Get.snackbar('Error', message);
      }
    } on DioException catch (e) {
      errorMessage.value = 'Network error while updating booking status';
      debugPrint('DioException: ${e.message}');
      Get.snackbar(
        'Error',
        'Network error. Please check your connection and try again.',
      );
    } catch (e) {
      errorMessage.value = 'Error while updating booking status';
      debugPrint('Exception: $e');
      Get.snackbar('Error', 'An unexpected error occurred');
    } finally {
      isLoading.value = false;
    }
  }

  int _compareLatestFirst(RecentBookingModel a, RecentBookingModel b) {
    final aDate = a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
    final bDate = b.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
    return bDate.compareTo(aDate);
  }

  void handleMessage(int index) {
    final booking = filteredBookings[index];

    // Debug logging
    debugPrint('=== MESSAGE HANDLER DEBUG ===');
    debugPrint('Booking Index: $index');
    debugPrint('Booking ID: ${booking.id}');
    debugPrint('Booking Client ID: ${booking.clientId}');
    debugPrint('Booking Provider ID: ${booking.providerId}');
    debugPrint('Current User ID: ${booking.providerId}');
    debugPrint('===========================');

    // Ensure we have valid IDs for messaging
    final clientId = booking.clientId?.isNotEmpty == true
        ? booking.clientId!
        : '';
    final providerId = booking.providerId?.isNotEmpty == true
        ? booking.providerId!
        : '';

    debugPrint('Extracted Client ID: $clientId');
    debugPrint('Extracted Provider ID: $providerId');

    if (clientId.isEmpty) {
      Get.snackbar('error'.tr, 'client_info_unavailable'.tr);
      return;
    }

    Get.to(
      () => SingleChatScreen(),
      arguments: {
        'bookingId': booking.id,
        'userId': providerId,
        'userRole': 'provider',
        'providerName': 'Service Provider',
        'clientId': clientId,
        'providerId': providerId,
      },
    );
  }

  void handleViewDetails(int index) {
    Get.toNamed('/providerBookingDetails', arguments: filteredBookings[index]);
  }
}
