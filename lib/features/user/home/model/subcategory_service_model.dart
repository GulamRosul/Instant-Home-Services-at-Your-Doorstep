class SubcategoryServiceModel {
  const SubcategoryServiceModel({
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
    required this.features,
    required this.images,
    required this.videos,
    required this.serviceLocation,
    required this.serviceRadius,
    required this.status,
    required this.views,
    required this.clicks,
    required this.totalBookings,
    required this.averageRating,
    required this.metaTitle,
    required this.metaDescription,
    required this.publishedAt,
    required this.isPopuler,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

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

  factory SubcategoryServiceModel.fromJson(Map<String, dynamic> json) {
    return SubcategoryServiceModel(
      id: json['id']?.toString() ?? '',
      userId: json['userId']?.toString() ?? '',
      categoryId: json['categoryId']?.toString() ?? '',
      subCategoryId: json['subCategoryId']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      slug: json['slug']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      basePrice: json['basePrice']?.toString() ?? '0',
      priceType: json['priceType']?.toString() ?? 'FIXED',
      includeService:
          (json['includeService'] as List?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      thumbnail: json['thumbnail']?.toString() ?? '',
      features: json['features'],
      images: (json['images'] as List?) ?? [],
      videos: (json['videos'] as List?) ?? [],
      serviceLocation: json['serviceLocation'],
      serviceRadius: json['serviceRadius'],
      status: json['status']?.toString() ?? 'DRAFT',
      views: (json['views'] as num?)?.toInt() ?? 0,
      clicks: (json['clicks'] as num?)?.toInt() ?? 0,
      totalBookings: (json['totalBookings'] as num?)?.toInt() ?? 0,
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
}

class SubcategoryServiceResponse {
  const SubcategoryServiceResponse({required this.data, required this.meta});

  final List<SubcategoryServiceModel> data;
  final PaginationMeta meta;

  factory SubcategoryServiceResponse.fromJson(Map<String, dynamic> json) {
    final responseData = json['data'] as Map<String, dynamic>? ?? {};
    final dataList =
        (responseData['data'] as List?)?.cast<Map<String, dynamic>>() ?? [];
    final metaData = responseData['meta'] as Map<String, dynamic>? ?? {};

    return SubcategoryServiceResponse(
      data: dataList
          .map((item) => SubcategoryServiceModel.fromJson(item))
          .toList(),
      meta: PaginationMeta.fromJson(metaData),
    );
  }
}

class PaginationMeta {
  const PaginationMeta({
    required this.page,
    required this.skip,
    required this.limit,
    required this.totalService,
    required this.totalPage,
  });

  final int page;
  final int skip;
  final int limit;
  final int totalService;
  final int totalPage;

  factory PaginationMeta.fromJson(Map<String, dynamic> json) {
    return PaginationMeta(
      page: (json['page'] as num?)?.toInt() ?? 1,
      skip: (json['skip'] as num?)?.toInt() ?? 0,
      limit: (json['limit'] as num?)?.toInt() ?? 5,
      totalService: (json['totalService'] as num?)?.toInt() ?? 0,
      totalPage: (json['totalPage'] as num?)?.toInt() ?? 1,
    );
  }
}
