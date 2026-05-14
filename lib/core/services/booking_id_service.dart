import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BookingIdService {
  /// Copy state (✔ icon toggle)
  final ValueNotifier<bool> isCopied = ValueNotifier(false);

  /// Show only last 8 characters for UI
  String getTrimmedBookingId(String fullId) {
    if (fullId.length <= 8) return fullId;

    return fullId.substring(fullId.length - 8);
  }

  /// Copy FULL booking ID (not trimmed)
  Future<void> copyBookingId(String fullId) async {
    await Clipboard.setData(ClipboardData(text: fullId));

    isCopied.value = true;

    // Reset after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      isCopied.value = false;
    });
  }

  void dispose() {
    isCopied.dispose();
  }
}