class SubCategoryModel {
  const SubCategoryModel({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.slug,
    required this.description,
    required this.icon,
    required this.image,
    required this.displayOrder,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    this.jobCount = 0,
  });

  final String id;
  final String categoryId;
  final String name;
  final String slug;
  final String description;
  final String icon;
  final String image;
  final int displayOrder;
  final bool isActive;
  final String createdAt;
  final String updatedAt;
  final int jobCount;

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      id: json['id']?.toString() ?? '',
      categoryId: json['categoryId']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      slug: json['slug']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      icon: json['icon']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
      displayOrder: (json['displayOrder'] as num?)?.toInt() ?? 0,
      isActive: json['isActive'] == true,
      createdAt: json['createdAt']?.toString() ?? '',
      updatedAt: json['updatedAt']?.toString() ?? '',
      jobCount: (json['_count']?['jobs'] as num?)?.toInt() ?? 0,
    );
  }
}
