import 'dart:async';

import 'package:flutter/material.dart';
import 'package:madeit/core/store.dart' as store_api;
import 'package:madeit/core/effect.dart' as effect_api;

mixin SubscriptionManagerMixin<T extends StatefulWidget> on State<T> {
  final _subscriptions = <StreamSubscription>[];

  void open(store_api.StoreApi store) {
    final subscription = store_api.open(store);

    _subscriptions.add(subscription);
  }

  @protected
  void on<K>(effect_api.Effect<K> effect) {
    final subscription = effect_api.on(effect);

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
