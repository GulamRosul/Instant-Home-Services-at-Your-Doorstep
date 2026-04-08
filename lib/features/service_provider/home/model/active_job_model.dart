class ActiveJobModel {
  const ActiveJobModel({
    required this.id,
    required this.title,
    required this.description,
    required this.basePrice,
    required this.thumbnail,
    required this.averageRating,
    required this.totalBookings,
    required this.views,
    required this.clicks,
  });

  final String id;
  final String title;
  final String description;
  final double basePrice;
  final String thumbnail;
  final double averageRating;
  final int totalBookings;
  final int views;
  final int clicks;

  factory ActiveJobModel.fromJson(Map<String, dynamic> json) {
    return ActiveJobModel(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? 'Untitled Job',
      description: json['description']?.toString() ?? '',
      basePrice: double.tryParse(json['basePrice']?.toString() ?? '') ?? 0,
      thumbnail: json['thumbnail']?.toString() ?? '',
      averageRating:
          double.tryParse(json['averageRating']?.toString() ?? '') ?? 0,
      totalBookings: int.tryParse(json['totalBookings']?.toString() ?? '') ?? 0,
      views: int.tryParse(json['views']?.toString() ?? '') ?? 0,
      clicks: int.tryParse(json['clicks']?.toString() ?? '') ?? 0,
    );
  }
}
