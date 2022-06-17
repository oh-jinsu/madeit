import 'package:antenna/antenna.dart';
import 'package:madeit/application/models/user.dart';

final userStore = createStore<UserModel?>(({
  UserModel? state,
  dynamic event,
}) {
  return state;
});
