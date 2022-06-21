import 'package:madeit/application/models/option.dart';

class UserModel {
  final String id;
  final String name;
  final Option<String> avatarId;
  final DateTime updatedAt;
  final DateTime createdAt;

  const UserModel({
    required this.id,
    required this.name,
    required this.avatarId,
    required this.updatedAt,
    required this.createdAt,
  });

  factory UserModel.fromJson(dynamic json) {
    return UserModel(
      id: json["id"],
      name: json["name"],
      avatarId: Option(json["avatar_id"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      createdAt: DateTime.parse(json["created_at"]),
    );
  }

  UserModel copy({
    String? id,
    String? name,
    Option<String>? avatarId,
    DateTime? updatedAt,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      avatarId: avatarId ?? this.avatarId,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
