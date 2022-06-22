import 'package:madeit/application/models/chat/chat.dart';

class NoticeChatModel extends ChatModel {
  final String message;

  NoticeChatModel({
    required super.id,
    required super.roomId,
    required super.createdAt,
    required this.message,
  });

  factory NoticeChatModel.fromjson(dynamic json) {
    return NoticeChatModel(
      id: json["id"],
      roomId: json["room_id"],
      createdAt: DateTime.parse(json["created_at"]),
      message: json["message"],
    );
  }

  NoticeChatModel copy({
    String? id,
    String? roomId,
    DateTime? createdAt,
    String? message,
  }) {
    return NoticeChatModel(
      id: id ?? this.id,
      roomId: roomId ?? this.roomId,
      createdAt: createdAt ?? this.createdAt,
      message: message ?? this.message,
    );
  }
}
