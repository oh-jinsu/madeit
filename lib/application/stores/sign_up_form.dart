import 'dart:convert';

import 'package:antenna/antenna.dart';
import 'package:madeit/application/events/sign_up_avatar_found.dart';
import 'package:madeit/application/events/sign_up_canceled.dart';
import 'package:madeit/application/events/sign_up_finished.dart';
import 'package:madeit/application/events/sign_up_name_changed.dart';
import 'package:madeit/application/events/sign_up_pending.dart';
import 'package:madeit/application/events/sign_up_privacy_agreement_changed.dart';
import 'package:madeit/application/events/sign_up_service_agreement_changed.dart';
import 'package:madeit/application/models/option.dart';
import 'package:madeit/application/models/sign_up_form.dart';

final signUpFormStore = createStore<SignUpFormModel>(({
  SignUpFormModel state = const SignUpFormModel(
    avatar: Option(null),
    name: "",
    nameMessage: Option(null),
    isServiceAgreed: false,
    isPrivacyAgreed: false,
    isPending: false,
    isValid: false,
  ),
  dynamic event,
}) {
  if (event is SignUpPending) {
    return state.copy(isPending: true);
  }

  if (event is SignUpCanceled || event is SignUpFinished) {
    return state.copy(isPending: false);
  }

  if (event is SignUpAvatarFound) {
    return state.copy(avatar: Option(event.file));
  }

  if (event is SignUpNameChanged) {
    final copy = state.copy(
      name: event.value,
      isValid: _isValid(
        name: event.value,
        isServiceAgreed: state.isServiceAgreed,
        isPrivacyAgreed: state.isPrivacyAgreed,
      ),
    );

    if (utf8.encode(event.value).length < 6) {
      return copy.copy(nameMessage: const Option("이름이 너무 짧아요."));
    }

    if (utf8.encode(event.value).length > 24) {
      return copy.copy(nameMessage: const Option("이름이 너무 길어요."));
    }

    return copy.copy(nameMessage: const Option(null));
  }

  if (event is SignUpServiceAgreementChanged) {
    return state.copy(
      isServiceAgreed: event.value,
      isValid: _isValid(
        name: state.name,
        isServiceAgreed: event.value,
        isPrivacyAgreed: state.isPrivacyAgreed,
      ),
    );
  }

  if (event is SignUpPrivacyAgreementChanged) {
    return state.copy(
      isPrivacyAgreed: event.value,
      isValid: _isValid(
        name: state.name,
        isServiceAgreed: state.isServiceAgreed,
        isPrivacyAgreed: event.value,
      ),
    );
  }

  return state;
});

bool _isValid({
  required String name,
  required bool isServiceAgreed,
  required bool isPrivacyAgreed,
}) {
  if (name.length < 2) {
    return false;
  }

  if (name.length > 8) {
    return false;
  }

  if (!isServiceAgreed) {
    return false;
  }

  if (!isPrivacyAgreed) {
    return false;
  }

  return true;
}
