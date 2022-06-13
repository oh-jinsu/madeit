import 'package:madeit/application/events/provider_injected.dart';
import 'package:madeit/application/events/ws_connected.dart';
import 'package:madeit/application/events/ws_disconnected.dart';
import 'package:madeit/core/channel.dart';
import 'package:madeit/implementation/providers/ws_client/client.dart';
import 'package:madeit/utilities/dependency.dart';

void wsEffect(ProviderInjected event) {
  final client = inject<WsClient>();

  client.onConnect((_) {
    dispatch(const WsConnected());
  });

  client.onDisconnect((_) {
    dispatch(const WsDisconnected());
  });

  client.connect();
}
