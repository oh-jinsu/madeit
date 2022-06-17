import 'package:firebase_core/firebase_core.dart';
import 'package:madeit/application/effects/predicates/typeof.dart';
import 'package:madeit/application/events/env_loaded.dart';
import 'package:madeit/firebase_options.dart';

final firebaseEffect = when<EnvLoaded>((event) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
});
