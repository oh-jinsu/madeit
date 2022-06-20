import 'dart:io';

import 'package:madeit/implementation/repositories/auth.dart';
import 'package:madeit/utilities/dependency.dart';

Future<Map<String, String>> bearerTokenHeader() async {
  final repository = inject<AuthRepository>();

  final accessToken = await repository.findAccessToken();

  return {
    HttpHeaders.authorizationHeader: "Bearer $accessToken",
  };
}
