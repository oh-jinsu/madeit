import 'package:firebase_core/firebase_core.dart';
import 'package:madeit/application/events/env_loaded.dart';
import 'package:madeit/firebase_options.dart';

void firebaseEffect(dynamic event) async {
  if (event is EnvLoaded) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
