import 'package:madeit/core/channel.dart';

typedef Effect<T> = void Function(T event);

void useEffect<T>(Effect<T> effect) {
  listen((event) {
    if (event is T) {
      effect(event);
    }
  });
}
