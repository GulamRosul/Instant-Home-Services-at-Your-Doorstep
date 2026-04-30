import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:protiva502/core/services/api_client.dart';
import 'package:protiva502/core/services/secure_storage_service.dart';
import 'package:protiva502/core/utils/constants/apiendpoint.dart';
import 'package:protiva502/core/utils/logging/logger.dart';
import 'package:protiva502/features/bottom_nav/bottom_nav_bar.dart';
import 'package:protiva502/features/bottom_nav/controller/bottom_nav_controller.dart';
import 'package:protiva502/features/bottom_nav/screen/main_navigation_screen.dart';
import 'package:protiva502/features/user/all_bookings/controller/all_booking_controller.dart';
import 'package:protiva502/features/user/all_bookings/screen/all_booking_screen.dart';
import 'package:protiva502/features/user/user_booking_confirmation/model/booking_confirmation_data.dart';
import 'package:protiva502/features/user/user_booking_confirmation/screen/payment_screen.dart';
import 'package:protiva502/features/user/user_booking_confirmation/widget/confirm_dialogue.dart';

class ConfirmBookingController extends GetxController {
  ConfirmBookingController({ApiClient? apiClient})
    : _apiClient = apiClient ?? ApiClient();

  final ApiClient _apiClient;
  final isSubmitting = false.obs;

  Future<void> confirmBooking(BookingConfirmationData bookingData) async {
    if (isSubmitting.value) {
      return;
    }

    final service = bookingData.service;
    if (service == null) {
      Get.snackbar(
        'Booking Failed',
        'Service information is missing. Please start again.',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(12),
      );
      return;
    }

    if (service.userId.trim().isEmpty || service.id.trim().isEmpty) {
      Get.snackbar(
        'Booking Failed',
        'Provider or job information is missing for this service.',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(12),
      );
      return;
    }

    final token = await SecureStorageService.getToken();
    if (token == null || token.trim().isEmpty) {
      Get.snackbar(
        'Login Required',
        'Please sign in again to confirm your booking.',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(12),
      );
      return;
    }

    final payload = {
      'providerId': service.userId,
      'jobId': service.id,
      'serviceName': service.title,
      'preferredDate': bookingData.preferredDateTime.toUtc().toIso8601String(),
      'preferredTime': DateFormat('h a').format(bookingData.preferredDateTime),
      'serviceLocation': _mapServiceLocation(bookingData.locationType),
      'locationLatitude': bookingData.locationLatitude,
      'locationLongitude': bookingData.locationLongitude,
      'locationDetails': bookingData.locationDetails,
      'contactPhone': bookingData.phoneNumber,
      'serviceAmount': service.basePrice,
      'message': bookingData.message,
    };

    try {
      isSubmitting.value = true;
      AppLoggerHelper.info('Make booking request payload: $payload');

      final response = await _apiClient.post<dynamic>(
        ApiEndpoints.makeBooking,
        data: payload,
        options: Options(
          headers: {'Authorization': 'Bearer $token', 'accept': '*/*'},
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      AppLoggerHelper.info(
        'Make booking response => ${response.statusCode} ${response.data}',
      );

      final message = _extractMessage(response.data);
      final isSuccess = _extractSuccess(response.data);

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          isSuccess) {
        final createdBookingId = _extractBookingId(response.data);
        final payableAmount = _extractAmount(response.data, bookingData);

        Get.dialog(
          BookingSuccessDialog(
            message:
                message ??
                'Thank You! We’ve sent your booking details to Provider',
          ),
          barrierDismissible: false,
        );
        await Future<void>.delayed(const Duration(seconds: 3));
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        // Get.to(
        //   () => const PaymentScreen(),
        //   arguments: {
        //     'bookingId': createdBookingId ?? '',
        //     'amount': payableAmount,
        //   },
        // );
        // Get.to(() =>  const AllBookingScreen(    ));
        if (Get.isRegistered<AllBookingController>()) {
          Get.find<AllBookingController>().refreshBookings();
        }

        // Get.to(() => const AllBookingScreen());
        Get.offAll(() => const BottomNavBar());
        // Switch to bookings tab (index 1) after navigation
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final navController = Get.find<BottomNavController>();
          navController.changeTab(1);
        });

        return;
      }

      Get.snackbar(
        'Booking Failed',
        message ?? 'Unable to confirm your booking right now.',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(12),
      );
    } on DioException catch (error) {
      final message =
          _extractMessage(error.response?.data) ??
          error.message ??
          'Unable to confirm your booking right now.';
      AppLoggerHelper.error('Make booking request failed', error);
      Get.snackbar(
        'Booking Failed',
        message,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(12),
      );
    } catch (error) {
      AppLoggerHelper.error('Unexpected make booking error', error);
      Get.snackbar(
        'Booking Failed',
        'Something went wrong while confirming your booking.',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(12),
      );
    } finally {
      isSubmitting.value = false;
    }
  }

  void goToHome() {
    // Navigates back to the Main Navigation Screen (where the bottom nav bar is)
    // and clears the booking stack.
    // Get.offAllNamed('/main-nav');
    Get.offAll(() => const MainNavigationScreen());
  }

  void viewBookings() {
    // Logic to navigate to the specific Booking tab
    // Get.offAllNamed('/main-nav', arguments: {'index': 1});

    Get.offAll(() => const MainNavigationScreen());
    // Switch to bookings tab (index 1) after navigation
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final navController = Get.find<BottomNavController>();
      navController.changeTab(1);
    });
  }

  String _mapServiceLocation(String locationType) {
    return locationType == 'Provider Location'
        ? 'PROVIDER_LOCATION'
        : 'CUSTOMER_LOCATION';
  }

  bool _extractSuccess(dynamic responseData) {
    final responseMap = _asMap(responseData);
    final data = _asMap(responseMap?['data']);
    return data?['success'] == true;
  }

  String? _extractMessage(dynamic responseData) {
    final responseMap = _asMap(responseData);
    final data = _asMap(responseMap?['data']);
    final message = data?['message'] ?? responseMap?['message'];

    if (message is String && message.trim().isNotEmpty) {
      return message.trim();
    }

    return null;
  }

  String? _extractBookingId(dynamic responseData) {
    final responseMap = _asMap(responseData);
    final data = _asMap(responseMap?['data']);
    final booking = _asMap(data?['data']);

    final rawId =
        booking?['id'] ??
        data?['bookingId'] ??
        data?['id'] ??
        responseMap?['bookingId'];

    if (rawId is String && rawId.trim().isNotEmpty) {
      return rawId.trim();
    }

    return null;
  }

  int _extractAmount(
    dynamic responseData,
    BookingConfirmationData bookingData,
  ) {
    final responseMap = _asMap(responseData);
    final data = _asMap(responseMap?['data']);
    final booking = _asMap(data?['data']);

    final rawAmount =
        booking?['serviceAmount'] ??
        booking?['amount'] ??
        data?['id'] ??
        data?['serviceAmount'] ??
        data?['amount'] ??
        bookingData.service?.basePrice;

    return _toInt(rawAmount);
  }

  int _toInt(dynamic value) {
    if (value is int) {
      return value;
    }

    if (value is num) {
      return value.round();
    }

    if (value is String) {
      final parsed = num.tryParse(value.trim());
      if (parsed != null) {
        return parsed.round();
      }
    }

    return 0;
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
}
