import 'package:antenna/antenna.dart';
import 'package:madeit/application/events/sign_out_finished.dart';
import 'package:madeit/application/events/user_found.dart';
import 'package:madeit/application/models/user.dart';

final userStore = createStore<UserModel?>(({
  UserModel? state,
  dynamic event,
}) {
  if (event is UserFound) {
    return event.model;
  }

  if (event is SignOutFinished) {
    return null;
  }

  return state;
});
