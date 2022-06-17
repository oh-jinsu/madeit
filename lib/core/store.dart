import 'dart:async';

import 'package:madeit/core/channel.dart';
import 'package:madeit/core/reducer.dart';
import 'package:rxdart/rxdart.dart';

abstract class Store<T> {
  ValueStream<T?> get stream;

  void _dispatch(dynamic event);
}

class _Store<T> implements Store<T> {
  final Reducer<T> reducer;

  late final subject = BehaviorSubject<T?>.seeded(reducer());

  @override
  ValueStream<T?> get stream => subject;

  _Store(this.reducer);

  @override
  void _dispatch(event) {
    final result = reducer(state: subject.stream.valueOrNull, event: event);

    subject.sink.add(result);
  }
}

Store<T> createStore<T>(Reducer<T> reducer) {
  return _Store(reducer);
}

StreamSubscription useStore(Store store) {
  final subscription = listen((event) {
    store._dispatch(event);
  });

  return subscription;
}
