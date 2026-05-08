class ChatMessageModel {
  final String id;
  final String senderId;
  final String receiverId;
  final String bookingId;
  final String roomId;
  final String content;
  final String messageType;
  final String? mediaUrl;
  final bool isRead;
  final String? readAt;
  final String? createdAt;
  final Map<String, dynamic>? sender;

  const ChatMessageModel({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.bookingId,
    required this.roomId,
    required this.content,
    required this.messageType,
    required this.mediaUrl,
    required this.isRead,
    required this.readAt,
    required this.createdAt,
    required this.sender,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: (json['id'] ?? '').toString(),
      senderId: (json['senderId'] ?? '').toString(),
      receiverId: (json['receiverId'] ?? '').toString(),
      bookingId: (json['bookingId'] ?? '').toString(),
      roomId: (json['roomId'] ?? '').toString(),
      content: (json['content'] ?? '').toString(),
      messageType: (json['messageType'] ?? 'TEXT').toString(),
      mediaUrl: json['mediaUrl']?.toString(),
      isRead: json['isRead'] == true,
      readAt: json['readAt']?.toString(),
      createdAt: json['createdAt']?.toString(),
      sender: json['sender'] is Map<String, dynamic>
          ? json['sender'] as Map<String, dynamic>
          : null,
    );
  }

  Map<String, dynamic> toUiMap({required String currentUserId}) {
    final me = senderId == currentUserId;

    // Extract sender's display name
    String senderName = '';
    if (sender is Map<String, dynamic>) {
      final firstName = sender!['firstName']?.toString().trim() ?? '';
      final lastName = sender!['lastName']?.toString().trim() ?? '';
      senderName = '$firstName $lastName'.trim();
      if (senderName.isEmpty) {
        senderName = sender!['username']?.toString() ?? '';
      }
    }

    return {
      'message': content,
      'isMe': me,
      'time': _formatTime(createdAt),
      'messageId': id,
      'messageType': messageType,
      'mediaUrl': mediaUrl,
      'isRead': isRead,
      'senderId': senderId,
      'status': me ? (isRead ? 'read' : 'sent') : 'received',
      'isLocal': false,
      'createdAt': createdAt,
      'sender': sender,
      'senderName': senderName,
    };
  }

  static String _formatTime(String? isoTime) {
    if (isoTime == null || isoTime.isEmpty) {
      return '';
    }

    try {
      final dateTime = DateTime.parse(isoTime).toLocal();
      final hour = dateTime.hour.toString().padLeft(2, '0');
      final minute = dateTime.minute.toString().padLeft(2, '0');
      return '$hour:$minute';
    } catch (_) {
      return '';
    }
  }
}
