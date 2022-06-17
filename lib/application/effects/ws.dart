import 'package:antenna/antenna.dart';
import 'package:madeit/application/events/provider_injected.dart';
import 'package:madeit/application/events/ws_connected.dart';
import 'package:madeit/application/events/ws_disconnected.dart';
import 'package:madeit/implementation/providers/ws_client/client.dart';
import 'package:madeit/utilities/dependency.dart';

void wsEffect(dynamic event) {
  if (event is ProviderInjected) {
    final client = inject<WsClient>();

    client.onConnect((_) {
      dispatch(const WsConnected());
    });

    client.onDisconnect((_) {
      dispatch(const WsDisconnected());
    });

    client.connect();
  }
}
