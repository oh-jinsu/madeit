import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:madeit/application/events/third_party_account_requested.dart';
import 'package:madeit/application/reducers/sign_in_form.dart';
import 'package:madeit/core/channel.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shape: const Border(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
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
            const Spacer(flex: 3),
            StreamBuilder<bool?>(
              stream: signInFormStore,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data;

                  return Column(
                    children: [
                      if (Platform.isIOS) ...[
                        Center(
                          child: SignInButton(
                            Buttons.AppleDark,
                            onPressed: () {
                              if (data != true) {
                                return;
                              }

                              dispatch(
                                const ThirdPartyAccountRequested("apple"),
                              );
                            },
                            text: "Apple로 로그인",
                          ),
                        ),
                      ],
                      const SizedBox(height: 4.0),
                      Center(
                        child: SignInButton(
                          Buttons.GoogleDark,
                          onPressed: () {
                            if (data != true) {
                              return;
                            }

                            dispatch(
                              const ThirdPartyAccountRequested("google"),
                            );
                          },
                          text: "Google로 로그인",
                        ),
                      ),
                    ],
                  );
                }

                return const SizedBox();
              },
            ),
            const Spacer(flex: 5),
          ],
        ),
      ),
    );
  }
}
