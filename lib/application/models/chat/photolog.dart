import 'package:madeit/application/models/chat/chat.dart';
import 'package:madeit/application/models/chat/user.dart';
import 'package:madeit/application/models/user.dart';

class PhotologChatModel extends UserChatModel {
  final String message;
  final List<String> imageIds;
  final bool isChecked;

  PhotologChatModel({
    required super.id,
    required super.roomId,
    required super.user,
    required super.createdAt,
    required this.message,
    required this.imageIds,
    required this.isChecked,
  });

  factory PhotologChatModel.fromJson(dynamic json) {
    return PhotologChatModel(
      id: json["id"],
      roomId: json["room_id"],
      user: UserModel.fromJson(json["user"]),
      createdAt: DateTime.parse(json["created_at"]),
      message: json["message"],
      imageIds: (json["image_ids"] as List).map((e) => e.toString()).toList(),
      isChecked: json["is_checked"],
    );
  }

  PhotologChatModel copy({
    String? id,
    String? roomId,
    UserModel? user,
    DateTime? createdAt,
    String? message,
    List<String>? imageIds,
    bool? isChecked,
  }) {
    return PhotologChatModel(
      id: id ?? this.id,
      roomId: roomId ?? this.roomId,
      user: user ?? this.user,
      createdAt: createdAt ?? this.createdAt,
      message: message ?? this.message,
      imageIds: imageIds ?? this.imageIds,
      isChecked: isChecked ?? this.isChecked,
    );
  }
}
