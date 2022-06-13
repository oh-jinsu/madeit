import 'dart:async';

import 'package:rxdart/subjects.dart';

final _channel = PublishSubject();

final List<StreamSubscription> _subscriptions = [];

void listen(
  void Function(dynamic)? onData, {
  Function? onError,
  void Function()? onDone,
  bool? cancelOnError,
}) {
  final subscription = _channel.listen(
    onData,
    onError: onError,
    onDone: onDone,
    cancelOnError: cancelOnError,
  );

  _subscriptions.add(subscription);
}

void dispatch(dynamic event) => _channel.sink.add(event);

void initializeChannel() {
  for (final subscription in _subscriptions) {
    subscription.cancel();
  }
}
