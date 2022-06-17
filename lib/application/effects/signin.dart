import 'package:antenna/antenna.dart';
import 'package:madeit/application/events/sign_in_cancled.dart';
import 'package:madeit/application/events/sign_in_finished.dart';
import 'package:madeit/application/events/third_party_account_found.dart';
import 'package:madeit/implementation/providers/http_client/client.dart';
import 'package:madeit/implementation/providers/http_client/response.dart';
import 'package:madeit/implementation/repositories/auth.dart';
import 'package:madeit/main.dart';
import 'package:madeit/utilities/dependency.dart';

void signInEffect(dynamic event) async {
  if (event is ThirdPartyAccountFound) {
    final client = inject<HttpClient>();

    final response = await client.body({
      "id_token": event.idToken,
    }).post("auth/signin?provider=${event.provider}");

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
  }
}
