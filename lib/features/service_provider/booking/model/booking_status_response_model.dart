class BookingStatusResponseModel {
  final bool success;
  final String message;
  final BookingStatusData? data;

  BookingStatusResponseModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory BookingStatusResponseModel.fromJson(Map<String, dynamic> json) {
    return BookingStatusResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? BookingStatusData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}

class BookingStatusData {
  final String id;
  final String? bookingNumber;
  final String clientId;
  final String providerId;
  final String jobId;
  final String serviceName;
  final String? serviceDescription;
  final DateTime? preferredDate;
  final String preferredTime;
  final String scheduledAt;
  final String serviceLocation;
  final String? locationAddress;
  final String locationLatitude;
  final String locationLongitude;
  final String locationDetails;
  final String contactPhone;
  final String? contactEmail;
  final String serviceAmount;
  final String? platformFee;
  final String taxAmount;
  final String? totalAmount;
  final String? paymentMethod;
  final String paymentStatus;
  final String? paidAt;
  final String status;
  final String? cancellationReason;
  final String? cancelledBy;
  final String? cancelledAt;
  final String message;
  final String? completedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? userId;
  final String? paymentId;

  BookingStatusData({
    required this.id,
    this.bookingNumber,
    required this.clientId,
    required this.providerId,
    required this.jobId,
    required this.serviceName,
    this.serviceDescription,
    this.preferredDate,
    required this.preferredTime,
    required this.scheduledAt,
    required this.serviceLocation,
    this.locationAddress,
    required this.locationLatitude,
    required this.locationLongitude,
    required this.locationDetails,
    required this.contactPhone,
    this.contactEmail,
    required this.serviceAmount,
    this.platformFee,
    required this.taxAmount,
    this.totalAmount,
    this.paymentMethod,
    required this.paymentStatus,
    this.paidAt,
    required this.status,
    this.cancellationReason,
    this.cancelledBy,
    this.cancelledAt,
    required this.message,
    this.completedAt,
    required this.createdAt,
    required this.updatedAt,
    this.userId,
    this.paymentId,
  });

  factory BookingStatusData.fromJson(Map<String, dynamic> json) {
    return BookingStatusData(
      id: json['id'] ?? '',
      bookingNumber: json['bookingNumber'],
      clientId: json['clientId'] ?? '',
      providerId: json['providerId'] ?? '',
      jobId: json['jobId'] ?? '',
      serviceName: json['serviceName'] ?? '',
      serviceDescription: json['serviceDescription'],
      preferredDate: json['preferredDate'] != null
          ? DateTime.tryParse(json['preferredDate'].toString())
          : null,
      preferredTime: json['preferredTime'] ?? '',
      scheduledAt: json['scheduledAt'] ?? '',
      serviceLocation: json['serviceLocation'] ?? '',
      locationAddress: json['locationAddress'],
      locationLatitude: json['locationLatitude'] ?? '',
      locationLongitude: json['locationLongitude'] ?? '',
      locationDetails: json['locationDetails'] ?? '',
      contactPhone: json['contactPhone'] ?? '',
      contactEmail: json['contactEmail'],
      serviceAmount: json['serviceAmount']?.toString() ?? '0',
      platformFee: json['platformFee'],
      taxAmount: json['taxAmount']?.toString() ?? '0',
      totalAmount: json['totalAmount'],
      paymentMethod: json['paymentMethod'],
      paymentStatus: json['paymentStatus'] ?? '',
      paidAt: json['paidAt'],
      status: json['status'] ?? '',
      cancellationReason: json['cancellationReason'],
      cancelledBy: json['cancelledBy'],
      cancelledAt: json['cancelledAt'],
      message: json['message'] ?? '',
      completedAt: json['completedAt'],
      createdAt:
          DateTime.tryParse(json['createdAt']?.toString() ?? '') ??
          DateTime.now(),
      updatedAt:
          DateTime.tryParse(json['updatedAt']?.toString() ?? '') ??
          DateTime.now(),
      userId: json['userId'],
      paymentId: json['paymentId'],
    );
  }
}
