class RecentBookingModel {
  const RecentBookingModel({
    required this.id,
    required this.bookingNumber,
    required this.serviceName,
    required this.serviceDescription,
    required this.preferredDate,
    required this.preferredTime,
    required this.locationDetails,
    required this.contactPhone,
    required this.serviceAmount,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.status,
    required this.message,
    required this.createdAt,
    required this.clientId,
    required this.providerId,
  });

  final String id;
  final String bookingNumber;
  final String serviceName;
  final String serviceDescription;
  final DateTime? preferredDate;
  final String preferredTime;
  final String locationDetails;
  final String contactPhone;
  final double serviceAmount;
  final String paymentMethod;
  final String paymentStatus;
  final String status;
  final String message;
  final DateTime? createdAt;
  final String? clientId;
  final String? providerId;

  factory RecentBookingModel.fromJson(Map<String, dynamic> json) {
    return RecentBookingModel(
      id: json['id']?.toString() ?? '',
      bookingNumber: json['bookingNumber']?.toString() ?? '',
      serviceName: json['serviceName']?.toString() ?? 'Unknown Service',
      serviceDescription: json['serviceDescription']?.toString() ?? '',
      preferredDate: DateTime.tryParse(json['preferredDate']?.toString() ?? ''),
      preferredTime: json['preferredTime']?.toString() ?? '',
      locationDetails: json['locationDetails']?.toString() ?? '',
      contactPhone: json['contactPhone']?.toString() ?? '',
      serviceAmount:
          double.tryParse(json['serviceAmount']?.toString() ?? '') ?? 0,
      paymentMethod: json['paymentMethod']?.toString() ?? '',
      paymentStatus: json['paymentStatus']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      message: json['message']?.toString() ?? '',
      createdAt: DateTime.tryParse(json['createdAt']?.toString() ?? ''),
      clientId: json['clientId']?.toString(),
      providerId: json['providerId']?.toString(),
    );
  }

  RecentBookingModel copyWith({
    String? id,
    String? bookingNumber,
    String? serviceName,
    String? serviceDescription,
    DateTime? preferredDate,
    String? preferredTime,
    String? locationDetails,
    String? contactPhone,
    double? serviceAmount,
    String? paymentMethod,
    String? paymentStatus,
    String? status,
    String? message,
    DateTime? createdAt,
    String? clientId,
    String? providerId,
  }) {
    return RecentBookingModel(
      id: id ?? this.id,
      bookingNumber: bookingNumber ?? this.bookingNumber,
      serviceName: serviceName ?? this.serviceName,
      serviceDescription: serviceDescription ?? this.serviceDescription,
      preferredDate: preferredDate ?? this.preferredDate,
      preferredTime: preferredTime ?? this.preferredTime,
      locationDetails: locationDetails ?? this.locationDetails,
      contactPhone: contactPhone ?? this.contactPhone,
      serviceAmount: serviceAmount ?? this.serviceAmount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      status: status ?? this.status,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
      clientId: clientId ?? this.clientId,
      providerId: providerId ?? this.providerId,
    );
  }
}
