import 'package:madeit/application/models/option.dart';

class ListOf<T> {
  final bool isPending;
  final Option<String> next;
  final List<T> items;

  const ListOf({
    required this.isPending,
    required this.next,
    required this.items,
  });

  factory ListOf.fromJson(dynamic json, T Function(dynamic json) mapper) {
    final next = json["next"];

    final items = (json["items"] as List).map(mapper).toList();

    return ListOf(
      isPending: false,
      next: Option(next),
      items: items,
    );
  }

  ListOf<T> copy({
    bool? isPending,
    Option<String>? next,
    List<T>? items,
  }) {
    return ListOf(
      isPending: isPending ?? this.isPending,
      next: next ?? this.next,
      items: items ?? this.items,
    );
  }
}
