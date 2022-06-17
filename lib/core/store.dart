import 'dart:async';

import 'package:madeit/core/channel.dart';
import 'package:madeit/core/reducer.dart';
import 'package:rxdart/rxdart.dart';

abstract class StoreApi<T> {
  T get state;

  Stream<T> get stream;

  void _initialize();

  void _dispatch(dynamic event);
}

class _Store<T> implements StoreApi<T> {
  final Reducer<T> reducer;

  final subject = BehaviorSubject<T>();

  @override
  T get state => subject.value;

  @override
  Stream<T> get stream => subject;

  _Store(this.reducer);

  @override
  void _initialize() {
    subject.add(reducer());
  }

  @override
  void _dispatch(event) {
    final result = reducer(state: subject.stream.value, event: event);

    subject.sink.add(result);
  }
}

StoreApi<T> createStore<T>(Reducer<T> reducer) {
  return _Store(reducer);
}

StreamSubscription open(StoreApi store) {
  store._initialize();

  final subscription = listen((event) {
    store._dispatch(event);
  });

  return subscription;
}
