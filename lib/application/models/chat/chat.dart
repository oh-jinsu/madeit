import 'package:madeit/application/models/chat/image.dart';
import 'package:madeit/application/models/chat/message.dart';
import 'package:madeit/application/models/chat/notice.dart';
import 'package:madeit/application/models/chat/photolog.dart';

abstract class ChatModel {
  final String id;
  final String roomId;
  final DateTime createdAt;

  const ChatModel({
    required this.id,
    required this.roomId,
    required this.createdAt,
  });

  factory ChatModel.fromjson(dynamic json) {
    switch (json["type"]) {
      case "notice":
        return NoticeChatModel.fromjson(json);
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
}
