class ExpertRecommendationModel {
  const ExpertRecommendationModel({
    required this.userId,
    required this.avatar,
    required this.firstName,
    required this.lastName,
    required this.streetAddress,
    required this.city,
    required this.zipCode,
    required this.country,
    required this.verificationStatus,
    required this.avgRating,
  });

  final String userId;
  final String? avatar;
  final String firstName;
  final String lastName;
  final String? streetAddress;
  final String? city;
  final String? zipCode;
  final String country;
  final String verificationStatus;
  final double avgRating;

  String get fullName => '$firstName $lastName'.trim();

  factory ExpertRecommendationModel.fromJson(Map<String, dynamic> json) {
    return ExpertRecommendationModel(
      userId:
          json['userId']?.toString() ??
          json['id']?.toString() ??
          json['_id']?.toString() ??
          '',
      avatar: json['avatar']?.toString() ?? json['profileImage']?.toString(),
      firstName: json['firstName']?.toString() ?? '',
      lastName: json['lastName']?.toString() ?? '',
      streetAddress: json['streetAddress']?.toString(),
      city: json['city']?.toString(),
      zipCode: json['zipCode']?.toString(),
      country: json['country']?.toString() ?? '',
      verificationStatus: json['verificationStatus']?.toString() ?? '',
      avgRating: double.tryParse(json['avgRating']?.toString() ?? '') ?? 0.0,
    );
  }
}
