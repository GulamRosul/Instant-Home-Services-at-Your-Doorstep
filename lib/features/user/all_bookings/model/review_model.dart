class ReviewResponse {
  ReviewResponse({
    required this.success,
    required this.message,
    required this.result,
  });

  final bool success;
  final String message;
  final ReviewResult result;

  factory ReviewResponse.fromJson(Map<String, dynamic> json) {
    return ReviewResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      result: ReviewResult.fromJson(json['result'] ?? {}),
    );
  }
}

class ReviewResult {
  ReviewResult({
    required this.id,
    required this.bookingId,
    required this.senderId,
    required this.receiverId,
    required this.jobId,
    required this.rating,
    required this.comment,
    required this.image,
    required this.createdAt,
  });

  final String id;
  final String bookingId;
  final String senderId;
  final String receiverId;
  final String jobId;
  final int rating;
  final String comment;
  final String image;
  final DateTime createdAt;

  factory ReviewResult.fromJson(Map<String, dynamic> json) {
    return ReviewResult(
      id: json['id'] ?? '',
      bookingId: json['bookingId'] ?? '',
      senderId: json['senderId'] ?? '',
      receiverId: json['receiverId'] ?? '',
      jobId: json['jobId'] ?? '',
      rating: json['rating'] ?? 0,
      comment: json['comment'] ?? '',
      image: json['image'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }
}
