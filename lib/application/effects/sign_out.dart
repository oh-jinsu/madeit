import 'package:antenna/antenna.dart';
import 'package:madeit/application/effects/functions/refresh.dart';
import 'package:madeit/application/effects/functions/retry.dart';
import 'package:madeit/application/effects/functions/with_auth.dart';
import 'package:madeit/application/effects/predicates/typeof.dart';
import 'package:madeit/application/events/sign_out_finished.dart';
import 'package:madeit/application/events/sign_out_pending.dart';
import 'package:madeit/application/events/sign_out_requested.dart';
import 'package:madeit/implementation/providers/http_client/client.dart';
import 'package:madeit/implementation/repositories/auth.dart';
import 'package:madeit/utilities/dependency.dart';

final signOutEffect = when<SignOutRequested>((event) async {
  final repository = inject<AuthRepository>();

  dispatch(const SignOutPending());

  await retry(refresh(
    post("auth/signout", headers: await bearerTokenHeader()),
  ))();

  await repository.deleteAccessToken();

  await repository.deleteRefreshToken();

  dispatch(const SignOutFinished());
});
