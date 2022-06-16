import 'dart:io';

class SignUpSubmitted {
  final String provider;
  final String idToken;
  final File? avatar;
  final String name;

  const SignUpSubmitted({
    required this.provider,
    required this.idToken,
    required this.avatar,
    required this.name,
  });
}
