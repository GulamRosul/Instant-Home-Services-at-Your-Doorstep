import 'package:protiva502/features/service_provider/my_job_list/model/job_model.dart';

class JobDetailsResponseModel {
  final JobDetailsModel? data;
  final int statusCode;
  final String timestamp;
  final String path;

  const JobDetailsResponseModel({
    required this.data,
    required this.statusCode,
    required this.timestamp,
    required this.path,
  });

  factory JobDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];

    return JobDetailsResponseModel(
      data: data is Map
          ? JobDetailsModel.fromJson(
              data.map((key, value) => MapEntry(key.toString(), value)),
            )
          : null,
      statusCode: int.tryParse(json['statusCode']?.toString() ?? '0') ?? 0,
      timestamp: json['timestamp']?.toString() ?? '',
      path: json['path']?.toString() ?? '',
    );
  }
}

class JobDetailsModel {
  final String id;
  final String userId;
  final String categoryId;
  final String subCategoryId;
  final String title;
  final String slug;
  final String description;
  final String basePrice;
  final String priceType;
  final List<String> includeService;
  final String thumbnail;
  final dynamic features;
  final List<dynamic> images;
  final List<dynamic> videos;
  final dynamic serviceLocation;
  final dynamic serviceRadius;
  final String status;
  final int views;
  final int clicks;
  final int totalBookings;
  final dynamic averageRating;
  final dynamic metaTitle;
  final dynamic metaDescription;
  final dynamic publishedAt;
  final bool isPopuler;
  final String createdAt;
  final String updatedAt;
  final dynamic deletedAt;
  final List<JobReviewModel> reviews;

  const JobDetailsModel({
    required this.id,
    required this.userId,
    required this.categoryId,
    required this.subCategoryId,
    required this.title,
    required this.slug,
    required this.description,
    required this.basePrice,
    required this.priceType,
    required this.includeService,
    required this.thumbnail,
    this.features,
    required this.images,
    required this.videos,
    this.serviceLocation,
    this.serviceRadius,
    required this.status,
    required this.views,
    required this.clicks,
    required this.totalBookings,
    this.averageRating,
    this.metaTitle,
    this.metaDescription,
    this.publishedAt,
    required this.isPopuler,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.reviews,
  });

  factory JobDetailsModel.fromJson(Map<String, dynamic> json) {
    return JobDetailsModel(
      id: json['id']?.toString() ?? '',
      userId: json['userId']?.toString() ?? '',
      categoryId: json['categoryId']?.toString() ?? '',
      subCategoryId: json['subCategoryId']?.toString() ?? '',
      title: json['title']?.toString() ?? 'Untitled Job',
      slug: json['slug']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      basePrice: json['basePrice']?.toString() ?? '0',
      priceType: json['priceType']?.toString() ?? 'FIXED',
      includeService: List<String>.from(
        (json['includeService'] as List?)?.map((item) => item.toString()) ?? [],
      ),
      thumbnail: json['thumbnail']?.toString() ?? '',
      features: json['features'],
      images: json['images'] as List? ?? [],
      videos: json['videos'] as List? ?? [],
      serviceLocation: json['serviceLocation'],
      serviceRadius: json['serviceRadius'],
      status: json['status']?.toString() ?? 'DRAFT',
      views: int.tryParse(json['views']?.toString() ?? '0') ?? 0,
      clicks: int.tryParse(json['clicks']?.toString() ?? '0') ?? 0,
      totalBookings:
          int.tryParse(json['totalBookings']?.toString() ?? '0') ?? 0,
      averageRating: json['averageRating'],
      metaTitle: json['metaTitle'],
      metaDescription: json['metaDescription'],
      publishedAt: json['publishedAt'],
      isPopuler: json['isPopuler'] == true || json['isPopular'] == true,
      createdAt: json['createdAt']?.toString() ?? '',
      updatedAt: json['updatedAt']?.toString() ?? '',
      deletedAt: json['deletedAt'],
      reviews: List<JobReviewModel>.from(
        (json['reviews'] as List?)?.whereType<Map>().map(
              (item) => JobReviewModel.fromJson(
                item.map((key, value) => MapEntry(key.toString(), value)),
              ),
            ) ??
            [],
      ),
    );
  }

  JobModel toJobModel() {
    return JobModel(
      id: id,
      userId: userId,
      categoryId: categoryId,
      subCategoryId: subCategoryId,
      title: title,
      slug: slug,
      description: description,
      basePrice: basePrice,
      priceType: priceType,
      includeService: includeService,
      thumbnail: thumbnail,
      features: features,
      images: images,
      videos: videos,
      serviceLocation: serviceLocation,
      serviceRadius: serviceRadius,
      status: status,
      views: views,
      clicks: clicks,
      totalBookings: totalBookings,
      averageRating: averageRating,
      metaTitle: metaTitle,
      metaDescription: metaDescription,
      publishedAt: publishedAt,
      isPopuler: isPopuler,
      createdAt: createdAt,
      updatedAt: updatedAt,
      deletedAt: deletedAt,
    );
  }
}

class JobReviewModel {
  final String id;
  final String jobId;
  final String userId;
  final num rating;
  final String comment;
  final String createdAt;

  const JobReviewModel({
    required this.id,
    required this.jobId,
    required this.userId,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  factory JobReviewModel.fromJson(Map<String, dynamic> json) {
    return JobReviewModel(
      id: json['id']?.toString() ?? '',
      jobId: json['jobId']?.toString() ?? '',
      userId: json['userId']?.toString() ?? '',
      rating: num.tryParse(json['rating']?.toString() ?? '0') ?? 0,
      comment: json['comment']?.toString() ?? '',
      createdAt: json['createdAt']?.toString() ?? '',
    );
  }
}
