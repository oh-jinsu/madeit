import 'dart:async';

import 'package:madeit/core/channel.dart';
import 'package:madeit/core/reducer.dart';
import 'package:rxdart/rxdart.dart';

abstract class Store<T> {
  Stream<T?> get stream;

  void _initialize();

  void _dispatch(dynamic event);
}

class _Store<T> implements Store<T> {
  final Reducer<T> reducer;

  final subject = BehaviorSubject<T?>();

  @override
  Stream<T?> get stream => subject;

  _Store(this.reducer);

  @override
  void _initialize() {
    subject.add(reducer());
  }

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
  store._initialize();

  final subscription = listen((event) {
    store._dispatch(event);
  });

  return subscription;
}
