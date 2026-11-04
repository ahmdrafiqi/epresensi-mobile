import 'dart:convert';

import 'package:e_presensimobile/app/router/app_router.dart';
import 'package:e_presensimobile/features/auth/data/auth_service.dart';
import 'package:e_presensimobile/features/auth/data/session_store.dart';
import 'package:e_presensimobile/features/auth/models/auth_session.dart';
import 'package:e_presensimobile/shared/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

class _MemorySessionStore implements SessionStore {
  AuthSession? session;
  String? rememberedEmail;

  @override
  Future<AuthSession?> readSession() async => session;

  @override
  Future<void> writeSession(AuthSession value) async => session = value;

  @override
  Future<void> clearSession() async => session = null;

  @override
  Future<String?> readRememberedEmail() async => rememberedEmail;

  @override
  Future<void> writeRememberedEmail(String? value) async =>
      rememberedEmail = value;
}

AuthSession _session() => const AuthSession(
  user: UserModel(
    id: 7,
    name: 'Pengguna',
    email: 'user@example.com',
    role: 'karyawan',
  ),
  token: 'secret-token',
);

void main() {
  test('restoreSession reads the saved user and token', () async {
    final store = _MemorySessionStore()..session = _session();
    final authService = AuthService(sessionStore: store);

    final restored = await authService.restoreSession();

    expect(restored?.user.email, 'user@example.com');
    expect(restored?.token, 'secret-token');
  });

  test('logout sends bearer token and clears local session', () async {
    final store = _MemorySessionStore()..session = _session();
    final client = MockClient((request) async {
      expect(request.method, 'POST');
      expect(request.url.toString(), ApiConstants.logout);
      expect(request.headers['authorization'], 'Bearer secret-token');
      return http.Response('', 204);
    });
    final authService = AuthService(client: client, sessionStore: store);

    final warning = await authService.logout();

    expect(warning, isNull);
    expect(store.session, isNull);
  });

  test('logout clears local session when server request fails', () async {
    final store = _MemorySessionStore()..session = _session();
    final client = MockClient((_) async => http.Response('', 503));
    final authService = AuthService(client: client, sessionStore: store);

    final warning = await authService.logout();

    expect(warning, contains('status 503'));
    expect(store.session, isNull);
  });

  test('login parses token from an API data payload', () async {
    final client = MockClient((request) async {
      expect(jsonDecode(request.body), {
        'email': 'user@example.com',
        'password': 'password123',
      });
      return http.Response(
        jsonEncode({
          'data': {
            'user': {
              'id': 7,
              'name': 'Pengguna',
              'email': 'user@example.com',
              'role': 'karyawan',
            },
            'access_token': 'api-token',
          },
        }),
        200,
      );
    });
    final authService = AuthService(
      client: client,
      sessionStore: _MemorySessionStore(),
    );

    final session = await authService.login(
      email: 'user@example.com',
      password: 'password123',
    );

    expect(session.token, 'api-token');
    expect(session.user.role, 'karyawan');
  });
}
