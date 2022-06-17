import 'package:antenna/antenna.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:madeit/application/effects/predicates/typeof.dart';
import 'package:madeit/application/events/app_started.dart';
import 'package:madeit/application/events/env_loaded.dart';

final envEffect = when<AppStarted>((event) async {
  await dotenv.load();

  dispatch(const EnvLoaded());
});
