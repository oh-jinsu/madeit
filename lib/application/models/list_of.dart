class ListOf<T> {
  final String? next;
  final List<T> items;

  const ListOf({
    required this.next,
    required this.items,
  });

  factory ListOf.fromJson(dynamic json, T Function(dynamic json) mapper) {
    final next = json["next"];

    final items = (json["items"] as List).map(mapper).toList();

    return ListOf(next: next, items: items);
  }
}
