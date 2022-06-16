import 'package:madeit/application/models/user.dart';
import 'package:madeit/core/store.dart';

UserModel? userReducer({UserModel? state, dynamic event}) {
  return state;
}

final userStore = createStore(userReducer);
