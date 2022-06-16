import 'package:madeit/core/channel.dart';
import 'package:madeit/core/reducer.dart';
import 'package:rxdart/rxdart.dart';

ValueStream<T?> createStore<T>(Reducer<T> reducer) {
  final initialState = reducer();

  final subject = BehaviorSubject.seeded(initialState);

  listen((event) {
    final result = reducer(state: subject.value, event: event);

    subject.sink.add(result);
  });

  return subject.stream;
}

void touchStore(ValueStream store) {}
