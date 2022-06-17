import 'dart:async';

import 'package:madeit/core/channel.dart';

typedef Effect<T> = void Function(T event);

StreamSubscription on<T>(Effect<T> effect) {
  return listen((event) {
    if (event is T) {
      effect(event);
    }
  });
}
