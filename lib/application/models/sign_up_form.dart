import 'dart:io';

import 'package:madeit/application/models/option.dart';

class SignUpFormModel {
  final Option<File> avatar;
  final String name;
  final Option<String> nameMessage;
  final bool isServiceAgreed;
  final bool isPrivacyAgreed;
  final bool isPending;
  final bool isValid;

  const SignUpFormModel({
    required this.avatar,
    required this.name,
    required this.nameMessage,
    required this.isServiceAgreed,
    required this.isPrivacyAgreed,
    required this.isPending,
    required this.isValid,
  });

  SignUpFormModel copy({
    Option<File>? avatar,
    String? name,
    Option<String>? nameMessage,
    bool? isServiceAgreed,
    bool? isPrivacyAgreed,
    bool? isPending,
    bool? isValid,
  }) {
    return SignUpFormModel(
      avatar: avatar ?? this.avatar,
      name: name ?? this.name,
      nameMessage: nameMessage ?? this.nameMessage,
      isServiceAgreed: isServiceAgreed ?? this.isServiceAgreed,
      isPrivacyAgreed: isPrivacyAgreed ?? this.isPrivacyAgreed,
      isPending: isPending ?? this.isPending,
      isValid: isValid ?? this.isValid,
    );
  }
}
