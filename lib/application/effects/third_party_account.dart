import 'package:antenna/antenna.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:madeit/application/effects/predicates/typeof.dart';
import 'package:madeit/application/events/sign_in_cancled.dart';
import 'package:madeit/application/events/sign_in_pending.dart';
import 'package:madeit/application/events/third_party_account_found.dart';
import 'package:madeit/application/events/third_party_account_requested.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

final thirdPartyAccountEffect = when<ThirdPartyAccountRequested>((event) async {
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
    case "kakao":
      dispatch(const SignInPending());

      KakaoSdk.init(
        nativeAppKey: dotenv.get("KAKAO_NATIVE_APP_KEY"),
      );

      try {
        final authorization = await () async {
          if (await isKakaoTalkInstalled()) {
            try {
              return UserApi.instance.loginWithKakaoTalk();
            } catch (e) {
              if (e is PlatformException && e.code == "CANCELED") {
                rethrow;
              }

              return UserApi.instance.loginWithKakaoAccount();
            }
          } else {
            return UserApi.instance.loginWithKakaoAccount();
          }
        }();

        final idToken = authorization.idToken;

        if (idToken == null) {
          return dispatch(const SignInCanceled());
        }

        final user = await UserApi.instance.me();

        dispatch(ThirdPartyAccountFound(
          provider: "kakao",
          idToken: idToken,
          name: user.kakaoAccount?.name,
          email: user.kakaoAccount?.email,
        ));
      } catch (e) {
        dispatch(const SignInCanceled());
      }

      break;
  }
});
