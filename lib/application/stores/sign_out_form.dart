import 'package:antenna/antenna.dart';
import 'package:madeit/application/events/sign_out_finished.dart';
import 'package:madeit/application/events/sign_out_pending.dart';

final signOutFormStore = createStore<bool>(({
  bool state = true,
  dynamic event,
}) {
  if (event is SignOutPending) {
    return false;
  }

  if (event is SignOutFinished) {
    return true;
  }

  return state;
});
