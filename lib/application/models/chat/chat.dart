import 'package:madeit/application/models/chat/image.dart';
import 'package:madeit/application/models/chat/message.dart';
import 'package:madeit/application/models/chat/photolog.dart';
import 'package:madeit/application/models/user.dart';

class ChatModel {
  final String id;
  final String roomId;
  final UserModel user;
  final DateTime createdAt;

  const ChatModel({
    required this.id,
    required this.roomId,
    required this.user,
    required this.createdAt,
  });

  factory ChatModel.fromjson(dynamic json) {
    switch (json["type"]) {
      case "message":
        return MessageChatModel.fromjson(json);
      case "image":
        return ImageChatModel.fromJson(json);
      case "photolog":
        return PhotologChatModel.fromJson(json);
      default:
        throw Error();
    }
  }

  ChatModel copy({
    String? id,
    String? roomId,
    UserModel? user,
    DateTime? createdAt,
  }) {
    return ChatModel(
      id: id ?? this.id,
      roomId: roomId ?? this.roomId,
      user: user ?? this.user,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
