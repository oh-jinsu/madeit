import 'dart:async';

import 'package:flutter/material.dart';
import 'package:madeit/core/store.dart' as store_api;
import 'package:madeit/core/effect.dart' as effect_api;

mixin SubscriptionManagerMixin<T extends StatefulWidget> on State<T> {
  final _subscriptions = <StreamSubscription>[];

  @protected
  void useStore(store_api.Store store) {
    final subscription = store_api.useStore(store);

    _subscriptions.add(subscription);
  }

  @protected
  void useEffect<K>(effect_api.Effect<K> effect) {
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
