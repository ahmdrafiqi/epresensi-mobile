import 'dart:convert';

import 'package:e_presensimobile/features/auth/models/auth_session.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract interface class SessionStore {
  Future<AuthSession?> readSession();
  Future<void> writeSession(AuthSession session);
  Future<void> clearSession();
  Future<String?> readRememberedEmail();
  Future<void> writeRememberedEmail(String? email);
}

class SecureSessionStore implements SessionStore {
  static const _sessionKey = 'auth_session';
  static const _rememberedEmailKey = 'remembered_email';

  final FlutterSecureStorage _storage;

  SecureSessionStore({FlutterSecureStorage? storage})
    : _storage = storage ?? const FlutterSecureStorage();

  @override
  Future<AuthSession?> readSession() async {
    final value = await _storage.read(key: _sessionKey);
    if (value == null) return null;

    final decoded = jsonDecode(value);
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('Format sesi autentikasi tidak valid.');
    }
    return AuthSession.fromJson(decoded);
  }

  @override
  Future<void> writeSession(AuthSession session) =>
      _storage.write(key: _sessionKey, value: jsonEncode(session.toJson()));

  @override
  Future<void> clearSession() => _storage.delete(key: _sessionKey);

  @override
  Future<String?> readRememberedEmail() =>
      _storage.read(key: _rememberedEmailKey);

  @override
  Future<void> writeRememberedEmail(String? email) {
    final value = email?.trim();
    if (value == null || value.isEmpty) {
      return _storage.delete(key: _rememberedEmailKey);
    }
    return _storage.write(key: _rememberedEmailKey, value: value);
  }
}
