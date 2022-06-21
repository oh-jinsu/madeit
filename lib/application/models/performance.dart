class PerformanceModel {
  final String label;
  final int value;
  final String symbol;

  const PerformanceModel({
    required this.label,
    required this.value,
    required this.symbol,
  });

  factory PerformanceModel.fromjson(dynamic json) {
    return PerformanceModel(
      label: json["label"],
      value: json["value"],
      symbol: json["symbol"],
    );
  }

  PerformanceModel copy({
    String? label,
    int? value,
    String? symbol,
  }) {
    return PerformanceModel(
      label: label ?? this.label,
      value: value ?? this.value,
      symbol: symbol ?? this.symbol,
    );
  }
}
