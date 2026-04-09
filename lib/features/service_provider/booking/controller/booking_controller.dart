import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/services/api_client.dart';
import 'package:protiva502/core/services/secure_storage_service.dart';
import 'package:protiva502/core/utils/constants/apiendpoint.dart';
import 'package:protiva502/features/chat/screen/single_chat_screen.dart';
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
        queryParameters: {'page': 1, 'limit': 10},
        options: Options(
          headers: {'accept': '*/*', 'Authorization': 'Bearer $token'},
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      debugPrint(
        'Provider booking request => ${ApiEndpoints.baseUrl}${ApiEndpoints.recentBookings}?page=1&limit=10',
      );
      debugPrint('Provider booking status => ${response.statusCode}');
      debugPrint('Provider booking response => ${response.data}');

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

      bookings.assignAll(
        items.whereType<Map>().map(
          (item) => RecentBookingModel.fromJson(
            item.map((key, value) => MapEntry(key.toString(), value)),
          ),
        ),
      );

      debugPrint('Provider booking length => ${bookings.length}');
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

  void handleAccept(int index) {
    final booking = filteredBookings[index];
    final originalIndex = bookings.indexWhere((b) => b.id == booking.id);

    if (originalIndex != -1) {
      bookings[originalIndex] = bookings[originalIndex].copyWith(
        status: 'ACCEPTED',
      );
      bookings.refresh();
      Get.snackbar(
        'Accepted',
        'Booking for ${bookings[originalIndex].serviceName} has been accepted.',
      );
    }
  }

  void handleReject(int index) {
    final booking = filteredBookings[index];
    final originalIndex = bookings.indexWhere((b) => b.id == booking.id);

    if (originalIndex != -1) {
      bookings[originalIndex] = bookings[originalIndex].copyWith(
        status: 'REJECTED',
      );
      bookings.refresh();
      Get.snackbar(
        'Rejected',
        'Booking for ${bookings[originalIndex].serviceName} has been rejected.',
      );
    }
  }

  void handleMessage(int index) {
    Get.to(() => SingleChatScreen());
  }

  void handleViewDetails(int index) {
    Get.toNamed('/providerBookingDetails', arguments: filteredBookings[index]);
  }
}
