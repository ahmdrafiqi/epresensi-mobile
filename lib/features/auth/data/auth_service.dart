import 'dart:async';
import 'dart:convert';

import 'package:e_presensimobile/app/router/app_router.dart';
import 'package:e_presensimobile/features/auth/data/session_store.dart';
import 'package:e_presensimobile/features/auth/models/auth_session.dart';
import 'package:e_presensimobile/shared/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final http.Client? client;
  final SessionStore _sessionStore;

  AuthService({this.client, SessionStore? sessionStore})
    :
      _sessionStore = sessionStore ?? SecureSessionStore();

  Future<AuthSession> login({
    required String email,
    required String password,
  }) async {
    late final http.Response response;

    try {
      final uri = Uri.parse(ApiConstants.login);
      const headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({'email': email, 'password': password});
      final request = client == null
          ? http.post(uri, headers: headers, body: body)
          : client!.post(uri, headers: headers, body: body);
      response = await request.timeout(const Duration(seconds: 15));
    } on StateError catch (error) {
      throw AuthException(error.message);
    } on FormatException {
      throw const AuthException('Alamat API tidak valid.');
    } on TimeoutException {
      throw const AuthException('Koneksi ke server melewati batas waktu.');
    } on http.ClientException {
      throw const AuthException(
        'Tidak dapat terhubung ke server. Periksa koneksi dan alamat API.',
      );
    }

    final isSuccessful =
        response.statusCode >= 200 && response.statusCode < 300;
    late final Map<String, dynamic> payload;

    try {
      final decoded = jsonDecode(response.body);
      if (decoded is! Map<String, dynamic>) {
        throw const FormatException('Response harus berupa object JSON.');
      }
      payload = decoded;
    } on FormatException {
      if (!isSuccessful) {
        throw AuthException(
          'Login gagal. Server mengembalikan status ${response.statusCode}.',
        );
      }
      throw const AuthException(
        'Format response login dari server tidak valid.',
      );
    }

    if (!isSuccessful) {
      throw AuthException(
        _errorMessage(payload) ??
            'Login gagal. Server mengembalikan status ${response.statusCode}.',
      );
    }

    final data = payload['data'];
    final responseData = data is Map<String, dynamic> ? data : payload;
    final nestedUser = payload['user'] ?? responseData['user'];
    final userData =
        nestedUser ?? (responseData.containsKey('id') ? responseData : null);

    if (userData is! Map<String, dynamic>) {
      throw const AuthException(
        'Data user tidak ditemukan pada response login.',
      );
    }

    try {
      final user = UserModel.fromJson(userData);
      final rawToken =
          payload['token'] ??
          payload['access_token'] ??
          responseData['token'] ??
          responseData['access_token'];
      if (rawToken != null && rawToken is! String) {
        throw const FormatException('Token autentikasi harus berupa teks.');
      }

      final token = rawToken is String && rawToken.trim().isNotEmpty
          ? rawToken.trim()
          : null;
      return AuthSession(user: user, token: token);
    } on FormatException {
      throw const AuthException(
        'Format data user dari server tidak lengkap atau tidak valid.',
      );
    }
  }

  Future<void> saveSession(AuthSession session) async {
    try {
      await _sessionStore.writeSession(session);
    } on Exception {
      throw const AuthException(
        'Sesi tidak dapat disimpan dengan aman di perangkat.',
      );
    }
  }

  Future<AuthSession?> restoreSession() async {
    try {
      final session = await _sessionStore.readSession();
      if (session?.token == null || session!.token!.isEmpty) {
        if (session != null) await _sessionStore.clearSession();
        return null;
      }
      return session;
    } on Exception {
      throw const AuthException(
        'Sesi tersimpan tidak dapat dibaca. Silakan masuk kembali.',
      );
    }
  }

  Future<String?> readRememberedEmail() async {
    try {
      return await _sessionStore.readRememberedEmail();
    } on Exception {
      throw const AuthException(
        'Email tersimpan tidak dapat dibaca dari perangkat.',
      );
    }
  }

  Future<void> saveRememberedEmail(String? email) async {
    try {
      await _sessionStore.writeRememberedEmail(email);
    } on Exception {
      throw const AuthException(
        'Preferensi email tidak dapat disimpan di perangkat.',
      );
    }
  }

  Future<String?> logout() async {
    AuthSession? session;
    try {
      session = await _sessionStore.readSession();
    } on Exception {
      throw const AuthException(
        'Sesi lokal tidak dapat dibaca untuk proses keluar.',
      );
    }

    AuthException? requestError;
    if (session?.token != null) {
      try {
        final uri = Uri.parse(ApiConstants.logout);
        final headers = {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${session!.token}',
        };
        final request = client == null
            ? http.post(uri, headers: headers)
            : client!.post(uri, headers: headers);
        final response = await request.timeout(const Duration(seconds: 15));
        if (response.statusCode < 200 || response.statusCode >= 300) {
          requestError = AuthException(
            'Logout server gagal dengan status ${response.statusCode}.',
          );
        }
      } on StateError catch (error) {
        requestError = AuthException(error.message);
      } on TimeoutException {
        requestError = const AuthException(
          'Koneksi logout ke server melewati batas waktu.',
        );
      } on http.ClientException {
        requestError = const AuthException(
          'Tidak dapat menghubungi server untuk logout.',
        );
      } on FormatException {
        requestError = const AuthException('Alamat API tidak valid.');
      }
    }

    try {
      await _sessionStore.clearSession();
    } on Exception {
      throw const AuthException(
        'Sesi gagal dihapus dari perangkat. Coba keluar kembali.',
      );
    }

    return requestError?.message;
  }

  String? _errorMessage(Map<String, dynamic> payload) {
    final message = payload['message'];
    if (message is String && message.trim().isNotEmpty) {
      return message;
    }

    final errors = payload['errors'];
    if (errors is Map<String, dynamic>) {
      for (final value in errors.values) {
        if (value is List && value.isNotEmpty && value.first is String) {
          return value.first as String;
        }
      }
    }
    return null;
  }
}

class AuthException implements Exception {
  final String message;

  const AuthException(this.message);

  @override
  String toString() => message;
}
