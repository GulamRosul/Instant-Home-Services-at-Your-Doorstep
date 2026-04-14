class DeleteJobResponse {
  final bool success;
  final String message;
  final int statusCode;
  final String timestamp;
  final String path;

  DeleteJobResponse({
    required this.success,
    required this.message,
    required this.statusCode,
    required this.timestamp,
    required this.path,
  });

  factory DeleteJobResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>?;

    return DeleteJobResponse(
      success: data?['success'] ?? false,
      message: data?['message'] ?? 'Unknown error',
      statusCode: json['statusCode'] ?? 500,
      timestamp: json['timestamp'] ?? '',
      path: json['path'] ?? '',
    );
  }
}
