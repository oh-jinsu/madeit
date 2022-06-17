import 'package:antenna/antenna.dart';
import 'package:madeit/application/events/sign_in_cancled.dart';
import 'package:madeit/application/events/sign_in_finished.dart';
import 'package:madeit/application/events/sign_in_pending.dart';

final signInFormStore = createStore<bool>(({
  bool state = true,
  dynamic event,
}) {
  if (event is SignInPending) {
    return false;
  }

  if (event is SignInCanceled || event is SignInFinished) {
    return true;
  }

  return state;
});
