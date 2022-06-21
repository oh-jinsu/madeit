import 'package:antenna/antenna.dart';
import 'package:madeit/application/events/user_found.dart';
import 'package:madeit/application/models/user.dart';

final userStore = createStore<UserModel?>(({
  UserModel? state,
  dynamic event,
}) {
  if (event is UserFound) {
    return event.model;
  }

  return state;
});
