import 'package:antenna/antenna.dart';
import 'package:madeit/application/effects/functions/protect.dart';
import 'package:madeit/application/effects/functions/with_auth.dart';
import 'package:madeit/application/effects/predicates/typeof.dart';
import 'package:madeit/application/events/sign_up_canceled.dart';
import 'package:madeit/application/events/sign_up_finished.dart';
import 'package:madeit/application/events/sign_up_pending.dart';
import 'package:madeit/application/events/sign_up_submitted.dart';
import 'package:madeit/implementation/providers/http_client/client.dart';
import 'package:madeit/implementation/providers/http_client/response.dart';
import 'package:madeit/implementation/repositories/auth.dart';
import 'package:madeit/utilities/dependency.dart';

final signUp = when<SignUpSubmitted>((event) async {
  dispatch(const SignUpPending());

  final response = await retry(
    () => post(
      "auth/signup?provider=${event.provider}",
      body: {
        "id_token": event.idToken,
        "name": event.name,
      },
    ),
  );

  if (response is! SuccessResponse) {
    dispatch(const SignUpCanceled());
    return;
  }

  final authRepository = inject<AuthRepository>();

  final accessToken = response.body["access_token"];

  final refreshToken = response.body["refresh_token"];

  await authRepository.saveAccessToken(accessToken);

  await authRepository.saveRefreshToken(refreshToken);

  final avatar = event.avatar;

  if (avatar != null) {
    final response = await retry(
      () async => multipart(
        "images",
        file: avatar,
        headers: await bearerTokenHeader(),
      ),
    );

    if (response is SuccessResponse) {
      final avatarId = response.body["id"];

      await retry(
        () async => patch(
          "users/me",
          body: [
            {
              "op": "replace",
              "path": "/avatar_id",
              "value": avatarId,
            },
          ],
          headers: await bearerTokenHeader(),
        ),
      );
    }
  }

  dispatch(const SignUpFinished());
});
