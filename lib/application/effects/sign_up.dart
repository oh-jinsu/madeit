import 'package:antenna/antenna.dart';
import 'package:madeit/application/effects/predicates/typeof.dart';
import 'package:madeit/application/events/sign_up_canceled.dart';
import 'package:madeit/application/events/sign_up_pending.dart';
import 'package:madeit/application/events/sign_up_submitted.dart';
import 'package:madeit/application/events/user_creation_requested.dart';
import 'package:madeit/implementation/providers/http_client/client.dart';
import 'package:madeit/implementation/providers/http_client/response.dart';
import 'package:madeit/implementation/repositories/auth.dart';
import 'package:madeit/utilities/dependency.dart';

final signUp = when<SignUpSubmitted>((event) async {
  dispatch(const SignUpPending());

  final client = inject<HttpClient>();

  final response = await client.body({
    "id_token": event.idToken,
  }).post("auth/signup?provider=${event.provider}");

  if (response is! SuccessResponse) {
    dispatch(const SignUpCanceled());
    return;
  }

  final authRepository = inject<AuthRepository>();

  final accessToken = response.body["access_token"];

  final refreshToken = response.body["refresh_token"];

  await authRepository.saveAccessToken(accessToken);

  await authRepository.saveRefreshToken(refreshToken);

  dispatch(UserCreationRequested(
    avatar: event.avatar,
    name: event.name,
  ));
});
