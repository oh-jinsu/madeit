import 'package:antenna/antenna.dart';
import 'package:madeit/application/effects/functions/protect.dart';
import 'package:madeit/application/effects/predicates/typeof.dart';
import 'package:madeit/application/events/provider_injected.dart';
import 'package:madeit/application/events/sign_in_cancled.dart';
import 'package:madeit/application/events/sign_in_finished.dart';
import 'package:madeit/application/events/sign_in_pending.dart';
import 'package:madeit/implementation/providers/http_client/client.dart';
import 'package:madeit/implementation/providers/http_client/response.dart';
import 'package:madeit/implementation/repositories/auth.dart';
import 'package:madeit/utilities/dependency.dart';

final autoSignInEffect = when<ProviderInjected>((event) async {
  final repository = inject<AuthRepository>();

  final refreshToken = await repository.findRefreshToken();

  if (refreshToken == null) {
    return;
  }

  dispatch(const SignInPending());

  final response = await retry(
    () => post(
      "auth/refresh",
      body: {
        "refresh_token": refreshToken,
      },
    ),
  );

  if (response is! SuccessResponse) {
    return dispatch(const SignInCanceled());
  }

  final accessToken = response.body["access_token"];

  await repository.saveAccessToken(accessToken);

  dispatch(const SignInFinished());
});
