import 'dart:io';

import 'package:antenna/antenna.dart';
import 'package:flutter/material.dart';
import 'package:madeit/application/events/third_party_account_requested.dart';
import 'package:madeit/application/events/user_found.dart';
import 'package:madeit/application/stores/sign_in_form.dart';
import 'package:madeit/composition/signin/widget/signin_button_apple.dart';
import 'package:madeit/composition/signin/widget/signin_button_google.dart';
import 'package:madeit/composition/signin/widget/signin_button_kakao.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with AntennaManager {
  @override
  void initState() {
    on((event) {
      if (event is UserFound) {
        Navigator.of(context).pop();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shape: const Border(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 28.0,
            vertical: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  children: [
                    const TextSpan(text: "로그인 하시고\n많은 "),
                    TextSpan(
                      text: "사람들",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const TextSpan(text: "의\n"),
                    TextSpan(
                      text: "응원",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const TextSpan(text: " 속에서\n즐겁게 "),
                    TextSpan(
                      text: "루틴",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const TextSpan(text: "을\n도전해 보세요!"),
                  ],
                ),
              ),
              const Spacer(),
              Column(
                children: [
                  if (Platform.isIOS) ...[
                    SignInButtonApple(
                      onTap: () {
                        if (!signInFormStore.state) {
                          return;
                        }

                        dispatch(
                          const ThirdPartyAccountRequested("apple"),
                        );
                      },
                    ),
                    const SizedBox(height: 12.0),
                  ],
                  SignInButtonGoogle(
                    onTap: () {
                      if (!signInFormStore.state) {
                        return;
                      }

                      dispatch(
                        const ThirdPartyAccountRequested("google"),
                      );
                    },
                  ),
                  const SizedBox(height: 12.0),
                  SignInButtonKakao(
                    onTap: () {
                      if (!signInFormStore.state) {
                        return;
                      }

                      dispatch(
                        const ThirdPartyAccountRequested("kakao"),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
