class CreateJobModel {
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
  final List<String> images;
  final List<String> videos;
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

  CreateJobModel({
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
  });

  factory CreateJobModel.fromJson(Map<String, dynamic> json) {
    return CreateJobModel(
      id: json['id']?.toString() ?? '',
      userId: json['userId']?.toString() ?? '',
      categoryId: json['categoryId']?.toString() ?? '',
      subCategoryId: json['subCategoryId']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      slug: json['slug']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      basePrice: json['basePrice']?.toString() ?? '0',
      priceType: json['priceType']?.toString() ?? 'FIXED',
      includeService: List<String>.from(
        (json['includeService'] as List<dynamic>?)?.map((x) => x.toString()) ??
            [],
      ),
      thumbnail: json['thumbnail']?.toString() ?? '',
      features: json['features'],
      images: List<String>.from(
        (json['images'] as List<dynamic>?)?.map((x) => x.toString()) ?? [],
      ),
      videos: List<String>.from(
        (json['videos'] as List<dynamic>?)?.map((x) => x.toString()) ?? [],
      ),
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
      isPopuler: json['isPopuler'] ?? false,
      createdAt: json['createdAt']?.toString() ?? '',
      updatedAt: json['updatedAt']?.toString() ?? '',
      deletedAt: json['deletedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'categoryId': categoryId,
      'subCategoryId': subCategoryId,
      'title': title,
      'slug': slug,
      'description': description,
      'basePrice': basePrice,
      'priceType': priceType,
      'includeService': includeService,
      'thumbnail': thumbnail,
      'features': features,
      'images': images,
      'videos': videos,
      'serviceLocation': serviceLocation,
      'serviceRadius': serviceRadius,
      'status': status,
      'views': views,
      'clicks': clicks,
      'totalBookings': totalBookings,
      'averageRating': averageRating,
      'metaTitle': metaTitle,
      'metaDescription': metaDescription,
      'publishedAt': publishedAt,
      'isPopuler': isPopuler,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
    };
  }

  CreateJobModel copyWith({
    String? id,
    String? userId,
    String? categoryId,
    String? subCategoryId,
    String? title,
    String? slug,
    String? description,
    String? basePrice,
    String? priceType,
    List<String>? includeService,
    String? thumbnail,
    dynamic features,
    List<String>? images,
    List<String>? videos,
    dynamic serviceLocation,
    dynamic serviceRadius,
    String? status,
    int? views,
    int? clicks,
    int? totalBookings,
    dynamic averageRating,
    dynamic metaTitle,
    dynamic metaDescription,
    dynamic publishedAt,
    bool? isPopuler,
    String? createdAt,
    String? updatedAt,
    dynamic deletedAt,
  }) {
    return CreateJobModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      categoryId: categoryId ?? this.categoryId,
      subCategoryId: subCategoryId ?? this.subCategoryId,
      title: title ?? this.title,
      slug: slug ?? this.slug,
      description: description ?? this.description,
      basePrice: basePrice ?? this.basePrice,
      priceType: priceType ?? this.priceType,
      includeService: includeService ?? this.includeService,
      thumbnail: thumbnail ?? this.thumbnail,
      features: features ?? this.features,
      images: images ?? this.images,
      videos: videos ?? this.videos,
      serviceLocation: serviceLocation ?? this.serviceLocation,
      serviceRadius: serviceRadius ?? this.serviceRadius,
      status: status ?? this.status,
      views: views ?? this.views,
      clicks: clicks ?? this.clicks,
      totalBookings: totalBookings ?? this.totalBookings,
      averageRating: averageRating ?? this.averageRating,
      metaTitle: metaTitle ?? this.metaTitle,
      metaDescription: metaDescription ?? this.metaDescription,
      publishedAt: publishedAt ?? this.publishedAt,
      isPopuler: isPopuler ?? this.isPopuler,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }
}
