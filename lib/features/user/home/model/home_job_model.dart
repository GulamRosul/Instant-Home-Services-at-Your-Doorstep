class HomeJobModel {
  const HomeJobModel({
    required this.id,
    required this.title,
    required this.description,
    required this.basePrice,
    required this.thumbnail,
    required this.averageRating,
    required this.totalBookings,
    required this.isPopular,
  });

  final String id;
  final String title;
  final String description;
  final double basePrice;
  final String thumbnail;
  final double averageRating;
  final int totalBookings;
  final bool isPopular;

  factory HomeJobModel.fromJson(Map<String, dynamic> json) {
    return HomeJobModel(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? 'Untitled Service',
      description: json['description']?.toString() ?? '',
      basePrice: double.tryParse(json['basePrice']?.toString() ?? '') ?? 0,
      thumbnail: json['thumbnail']?.toString() ?? '',
      averageRating:
          double.tryParse(json['averageRating']?.toString() ?? '') ?? 0,
      totalBookings: int.tryParse(json['totalBookings']?.toString() ?? '') ?? 0,
      isPopular: json['isPopuler'] == true || json['isPopular'] == true,
    );
  }
}
