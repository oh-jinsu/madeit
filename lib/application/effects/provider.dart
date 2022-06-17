import 'package:antenna/antenna.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:madeit/application/events/provider_injected.dart';
import 'package:madeit/application/events/repository_injected.dart';
import 'package:madeit/implementation/providers/http_client/client.dart';
import 'package:madeit/implementation/providers/ws_client/client.dart';
import 'package:madeit/utilities/dependency.dart';

void providerEffect(dynamic event) {
  if (event is RepositoryInjected) {
    single(WsClient(dotenv.get("DOMAIN_HOST_WS")));

    factory(() => HttpClient(dotenv.get("DOMAIN_HOST_HTTP")));

    dispatch(const ProviderInjected());
  }
}
