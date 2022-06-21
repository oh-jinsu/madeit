import 'package:madeit/application/models/performance.dart';
import 'package:madeit/application/models/user.dart';

class MyRoomModel {
  final String id;
  final String title;
  final String description;
  final UserModel owner;
  final PerformanceModel performance;
  final PerformanceModel myPerformance;
  final int maxParticipant;
  final int participantCount;
  final DateTime createdAt;

  const MyRoomModel({
    required this.id,
    required this.title,
    required this.description,
    required this.owner,
    required this.performance,
    required this.myPerformance,
    required this.maxParticipant,
    required this.participantCount,
    required this.createdAt,
  });

  factory MyRoomModel.fromjson(dynamic json) {
    return MyRoomModel(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      owner: UserModel.fromJson(json["owner"]),
      performance: PerformanceModel.fromjson(json["performance"]),
      myPerformance: PerformanceModel.fromjson(json["performance"]),
      maxParticipant: json["max_participant"],
      participantCount: json["participant_count"],
      createdAt: DateTime.parse(json["created_at"]),
    );
  }

  MyRoomModel copy({
    String? id,
    String? title,
    String? description,
    UserModel? owner,
    PerformanceModel? performance,
    PerformanceModel? myPerformance,
    int? maxParticipant,
    int? participantCount,
    DateTime? createdAt,
  }) {
    return MyRoomModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      owner: owner ?? this.owner,
      performance: performance ?? this.performance,
      myPerformance: myPerformance ?? this.myPerformance,
      maxParticipant: maxParticipant ?? this.maxParticipant,
      participantCount: participantCount ?? this.participantCount,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
