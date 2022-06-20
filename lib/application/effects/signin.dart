import 'package:antenna/antenna.dart';
import 'package:madeit/application/effects/functions/protect.dart';
import 'package:madeit/application/effects/predicates/typeof.dart';
import 'package:madeit/application/events/sign_in_cancled.dart';
import 'package:madeit/application/events/sign_in_finished.dart';
import 'package:madeit/application/events/third_party_account_found.dart';
import 'package:madeit/implementation/providers/http_client/client.dart';
import 'package:madeit/implementation/providers/http_client/response.dart';
import 'package:madeit/implementation/repositories/auth.dart';
import 'package:madeit/main.dart';
import 'package:madeit/utilities/dependency.dart';

final signInEffect = when<ThirdPartyAccountFound>((event) async {
  final response = await retry(
    () => post(
      "auth/signin?provider=${event.provider}",
      body: {
        "id_token": event.idToken,
      },
    ),
  );

  if (response is FailureResponse) {
    if (response.code == 2) {
      requireNavigator.pushReplacementNamed("/signup", arguments: {
        "provider": event.provider,
        "name": event.name,
        "email": event.email,
        "id_token": event.idToken,
      });
    }

    dispatch(const SignInCanceled());

    return;
  }

  if (response is! SuccessResponse) {
    dispatch(const SignInCanceled());

    return;
  }

  final accessToken = response.body["access_token"];

  final refreshToken = response.body["refresh_token"];

  final repository = inject<AuthRepository>();

  await repository.saveAccessToken(accessToken);

  await repository.saveRefreshToken(refreshToken);

  dispatch(const SignInFinished());
});
