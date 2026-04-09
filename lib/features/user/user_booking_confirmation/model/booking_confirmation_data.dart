import 'package:protiva502/features/user/home/model/home_job_model.dart';

class BookingConfirmationData {
  const BookingConfirmationData({
    required this.service,
    required this.preferredDateTime,
    required this.phoneNumber,
    required this.locationType,
    required this.locationLatitude,
    required this.locationLongitude,
    required this.locationDetails,
    required this.message,
  });

  final HomeJobModel? service;
  final DateTime preferredDateTime;
  final String phoneNumber;
  final String locationType;
  final double locationLatitude;
  final double locationLongitude;
  final String locationDetails;
  final String message;
}
