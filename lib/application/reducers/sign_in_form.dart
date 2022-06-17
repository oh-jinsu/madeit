import 'package:madeit/application/events/sign_in_cancled.dart';
import 'package:madeit/application/events/sign_in_finished.dart';
import 'package:madeit/application/events/sign_in_pending.dart';
import 'package:madeit/core/store.dart';

bool signInFormReducer({bool state = true, dynamic event}) {
  if (event is SignInPending) {
    return false;
  }

  if (event is SignInCanceled || event is SignInFinished) {
    return true;
  }

  return state;
}

final signInFormStore = createStore(signInFormReducer);
