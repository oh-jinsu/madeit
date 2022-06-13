import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:madeit/application/events/app_started.dart';
import 'package:madeit/application/events/env_loaded.dart';
import 'package:madeit/core/channel.dart';

void envEffect(AppStarted event) async {
  await dotenv.load();

  dispatch(const EnvLoaded());
}
