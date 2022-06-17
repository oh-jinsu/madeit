import 'package:antenna/antenna.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:madeit/application/events/app_started.dart';
import 'package:madeit/application/events/env_loaded.dart';

void envEffect(dynamic event) async {
  if (event is AppStarted) {
    await dotenv.load();

    dispatch(const EnvLoaded());
  }
}
