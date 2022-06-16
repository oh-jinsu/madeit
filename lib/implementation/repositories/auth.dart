import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthRepository {
  static const _refreshTokenKey = "refresh_token";

  final _storage = const FlutterSecureStorage();

  String? _accessToken;

  Future<String?> findAccessToken() async {
    return _accessToken;
  }

  Future<String> saveAccessToken(String value) async {
    _accessToken = value;

    return _accessToken!;
  }

  Future<void> deleteAccessToken() async {
    _accessToken = null;
  }

  Future<String?> findRefreshToken() async {
    final result = await _storage.read(key: _refreshTokenKey);

    return result;
  }

  Future<void> saveRefreshToken(String value) async {
    await _storage.write(key: _refreshTokenKey, value: value);
  }

  Future<void> deleteRefreshToken() async {
    await _storage.delete(key: _refreshTokenKey);
  }
}
