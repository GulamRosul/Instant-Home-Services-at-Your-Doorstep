class HomeJobModel {
  const HomeJobModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.basePrice,
    required this.thumbnail,
    required this.averageRating,
    required this.totalBookings,
    required this.isPopular,
    this.userFirstName = '',
    this.type = 'job',
    this.slug = '',
    this.categoryId = '',
  });

  final String id;
  final String userId;
  final String title;
  final String description;
  final double basePrice;
  final String thumbnail;
  final double averageRating;
  final int totalBookings;
  final bool isPopular;
  final String userFirstName;
  final String type;
  final String slug;
  final String categoryId;

  factory HomeJobModel.fromJson(Map<String, dynamic> json) {
    String firstName = '';
    final user = json['user'];
    if (user is Map) {
      firstName = (user['firstName'] ?? '').toString();
    }

    return HomeJobModel(
      id: json['id']?.toString() ?? '',
      userId: json['userId']?.toString() ?? '',
      title: json['title']?.toString() ?? 'Untitled Service',
      description: json['description']?.toString() ?? '',
      basePrice: double.tryParse(json['basePrice']?.toString() ?? '') ?? 0,
      thumbnail: json['thumbnail']?.toString() ?? '',
      averageRating:
          double.tryParse(json['averageRating']?.toString() ?? '') ?? 0,
      totalBookings: int.tryParse(json['totalBookings']?.toString() ?? '') ?? 0,
      isPopular: json['isPopuler'] == true || json['isPopular'] == true,
      userFirstName: firstName,
      type: json['type']?.toString() ?? 'job',
      slug: json['slug']?.toString() ?? '',
      categoryId: json['categoryId']?.toString() ?? '',
    );
  }
}
