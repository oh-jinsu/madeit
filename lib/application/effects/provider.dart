import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:madeit/application/events/env_loaded.dart';
import 'package:madeit/application/events/provider_injected.dart';
import 'package:madeit/core/channel.dart';
import 'package:madeit/implementation/providers/ws_client/client.dart';
import 'package:madeit/utilities/dependency.dart';

void providerEffect(EnvLoaded env) {
  final host = dotenv.get("DOMAIN_HOST_WS");

  single(WsClient(host));

  dispatch(const ProviderInjected());
}
