import 'package:madeit/application/events/sign_up_avatar_found.dart';
import 'package:madeit/application/events/sign_up_canceled.dart';
import 'package:madeit/application/events/sign_up_finished.dart';
import 'package:madeit/application/events/sign_up_name_changed.dart';
import 'package:madeit/application/events/sign_up_pending.dart';
import 'package:madeit/application/events/sign_up_privacy_agreement_changed.dart';
import 'package:madeit/application/events/sign_up_service_agreement_changed.dart';
import 'package:madeit/application/models/option.dart';
import 'package:madeit/application/models/sign_up_form.dart';
import 'package:madeit/core/store.dart';

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

SignUpFormModel? signUpFormReducer({
  SignUpFormModel? state,
  dynamic event,
}) {
  final current = state ??
      const SignUpFormModel(
        avatar: Option(null),
        name: "",
        nameMessage: Option(null),
        isServiceAgreed: false,
        isPrivacyAgreed: false,
        isPending: false,
        isValid: false,
      );

  if (event is SignUpPending) {
    return current.copy(isPending: true);
  }

  if (event is SignUpCanceled || event is SignUpFinished) {
    return current.copy(isPending: false);
  }

  if (event is SignUpAvatarFound) {
    return current.copy(avatar: Option(event.file));
  }

  if (event is SignUpNameChanged) {
    final copy = current.copy(
      name: event.value,
      isValid: _isValid(
        name: event.value,
        isServiceAgreed: current.isServiceAgreed,
        isPrivacyAgreed: current.isPrivacyAgreed,
      ),
    );

    if (event.value.length < 2) {
      return copy.copy(nameMessage: const Option("이름은 두 글자보다 같거나 길어야 해요."));
    }

    if (event.value.length > 8) {
      return copy.copy(nameMessage: const Option("이름은 두 글자보다 같거나 길어야 해요."));
    }

    return copy.copy(nameMessage: const Option(null));
  }

  if (event is SignUpServiceAgreementChanged) {
    return current.copy(
      isServiceAgreed: event.value,
      isValid: _isValid(
        name: current.name,
        isServiceAgreed: event.value,
        isPrivacyAgreed: current.isPrivacyAgreed,
      ),
    );
  }

  if (event is SignUpPrivacyAgreementChanged) {
    return current.copy(
      isPrivacyAgreed: event.value,
      isValid: _isValid(
        name: current.name,
        isServiceAgreed: current.isServiceAgreed,
        isPrivacyAgreed: event.value,
      ),
    );
  }

  return current;
}

final signUpFormStore = createStore(signUpFormReducer);
