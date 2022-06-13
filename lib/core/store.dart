import 'package:madeit/core/channel.dart';
import 'package:madeit/core/reducer.dart';
import 'package:rxdart/rxdart.dart';

ValueStream<T?> createStore<T>(Reducer<T> reducer) {
  final initialState = reducer(null, null);

  final subject = BehaviorSubject.seeded(initialState);

  listen((event) {
    final result = reducer(subject.value, event);

    subject.sink.add(result);
  });

  return subject.stream;
}

void useStore(ValueStream store) {}
