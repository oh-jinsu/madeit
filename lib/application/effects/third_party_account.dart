import 'package:google_sign_in/google_sign_in.dart';
import 'package:madeit/application/events/sign_in_cancled.dart';
import 'package:madeit/application/events/sign_in_pending.dart';
import 'package:madeit/application/events/third_party_account_found.dart';
import 'package:madeit/application/events/third_party_account_requested.dart';
import 'package:madeit/core/channel.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

void thirdPartyAccountEffect(ThirdPartyAccountRequested event) async {
  switch (event.provider) {
    case "apple":
      dispatch(const SignInPending());

      try {
        final account = await SignInWithApple.getAppleIDCredential(scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ]);

        final idToken = account.identityToken;

        if (idToken == null) {
          throw Exception();
        }

        dispatch(ThirdPartyAccountFound(
          provider: "apple",
          idToken: idToken,
          name: account.givenName,
          email: account.email,
        ));
      } catch (e) {
        dispatch(const SignInCanceled());
      }
      break;
    case "google":
      dispatch(const SignInPending());

      try {
        final account = await GoogleSignIn(scopes: [
          "email",
        ]).signIn();

        if (account == null) {
          throw Exception();
        }

        final authentication = await account.authentication;

        final idToken = authentication.idToken;

        if (idToken == null) {
          return dispatch(const SignInCanceled());
        }

        dispatch(ThirdPartyAccountFound(
          provider: "google",
          idToken: idToken,
          name: account.displayName,
          email: account.email,
        ));
      } catch (e) {
        dispatch(const SignInCanceled());
      }
      break;
  }
}
