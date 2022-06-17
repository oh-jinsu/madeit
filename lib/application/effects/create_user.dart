import 'package:antenna/antenna.dart';
import 'package:madeit/application/events/sign_up_canceled.dart';
import 'package:madeit/application/events/sign_up_finished.dart';
import 'package:madeit/application/events/user_creation_requested.dart';
import 'package:madeit/implementation/providers/http_client/client.dart';
import 'package:madeit/implementation/providers/http_client/response.dart';
import 'package:madeit/implementation/repositories/auth.dart';
import 'package:madeit/utilities/dependency.dart';

void createUser(dynamic event) async {
  if (event is UserCreationRequested) {
    final authRepository = inject<AuthRepository>();

    final accessToken = await authRepository.findAccessToken();

    if (accessToken == null) {
      return dispatch(const SignUpCanceled());
    }

    final avatarId = await () async {
      final file = event.avatar;

      if (file == null) {
        return null;
      }

      final client = inject<HttpClient>();

      final response = await client.auth(accessToken).file(file).post("images");

      if (response is! SuccessResponse) {
        return null;
      }

      return response.body["id"];
    }();

    final client = inject<HttpClient>();

    final response = await client.auth(accessToken).body({
      "avatar_id": avatarId,
      "name": event.name,
    }).post("users/me");

    if (response is! SuccessResponse) {
      return dispatch(const SignUpCanceled());
    }

    dispatch(const SignUpFinished());
  }
}
