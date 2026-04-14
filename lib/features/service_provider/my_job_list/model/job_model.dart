class JobModel {
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

  JobModel({
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

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
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
        (json['includeService'] as List?)?.map((x) => x.toString()) ?? [],
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
      isPopuler: json['isPopuler'] == true,
      createdAt: json['createdAt']?.toString() ?? '',
      updatedAt: json['updatedAt']?.toString() ?? '',
      deletedAt: json['deletedAt'],
    );
  }
}

class JobListResponse {
  final int total;
  final int page;
  final int limit;
  final int totalPages;
  final List<JobModel> result;

  JobListResponse({
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
    required this.result,
  });

  factory JobListResponse.fromJson(Map<String, dynamic> json) {
    return JobListResponse(
      total: int.tryParse(json['total']?.toString() ?? '0') ?? 0,
      page: int.tryParse(json['page']?.toString() ?? '1') ?? 1,
      limit: int.tryParse(json['limit']?.toString() ?? '10') ?? 10,
      totalPages: int.tryParse(json['totalPages']?.toString() ?? '1') ?? 1,
      result: List<JobModel>.from(
        (json['result'] as List?)?.map((x) => JobModel.fromJson(x)) ?? [],
      ),
    );
  }
}
