import 'dart:async';

import 'package:antenna/antenna.dart';
import 'package:flutter/material.dart';
import 'package:madeit/application/events/sign_up_avatar_requested.dart';
import 'package:madeit/application/events/sign_up_name_changed.dart';
import 'package:madeit/application/events/sign_up_privacy_agreement_changed.dart';
import 'package:madeit/application/events/sign_up_service_agreement_changed.dart';
import 'package:madeit/application/events/sign_up_submitted.dart';
import 'package:madeit/application/events/user_found.dart';
import 'package:madeit/application/stores/sign_up_form.dart';
import 'package:madeit/composition/common/properties/text_style.dart';
import 'package:madeit/composition/common/widgets/avatar.dart';
import 'package:madeit/composition/signup/widgets/radio_box.dart';
import 'package:madeit/composition/signup/widgets/row.dart';
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

class _SignUpPageState extends State<SignUpPage> with AntennaManager {
  final subscriptions = <StreamSubscription>[];

  final nameFocusNode = FocusNode();

  @override
  void initState() {
    open(signUpFormStore);

    sync(signUpFormStore);

    on((event) {
      if (event is UserFound) {
        Navigator.of(context).pop();
      }
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
          title: const Text("????????????"),
          centerTitle: true,
        ),
        body: Column(
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
                              image: signUpFormStore.state.avatar.value != null
                                  ? FileImage(
                                      signUpFormStore.state.avatar.value!)
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
                                          "??????",
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
                        "??????",
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
                          hintText: "??????",
                          isDense: true,
                          contentPadding: EdgeInsets.all(0.0),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const Divider(),
                    if (signUpFormStore.state.nameMessage.value != null)
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 4.0,
                          left: 16.0,
                        ),
                        child: Text(
                          signUpFormStore.state.nameMessage.value!,
                          style: CaptionTextStyle(
                              color: Theme.of(context).colorScheme.error),
                        ),
                      ),
                    const SizedBox(height: 32.0),
                    const Padding(
                      padding: EdgeInsets.only(left: 20.0, bottom: 12.0),
                      child: Text(
                        "??????",
                        style: CaptionTextStyle(),
                      ),
                    ),
                    const Divider(),
                    SignUpRow(
                      onTap: () {
                        if (signUpFormStore.state.isPending) {
                          return;
                        }

                        dispatch(
                          SignUpServiceAgreementChanged(
                            !signUpFormStore.state.isServiceAgreed,
                          ),
                        );
                      },
                      preffix: SignUpRadioBox(
                        enabled: signUpFormStore.state.isServiceAgreed,
                      ),
                      body: const Text(
                        "?????????????????????",
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
                        if (signUpFormStore.state.isPending) {
                          return;
                        }

                        dispatch(
                          SignUpPrivacyAgreementChanged(
                            !signUpFormStore.state.isPrivacyAgreed,
                          ),
                        );
                      },
                      preffix: SignUpRadioBox(
                        enabled: signUpFormStore.state.isPrivacyAgreed,
                      ),
                      body: const Text(
                        "????????????????????????",
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
                    if (signUpFormStore.state.isPending ||
                        !signUpFormStore.state.isValid) {
                      return;
                    }

                    dispatch(
                      SignUpSubmitted(
                        provider: widget.provider,
                        idToken: widget.idToken,
                        avatar: signUpFormStore.state.avatar.value,
                        name: signUpFormStore.state.name,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary:
                        signUpFormStore.state.isValid ? null : Colors.grey[400],
                    minimumSize: const Size.fromHeight(44.0),
                  ),
                  child: signUpFormStore.state.isPending
                      ? const SizedBox(
                          width: 16.0,
                          height: 16.0,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          "????????????",
                        ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
