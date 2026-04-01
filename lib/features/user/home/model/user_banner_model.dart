class UserBannerModel {
  const UserBannerModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.link,
    required this.displayOrder,
    required this.isActive,
  });

  final String id;
  final String title;
  final String description;
  final String image;
  final String link;
  final int displayOrder;
  final bool isActive;

  factory UserBannerModel.fromJson(Map<String, dynamic> json) {
    return UserBannerModel(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
      link: json['link']?.toString() ?? '',
      displayOrder: (json['displayOrder'] as num?)?.toInt() ?? 0,
      isActive: json['isActive'] == true,
    );
  }
}
