import 'dart:async';

import 'package:flutter/material.dart';
import 'package:madeit/application/events/sign_up_avatar_requested.dart';
import 'package:madeit/application/events/sign_up_finished.dart';
import 'package:madeit/application/events/sign_up_name_changed.dart';
import 'package:madeit/application/events/sign_up_privacy_agreement_changed.dart';
import 'package:madeit/application/events/sign_up_service_agreement_changed.dart';
import 'package:madeit/application/events/sign_up_submitted.dart';
import 'package:madeit/application/models/sign_up_form.dart';
import 'package:madeit/application/reducers/sign_up_form.dart';
import 'package:madeit/composition/common/properties/text_style.dart';
import 'package:madeit/composition/common/widgets/avatar.dart';
import 'package:madeit/composition/signup/widgets/radio_box.dart';
import 'package:madeit/composition/signup/widgets/row.dart';
import 'package:madeit/core/channel.dart';
import 'package:madeit/core/manager.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUpPage extends StatefulWidget {
  final String? name;
  final String? email;
  final String provider;
  final String idToken;

  const SignUpPage({
    Key? key,
    required this.name,
    required this.email,
    required this.provider,
    required this.idToken,
  }) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with SubscriptionManagerMixin {
  final subscriptions = <StreamSubscription>[];

  final nameFocusNode = FocusNode();

  @override
  void initState() {
    open(signUpFormStore);

    on((SignUpFinished event) {
      Navigator.of(context).pop();
    });

    if (widget.name != null) {
      dispatch(SignUpNameChanged(widget.name!));
    }

    super.initState();
  }

  @override
  void dispose() {
    nameFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        nameFocusNode.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("회원가입"),
          centerTitle: true,
        ),
        body: watch(signUpFormStore)(
          (value) => Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24.0),
                      Center(
                        child: GestureDetector(
                          onTap: () => dispatch(const SignUpAvatarRequested()),
                          child: Stack(
                            children: [
                              Avatar(
                                image: value.avatar.value != null
                                    ? FileImage(value.avatar.value!)
                                    : null,
                                radius: 40.0,
                              ),
                              Positioned.fill(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(40.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        height: 16.0,
                                        color: Colors.black,
                                        child: const Center(
                                          child: Text(
                                            "편집",
                                            style: TextStyle(
                                              fontSize: 11.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      const Padding(
                        padding: EdgeInsets.only(left: 20.0, bottom: 12.0),
                        child: Text(
                          "필수",
                          style: CaptionTextStyle(),
                        ),
                      ),
                      const Divider(),
                      SignUpRow(
                        preffix: Icon(
                          Icons.person,
                          color: Colors.grey[400],
                        ),
                        body: TextFormField(
                          focusNode: nameFocusNode,
                          onChanged: (value) => dispatch(
                            SignUpNameChanged(value),
                          ),
                          autofocus: widget.name == null,
                          initialValue: widget.name,
                          style: const TextStyle(
                            fontSize: 14.0,
                          ),
                          decoration: const InputDecoration(
                            hintText: "이름",
                            isDense: true,
                            contentPadding: EdgeInsets.all(0.0),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const Divider(),
                      if (value.nameMessage.value != null)
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 4.0,
                            left: 16.0,
                          ),
                          child: Text(
                            value.nameMessage.value!,
                            style: CaptionTextStyle(
                                color: Theme.of(context).colorScheme.error),
                          ),
                        ),
                      const SizedBox(height: 32.0),
                      const Padding(
                        padding: EdgeInsets.only(left: 20.0, bottom: 12.0),
                        child: Text(
                          "동의",
                          style: CaptionTextStyle(),
                        ),
                      ),
                      const Divider(),
                      SignUpRow(
                        onTap: () {
                          if (value.isPending) {
                            return;
                          }

                          dispatch(
                            SignUpServiceAgreementChanged(
                              !value.isServiceAgreed,
                            ),
                          );
                        },
                        preffix: SignUpRadioBox(
                          enabled: value.isServiceAgreed,
                        ),
                        body: const Text(
                          "서비스이용약관",
                          style: BodyTextStyle(),
                        ),
                        suffix: InkWell(
                          onTap: () {
                            final url = Uri.parse(
                              "https://madeit.develife.kr/service",
                            );

                            launchUrl(url);
                          },
                          borderRadius: BorderRadius.circular(16.0),
                          child: Icon(
                            Icons.chevron_right,
                            color: Colors.grey[400],
                          ),
                        ),
                      ),
                      const Divider(),
                      SignUpRow(
                        onTap: () {
                          if (value.isPending) {
                            return;
                          }

                          dispatch(
                            SignUpPrivacyAgreementChanged(
                              !value.isPrivacyAgreed,
                            ),
                          );
                        },
                        preffix: SignUpRadioBox(
                          enabled: value.isPrivacyAgreed,
                        ),
                        body: const Text(
                          "개인정보처리방침",
                          style: BodyTextStyle(),
                        ),
                        suffix: InkWell(
                          onTap: () {
                            final url = Uri.parse(
                              "https://madeit.develife.kr/privacy",
                            );

                            launchUrl(url);
                          },
                          borderRadius: BorderRadius.circular(16.0),
                          child: Icon(
                            Icons.chevron_right,
                            color: Colors.grey[400],
                          ),
                        ),
                      ),
                      const Divider(),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 4.0,
                  horizontal: 20.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey[200]!,
                    ),
                  ),
                ),
                child: SafeArea(
                  child: ElevatedButton(
                    onPressed: () {
                      if (value.isPending || !value.isValid) {
                        return;
                      }

                      dispatch(
                        SignUpSubmitted(
                          provider: widget.provider,
                          idToken: widget.idToken,
                          avatar: value.avatar.value,
                          name: value.name,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: value.isValid ? null : Colors.grey[400],
                      minimumSize: const Size.fromHeight(44.0),
                    ),
                    child: value.isPending
                        ? const SizedBox(
                            width: 16.0,
                            height: 16.0,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            "가입하기",
                          ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
