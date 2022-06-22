import 'package:madeit/application/models/chat/chat.dart';
import 'package:madeit/application/models/chat/user.dart';
import 'package:madeit/application/models/user.dart';

class ImageChatModel extends UserChatModel {
  final List<String> imageIds;

  ImageChatModel({
    required super.id,
    required super.roomId,
    required super.user,
    required super.createdAt,
    required this.imageIds,
  });

  factory ImageChatModel.fromJson(dynamic json) {
    return ImageChatModel(
      id: json["id"],
      roomId: json["room_id"],
      user: UserModel.fromJson(json["user"]),
      createdAt: DateTime.parse(json["created_at"]),
      imageIds: (json["image_ids"] as List).map((e) => e.toString()).toList(),
    );
  }

  ImageChatModel copy({
    String? id,
    String? roomId,
    UserModel? user,
    DateTime? createdAt,
    List<String>? imageIds,
  }) {
    return ImageChatModel(
      id: id ?? this.id,
      roomId: roomId ?? this.roomId,
      user: user ?? this.user,
      createdAt: createdAt ?? this.createdAt,
      imageIds: imageIds ?? this.imageIds,
    );
  }
}
