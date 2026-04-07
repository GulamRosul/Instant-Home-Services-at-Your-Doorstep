class BookingSummaryStats {
  const BookingSummaryStats({
    required this.totalBooking,
    required this.totalAccepted,
    required this.totalInProgress,
    required this.totalComplete,
  });

  const BookingSummaryStats.empty()
    : totalBooking = 0,
      totalAccepted = 0,
      totalInProgress = 0,
      totalComplete = 0;

  final int totalBooking;
  final int totalAccepted;
  final int totalInProgress;
  final int totalComplete;

  factory BookingSummaryStats.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const BookingSummaryStats.empty();
    }

    return BookingSummaryStats(
      totalBooking: _parseInt(json['totalBooking']),
      totalAccepted: _parseInt(json['totalAccepted']),
      totalInProgress: _parseInt(json['totalInProgress']),
      totalComplete: _parseInt(json['totalComplete']),
    );
  }
}

class UserBookingItem {
  const UserBookingItem({
    required this.id,
    required this.bookingNumber,
    required this.serviceName,
    required this.serviceDescription,
    required this.preferredDate,
    required this.preferredTime,
    required this.serviceLocation,
    required this.locationAddress,
    required this.locationDetails,
    required this.contactPhone,
    required this.contactEmail,
    required this.serviceAmount,
    required this.totalAmount,
    required this.paymentStatus,
    required this.status,
    required this.message,
    required this.createdAt,
  });

  final String id;
  final String? bookingNumber;
  final String serviceName;
  final String? serviceDescription;
  final DateTime? preferredDate;
  final String? preferredTime;
  final String? serviceLocation;
  final String? locationAddress;
  final String? locationDetails;
  final String? contactPhone;
  final String? contactEmail;
  final double serviceAmount;
  final double totalAmount;
  final String? paymentStatus;
  final String? status;
  final String? message;
  final DateTime? createdAt;

  factory UserBookingItem.fromJson(Map<String, dynamic> json) {
    final serviceAmount = _parseDouble(json['serviceAmount']);
    final totalAmount = _parseDouble(json['totalAmount']);

    return UserBookingItem(
      id: (json['id'] ?? '').toString(),
      bookingNumber: _nullableText(json['bookingNumber']),
      serviceName: _nullableText(json['serviceName']) ?? 'Service Booking',
      serviceDescription: _nullableText(json['serviceDescription']),
      preferredDate: _parseDate(json['preferredDate']),
      preferredTime: _nullableText(json['preferredTime']),
      serviceLocation: _nullableText(json['serviceLocation']),
      locationAddress: _nullableText(json['locationAddress']),
      locationDetails: _nullableText(json['locationDetails']),
      contactPhone: _nullableText(json['contactPhone']),
      contactEmail: _nullableText(json['contactEmail']),
      serviceAmount: serviceAmount,
      totalAmount: totalAmount > 0 ? totalAmount : serviceAmount,
      paymentStatus: _nullableText(json['paymentStatus']),
      status: _nullableText(json['status']),
      message: _nullableText(json['message']),
      createdAt: _parseDate(json['createdAt']),
    );
  }

  String get displayStatus => humanizeBookingStatus(status);

  String get displayPaymentStatus => humanizeBookingStatus(paymentStatus);

  String get reference => bookingNumber ?? id;

  String get locationText {
    return _firstNonEmpty([
          locationDetails,
          locationAddress,
          humanizeBookingLocation(serviceLocation),
        ]) ??
        'Location not provided';
  }

  bool get isCompleted {
    final normalized = normalizeBookingStatus(status);
    return normalized == 'COMPLETE' || normalized == 'COMPLETED';
  }

  bool get canTrack {
    final normalized = normalizeBookingStatus(status);
    return normalized == 'ACCEPTED' || normalized == 'IN_PROGRESS';
  }
}

String normalizeBookingStatus(String? value) {
  return (value ?? '')
      .trim()
      .toUpperCase()
      .replaceAll('-', '_')
      .replaceAll(' ', '_');
}

String humanizeBookingStatus(String? value) {
  final normalized = normalizeBookingStatus(value);

  switch (normalized) {
    case 'IN_PROGRESS':
      return 'In-Progress';
    case 'COMPLETE':
    case 'COMPLETED':
      return 'Completed';
    case 'CUSTOMER_LOCATION':
      return 'Customer Location';
    case 'PROVIDER_LOCATION':
      return 'Provider Location';
    default:
      if (normalized.isEmpty) {
        return 'Unknown';
      }

      return normalized
          .split('_')
          .where((part) => part.isNotEmpty)
          .map(_capitalize)
          .join(' ');
  }
}

String humanizeBookingLocation(String? value) {
  return humanizeBookingStatus(value);
}

String _capitalize(String value) {
  if (value.isEmpty) {
    return value;
  }

  final lower = value.toLowerCase();
  return '${lower[0].toUpperCase()}${lower.substring(1)}';
}

String? _nullableText(dynamic value) {
  final text = value?.toString().trim();
  if (text == null || text.isEmpty || text.toLowerCase() == 'null') {
    return null;
  }

  return text;
}

String? _firstNonEmpty(List<String?> values) {
  for (final value in values) {
    if (value != null && value.trim().isNotEmpty) {
      return value;
    }
  }

  return null;
}

int _parseInt(dynamic value) {
  if (value is int) {
    return value;
  }

  if (value is num) {
    return value.toInt();
  }

  return int.tryParse(value?.toString() ?? '') ?? 0;
}

double _parseDouble(dynamic value) {
  if (value is double) {
    return value;
  }

  if (value is num) {
    return value.toDouble();
  }

  return double.tryParse(value?.toString() ?? '') ?? 0;
}

DateTime? _parseDate(dynamic value) {
  final text = _nullableText(value);
  if (text == null) {
    return null;
  }

  return DateTime.tryParse(text);
}
