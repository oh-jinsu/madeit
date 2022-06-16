import 'package:madeit/application/events/env_loaded.dart';
import 'package:madeit/application/events/repository_injected.dart';
import 'package:madeit/core/channel.dart';
import 'package:madeit/implementation/repositories/auth.dart';
import 'package:madeit/utilities/dependency.dart';

void repositoryEffect(EnvLoaded event) {
  single(AuthRepository());

  dispatch(const RepositoryInjected());
}
