import 'dart:async';
import 'dart:convert';

import 'package:e_presensimobile/app/router/app_router.dart';
import 'package:e_presensimobile/shared/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final http.Client? client;

  AuthService({this.client});

  Future<UserModel> login({
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
      return UserModel.fromJson(userData);
    } on FormatException {
      throw const AuthException(
        'Format data user dari server tidak lengkap atau tidak valid.',
      );
    }
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
