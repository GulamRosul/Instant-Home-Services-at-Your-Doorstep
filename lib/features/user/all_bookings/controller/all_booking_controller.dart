import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/services/api_client.dart';
import 'package:protiva502/core/services/secure_storage_service.dart';
import 'package:protiva502/core/utils/constants/apiendpoint.dart';
import 'package:protiva502/core/utils/logging/logger.dart';
import 'package:protiva502/features/user/all_bookings/model/all_booking_model.dart';

class AllBookingController extends GetxController {
  final ApiClient _apiClient = ApiClient();

  final selectedStatus = 'All status'.obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final bookings = <UserBookingItem>[].obs;
  final stats = const BookingSummaryStats.empty().obs;

  final List<String> statusOptions = const [
    'All status',
    'Pending',
    'Accepted',
    'Rejected',
    'In-Progress',
    'Completed',
    'Cancelled',
  ];

  List<UserBookingItem> get filteredBookings {
    final selected = selectedStatus.value;

    if (selected == 'All status') {
      return bookings;
    }

    return bookings
        .where((booking) => booking.displayStatus == selected)
        .toList();
  }

  @override
  void onInit() {
    super.onInit();
    fetchBookings();
  }

  Future<void> fetchBookings({bool isRefresh = false}) async {
    if (isLoading.value) {
      return;
    }

    try {
      isLoading.value = true;
      errorMessage.value = '';

      final token = await SecureStorageService.getToken();

      if (token == null || token.trim().isEmpty) {
        bookings.clear();
        stats.value = const BookingSummaryStats.empty();
        errorMessage.value = 'Please sign in to view your bookings.';
        return;
      }

      final response = await _apiClient.get<dynamic>(
        ApiEndpoints.myAllBookings,
        options: Options(
          headers: {'accept': '*/*', 'Authorization': 'Bearer $token'},
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      final responseMap = _asMap(response.data) ?? <String, dynamic>{};
      final data = _asMap(responseMap['data']);

      if (response.statusCode != 200 || data == null) {
        if (!isRefresh) {
          bookings.clear();
          stats.value = const BookingSummaryStats.empty();
        }

        errorMessage.value =
            _extractMessage(response.data) ?? 'Failed to load bookings.';
        AppLoggerHelper.warning(
          'All bookings request failed: ${response.statusCode} ${response.data}',
        );
        return;
      }

      final items = data['data'];
      final fetchedBookings = items is List
          ? items
                .whereType<Map>()
                .map(
                  (item) => UserBookingItem.fromJson(
                    item.map((key, value) => MapEntry(key.toString(), value)),
                  ),
                )
                .toList()
          : <UserBookingItem>[];

      bookings.assignAll(fetchedBookings);
      stats.value = BookingSummaryStats.fromJson(_asMap(data['stats']));
    } on DioException catch (error) {
      if (!isRefresh) {
        bookings.clear();
        stats.value = const BookingSummaryStats.empty();
      }

      errorMessage.value =
          _extractMessage(error.response?.data) ??
          error.message ??
          'Failed to load bookings.';
      AppLoggerHelper.error('All bookings fetch failed', error);
    } catch (error) {
      if (!isRefresh) {
        bookings.clear();
        stats.value = const BookingSummaryStats.empty();
      }

      errorMessage.value = 'Failed to load bookings.';
      AppLoggerHelper.error('Unexpected all bookings fetch error', error);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshBookings() {
    return fetchBookings(isRefresh: true);
  }

  void updateStatus(String? newStatus) {
    if (newStatus != null && newStatus != selectedStatus.value) {
      selectedStatus.value = newStatus;
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

  String? _extractMessage(dynamic responseData) {
    final responseMap = _asMap(responseData);
    if (responseMap == null) {
      return null;
    }

    final data = _asMap(responseMap['data']);
    final message = data?['message'] ?? responseMap['message'];

    if (message is String && message.trim().isNotEmpty) {
      return message;
    }

    return null;
  }
}
