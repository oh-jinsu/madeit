class RoomModel {
  final String id;
  final String title;
  final int participantCount;
  final String createdAt;

  const RoomModel({
    required this.id,
    required this.title,
    required this.participantCount,
    required this.createdAt,
  });

  factory RoomModel.fromjson(dynamic json) {
    return RoomModel(
      id: json["id"],
      title: json["title"],
      participantCount: json["participant_count"],
      createdAt: json["created_at"],
    );
  }
}
