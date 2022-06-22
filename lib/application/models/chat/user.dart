import 'package:madeit/application/models/chat/chat.dart';
import 'package:madeit/application/models/chat/image.dart';
import 'package:madeit/application/models/chat/message.dart';
import 'package:madeit/application/models/chat/photolog.dart';
import 'package:madeit/application/models/user.dart';

abstract class UserChatModel extends ChatModel {
  final UserModel user;

  const UserChatModel({
    required super.id,
    required super.roomId,
    required this.user,
    required super.createdAt,
  });

  factory UserChatModel.fromjson(dynamic json) {
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
}
