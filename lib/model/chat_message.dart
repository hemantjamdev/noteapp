class ChatMessage {
  final DateTime createdAt;
  final bool isCurrentUser;
  final String message;

  ChatMessage({
    required this.createdAt,
    required this.isCurrentUser,
    required this.message,
  });

  ChatMessage copyWith({
    DateTime? createdAt,
    bool? isCurrentUser,
    String? message,
  }) {
    return ChatMessage(
      createdAt: createdAt ?? this.createdAt,
      isCurrentUser: isCurrentUser ?? this.isCurrentUser,
      message: message ?? this.message,
    );
  }

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      createdAt: DateTime.parse(json['createdAt']),
      isCurrentUser: json['isCurrentUser'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt.toIso8601String(),
      'isCurrentUser': isCurrentUser,
      'message': message,
    };
  }
}
