import 'dart:async';

import 'package:flutter/material.dart';
import 'package:madeit/core/store.dart' as store_api;
import 'package:madeit/core/effect.dart' as effect_api;

typedef Builder<T> = Widget Function(
  BuildContext context,
  AsyncSnapshot<T> snapshot,
);

mixin SubscriptionManagerMixin<T extends StatefulWidget> on State<T> {
  final _subscriptions = <StreamSubscription>[];

  void open(store_api.Store store) {
    final subscription = store_api.useStore(store);

    _subscriptions.add(subscription);
  }

  @protected
  StreamBuilder<K?> Function(
    Widget Function(K value) onNext, {
    Widget Function()? onLoading,
    Widget Function(Object? error)? onError,
  }) watch<K>(store_api.Store<K> store) {
    return (
      Widget Function(K value) onNext, {
      Widget Function()? onLoading,
      Widget Function(Object? error)? onError,
    }) {
      return StreamBuilder<K?>(
        stream: store.stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return onError?.call(snapshot.error) ?? const SizedBox();
          }

          if (snapshot.hasData) {
            final data = snapshot.data;

            if (data != null) {
              return onNext(data);
            }
          }

          return onLoading?.call() ?? const SizedBox();
        },
      );
    };
  }

  @protected
  void on<K>(effect_api.Effect<K> effect) {
    final subscription = effect_api.useEffect(effect);

    _subscriptions.add(subscription);
  }

  @override
  void dispose() {
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }

    super.dispose();
  }
}
