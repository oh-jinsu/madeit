import 'package:madeit/application/models/chat/chat.dart';
import 'package:madeit/application/models/user.dart';

class MessageChatModel extends ChatModel {
  final String message;

  MessageChatModel({
    required super.id,
    required super.roomId,
    required super.user,
    required super.createdAt,
    required this.message,
  });

  factory MessageChatModel.fromjson(dynamic json) {
    return MessageChatModel(
      id: json["id"],
      roomId: json["room_id"],
      user: UserModel.fromJson(json["user"]),
      createdAt: DateTime.parse(json["created_at"]),
      message: json["message"],
    );
  }

  @override
  MessageChatModel copy({
    String? id,
    String? roomId,
    UserModel? user,
    DateTime? createdAt,
    String? message,
  }) {
    return MessageChatModel(
      id: id ?? this.id,
      roomId: roomId ?? this.roomId,
      user: user ?? this.user,
      createdAt: createdAt ?? this.createdAt,
      message: message ?? this.message,
    );
  }
}
