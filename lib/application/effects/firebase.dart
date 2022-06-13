import 'package:firebase_core/firebase_core.dart';
import 'package:madeit/application/events/env_loaded.dart';
import 'package:madeit/firebase_options.dart';

void firebaseEffect(EnvLoaded event) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
