import 'package:antenna/antenna.dart';
import 'package:madeit/application/effects/functions/refresh.dart';
import 'package:madeit/application/effects/functions/retry.dart';
import 'package:madeit/application/effects/functions/with_auth.dart';
import 'package:madeit/application/events/sign_in_finished.dart';
import 'package:madeit/application/events/sign_up_finished.dart';
import 'package:madeit/application/events/user_found.dart';
import 'package:madeit/application/models/user.dart';
import 'package:madeit/implementation/providers/http_client/client.dart';
import 'package:madeit/implementation/providers/http_client/response.dart';

findUserEffect(dynamic event) {
  if (event is SignUpFinished) {
    _findUser();
  }

  if (event is SignInFinished) {
    _findUser();
  }
}

_findUser() async {
  final response = await retry(
    refresh(get("users/me", headers: await bearerTokenHeader())),
  )();

  if (response is! SuccessResponse) {
    return;
  }

  final model = UserModel.fromJson(response.body);

  dispatch(UserFound(model));
}
