class ReactionCountsModel {
  final int goodCount;
  final int loveCount;
  final int comeOnCount;

  const ReactionCountsModel({
    required this.goodCount,
    required this.loveCount,
    required this.comeOnCount,
  });

  factory ReactionCountsModel.fromJson(dynamic json) {
    return ReactionCountsModel(
      goodCount: json["good_count"],
      loveCount: json["love_count"],
      comeOnCount: json["come_on_count"],
    );
  }

  ReactionCountsModel copy({
    int? goodCount,
    int? loveCount,
    int? comeOnCount,
  }) {
    return ReactionCountsModel(
      goodCount: goodCount ?? this.goodCount,
      loveCount: loveCount ?? this.loveCount,
      comeOnCount: comeOnCount ?? this.comeOnCount,
    );
  }
}
