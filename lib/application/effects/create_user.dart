import 'package:antenna/antenna.dart';
import 'package:madeit/application/effects/functions/protect.dart';
import 'package:madeit/application/effects/functions/with_auth.dart';
import 'package:madeit/application/effects/predicates/typeof.dart';
import 'package:madeit/application/events/sign_up_canceled.dart';
import 'package:madeit/application/events/sign_up_finished.dart';
import 'package:madeit/application/events/user_creation_requested.dart';
import 'package:madeit/implementation/providers/http_client/client.dart';
import 'package:madeit/implementation/providers/http_client/response.dart';

final createUser = when<UserCreationRequested>((event) async {
  final avatarId = await () async {
    final file = event.avatar;

    if (file == null) {
      return null;
    }

    final response = await retry(
      () async => multipart(
        "images",
        file: file,
        headers: await bearerTokenHeader(),
      ),
    );

    if (response is! SuccessResponse) {
      return null;
    }

    return response.body["id"];
  }();

  final response = await retry(
    () async => post(
      "users/me",
      headers: await bearerTokenHeader(),
      body: {
        "avatar_id": avatarId,
        "name": event.name,
      },
    ),
  );

  if (response is! SuccessResponse) {
    return dispatch(const SignUpCanceled());
  }

  dispatch(const SignUpFinished());
});
