class ProviderDetailsModel {
  const ProviderDetailsModel({
    required this.avgReview,
    required this.id,
    required this.email,
    required this.phone,
    required this.firstName,
    required this.lastName,
    required this.bio,
    required this.avatar,
    required this.city,
    required this.state,
    required this.country,
    required this.status,
    required this.verificationStatus,
    required this.providerServiceAvailability,
    required this.jobs,
    required this.receivedReviews,
    required this.jobCount,
    required this.reviewCount,
  });

  final double avgReview;
  final String id;
  final String email;
  final String phone;
  final String firstName;
  final String lastName;
  final String? bio;
  final String? avatar;
  final String? city;
  final String? state;
  final String? country;
  final String status;
  final String verificationStatus;
  final bool providerServiceAvailability;
  final List<ProviderJobModel> jobs;
  final List<ProviderReviewModel> receivedReviews;
  final int jobCount;
  final int reviewCount;

  String get fullName {
    final name = '$firstName $lastName'.trim();
    return name.isEmpty ? 'Provider' : name;
  }

  factory ProviderDetailsModel.fromJson(Map<String, dynamic> json) {
    final jobs =
        (json['jobs'] as List?)
            ?.whereType<Map>()
            .map(
              (item) => ProviderJobModel.fromJson(
                item.map((key, value) => MapEntry(key.toString(), value)),
              ),
            )
            .toList() ??
        const <ProviderJobModel>[];

    final reviews =
        (json['receivedReviews'] as List?)
            ?.whereType<Map>()
            .map(
              (item) => ProviderReviewModel.fromJson(
                item.map((key, value) => MapEntry(key.toString(), value)),
              ),
            )
            .toList() ??
        const <ProviderReviewModel>[];

    final countMap = json['_count'] is Map
        ? (json['_count'] as Map).map(
            (key, value) => MapEntry(key.toString(), value),
          )
        : <String, dynamic>{};

    return ProviderDetailsModel(
      avgReview: double.tryParse(json['avgReview']?.toString() ?? '') ?? 0,
      id: json['id']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      firstName: json['firstName']?.toString() ?? '',
      lastName: json['lastName']?.toString() ?? '',
      bio: json['bio']?.toString(),
      avatar: json['avatar']?.toString(),
      city: json['city']?.toString(),
      state: json['state']?.toString(),
      country: json['country']?.toString(),
      status: json['status']?.toString() ?? '',
      verificationStatus: json['verificationStatus']?.toString() ?? '',
      providerServiceAvailability: json['providerServiceAvailability'] == true,
      jobs: jobs,
      receivedReviews: reviews,
      jobCount: (countMap['jobs'] as num?)?.toInt() ?? jobs.length,
      reviewCount:
          (countMap['receivedReviews'] as num?)?.toInt() ?? reviews.length,
    );
  }
}

class ProviderJobModel {
  const ProviderJobModel({
    required this.id,
    required this.title,
    required this.description,
    required this.basePrice,
    required this.includeService,
    required this.thumbnail,
    required this.totalBookings,
    required this.averageRating,
    required this.status,
  });

  final String id;
  final String title;
  final String description;
  final double basePrice;
  final List<String> includeService;
  final String thumbnail;
  final int totalBookings;
  final double averageRating;
  final String status;

  factory ProviderJobModel.fromJson(Map<String, dynamic> json) {
    return ProviderJobModel(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? 'Untitled Service',
      description: json['description']?.toString() ?? '',
      basePrice: double.tryParse(json['basePrice']?.toString() ?? '') ?? 0,
      includeService:
          (json['includeService'] as List?)
              ?.map((item) => item.toString())
              .toList() ??
          const <String>[],
      thumbnail: json['thumbnail']?.toString() ?? '',
      totalBookings: (json['totalBookings'] as num?)?.toInt() ?? 0,
      averageRating:
          double.tryParse(json['averageRating']?.toString() ?? '') ?? 0,
      status: json['status']?.toString() ?? '',
    );
  }
}

class ProviderReviewModel {
  const ProviderReviewModel({
    required this.id,
    required this.rating,
    required this.comment,
    required this.images,
    required this.createdAt,
  });

  final String id;
  final int rating;
  final String comment;
  final List<String> images;
  final DateTime? createdAt;

  factory ProviderReviewModel.fromJson(Map<String, dynamic> json) {
    return ProviderReviewModel(
      id: json['id']?.toString() ?? '',
      rating: (json['rating'] as num?)?.toInt() ?? 0,
      comment: json['comment']?.toString() ?? '',
      images:
          (json['images'] as List?)?.map((item) => item.toString()).toList() ??
          const <String>[],
      createdAt: DateTime.tryParse(json['createdAt']?.toString() ?? ''),
    );
  }
}
