class RecentBookingModel {
  const RecentBookingModel({
    required this.id,
    required this.serviceName,
    required this.locationDetails,
    required this.serviceAmount,
    required this.status,
    required this.preferredTime,
    required this.preferredDate,
  });

  final String id;
  final String serviceName;
  final String locationDetails;
  final double serviceAmount;
  final String status;
  final String preferredTime;
  final DateTime? preferredDate;

  factory RecentBookingModel.fromJson(Map<String, dynamic> json) {
    return RecentBookingModel(
      id: json['id']?.toString() ?? '',
      serviceName: json['serviceName']?.toString() ?? 'Service',
      locationDetails:
          json['locationDetails']?.toString() ?? 'Location not set',
      serviceAmount:
          double.tryParse(json['serviceAmount']?.toString() ?? '') ?? 0,
      status: json['status']?.toString() ?? 'UNKNOWN',
      preferredTime: json['preferredTime']?.toString() ?? '',
      preferredDate: DateTime.tryParse(json['preferredDate']?.toString() ?? ''),
    );
  }
}
