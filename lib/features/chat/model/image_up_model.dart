class ImageUploadResponse {
  final String url;
  final String thumbnailUrl;
  final String fileName;
  final int fileSize;

  ImageUploadResponse({
    required this.url,
    required this.thumbnailUrl,
    required this.fileName,
    required this.fileSize,
  });

  factory ImageUploadResponse.fromJson(Map<String, dynamic> json) {
    return ImageUploadResponse(
      url: json['url']?.toString() ?? '',
      thumbnailUrl: json['thumbnailUrl']?.toString() ?? '',
      fileName: json['fileName']?.toString() ?? '',
      fileSize: json['fileSize'] as int? ?? 0,
    );
  }
}
