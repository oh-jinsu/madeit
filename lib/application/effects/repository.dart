import 'package:antenna/antenna.dart';
import 'package:madeit/application/effects/predicates/typeof.dart';
import 'package:madeit/application/events/env_loaded.dart';
import 'package:madeit/application/events/repository_injected.dart';
import 'package:madeit/implementation/repositories/auth.dart';
import 'package:madeit/utilities/dependency.dart';

final repositoryEffect = when<EnvLoaded>((event) {
  single(AuthRepository());

  dispatch(const RepositoryInjected());
});
