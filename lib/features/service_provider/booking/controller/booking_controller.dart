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
    final inProgressCount = bookings
        .where((b) => statusLabelOf(b) == 'In-Progress')
        .length;

    return [
      'Pending (${pendingCount.toString().padLeft(2, '0')})',
      'Accepted (${acceptedCount.toString().padLeft(2, '0')})',
      'Rejected (${rejectedCount.toString().padLeft(2, '0')})',
      'In-Progress (${inProgressCount.toString().padLeft(2, '0')})',
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
        status = 'In-Progress';
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
    final inProgressCount = bookings
        .where((b) => statusLabelOf(b) == 'In-Progress')
        .length;
    final totalRevenue = bookings
        .where(
          (b) =>
              statusLabelOf(b) == 'Accepted' ||
              statusLabelOf(b) == 'In-Progress',
        )
        .fold<double>(0.0, (sum, b) => sum + b.serviceAmount);

    return [
      {
        'value': pendingCount.toString().padLeft(2, '0'),
        'label': 'Request Pending',
        'icon': 'flag',
      },
      {
        'value': acceptedCount.toString().padLeft(2, '0'),
        'label': 'Confirm Bookings',
        'icon': 'confirmed',
      },
      {
        'value': inProgressCount.toString().padLeft(2, '0'),
        'label': 'Completed Service',
        'icon': 'star',
      },
      {
        'value': '${totalRevenue.toStringAsFixed(2)} ৳',
        'label': 'Total Revenue',
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
      debugPrint('Provider booking response => ${encoder.convert(response.data)}');

      if (response.statusCode != 200) {
        errorMessage.value = 'Failed to load bookings';
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

      bookings.assignAll(
        items.whereType<Map>().map(
          (item) => RecentBookingModel.fromJson(
            item.map((key, value) => MapEntry(key.toString(), value)),
          ),
        ),
      );

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
      errorMessage.value = 'Failed to load bookings';
      bookings.clear();
    } catch (_) {
      errorMessage.value = 'Failed to load bookings';
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
      case 'IN-PROGRESS':
        return 'In-Progress';
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
    await _updateBookingStatus(booking, 'ACCEPTED', index);
  }

  Future<void> handleReject(int index) async {
    final booking = filteredBookings[index];
    await _updateBookingStatus(booking, 'REJECTED', index);
  }

  Future<void> _updateBookingStatus(
    RecentBookingModel booking,
    String status,
    int index,
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
        errorMessage.value = 'Failed to update booking status';
        Get.snackbar('Error', 'Failed to update booking status');
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
                color: Colors.black.withOpacity(0.15),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
            isDismissible: true,
            forwardAnimationCurve: Curves.easeOutBack,
          );
        }
      } else {
        errorMessage.value =
            bookingResponse.message ?? 'Failed to update booking status';
        Get.snackbar(
          'Error',
          bookingResponse.message ?? 'Failed to update booking status',
        );
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
      Get.snackbar(
        'Error',
        'Client information is not available for this booking',
      );
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
