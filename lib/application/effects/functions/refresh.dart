import 'package:antenna/antenna.dart';
import 'package:madeit/application/events/sign_in_cancled.dart';
import 'package:madeit/application/events/sign_in_finished.dart';
import 'package:madeit/application/events/sign_in_pending.dart';
import 'package:madeit/implementation/providers/http_client/client.dart';
import 'package:madeit/implementation/providers/http_client/response.dart';
import 'package:madeit/implementation/repositories/auth.dart';
import 'package:madeit/utilities/dependency.dart';

Future<Response> Function() refresh<T>(Future<Response> Function() fn) {
  return () async {
    final result = await fn();

    if (result is FailureResponse) {
      if (result.code == 102) {
        final repository = inject<AuthRepository>();

        final refreshToken = await repository.findRefreshToken();

        if (refreshToken == null) {
          return result;
        }

        dispatch(const SignInPending());

        final response = await post(
          "auth/refresh",
          body: {
            "refresh_token": refreshToken,
          },
        )();

        if (response is! SuccessResponse) {
          dispatch(const SignInCanceled());

          return result;
        }

        final accessToken = response.body["access_token"];

        await repository.saveAccessToken(accessToken);

        dispatch(const SignInFinished());

        return fn();
      }
    }

    return result;
  };
}
