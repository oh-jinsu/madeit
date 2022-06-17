import 'package:flutter/material.dart';
import 'package:madeit/core/store.dart';

StreamBuilder<K> Function(
  Widget Function(K value) onNext, {
  Widget Function(Object? error)? onError,
}) watch<K>(StoreApi<K> store) {
  return (
    Widget Function(K value) onNext, {
    Widget Function(Object? error)? onError,
  }) {
    return StreamBuilder<K>(
      stream: store.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData || null is K) {
          final data = snapshot.data as K;

          return onNext(data);
        }

        return onError?.call(snapshot.error) ?? const SizedBox();
      },
    );
  };
}
