import 'dart:convert';

import 'package:e_presensimobile/app/router/app_router.dart';
import 'package:e_presensimobile/features/auth/data/auth_service.dart';
import 'package:e_presensimobile/features/auth/presentation/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

Future<void> _loginAs(WidgetTester tester, String role) async {
  final client = MockClient((request) async {
    expect(request.method, 'POST');
    expect(request.url.toString(), ApiConstants.login);
    expect(request.headers['content-type'], contains('application/json'));
    expect(jsonDecode(request.body), {
      'email': 'user@example.com',
      'password': 'password123',
    });

    final user = {
      'id': 42,
      'name': 'Pengguna Demo',
      'email': 'user@example.com',
      'role': role,
    };
    final responseBody = role == 'manager'
        ? {'data': user, 'token': 'test-token'}
        : {'user': user, 'token': 'test-token'};

    return http.Response(
      jsonEncode(responseBody),
      200,
      headers: {'content-type': 'application/json'},
    );
  });

  await tester.pumpWidget(
    MaterialApp(
      home: LoginScreen(authService: AuthService(client: client)),
      routes: {
        '/dashboard-karyawan': (_) =>
            const Scaffold(body: Text('Halaman dashboard karyawan')),
        '/dashboard-manager': (_) =>
            const Scaffold(body: Text('Halaman dashboard manager')),
        '/dashboard-pengawas': (_) =>
            const Scaffold(body: Text('Halaman dashboard pengawas')),
      },
    ),
  );

  await tester.enterText(find.byType(TextFormField).at(0), 'user@example.com');
  await tester.enterText(find.byType(TextFormField).at(1), 'password123');
  await tester.tap(find.text('Login'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('login mengarahkan karyawan ke dashboard berdasarkan role API', (
    tester,
  ) async {
    await _loginAs(tester, 'karyawan');

    expect(find.text('Halaman dashboard karyawan'), findsOneWidget);
  });

  testWidgets('login mengarahkan manager ke dashboard berdasarkan role API', (
    tester,
  ) async {
    await _loginAs(tester, 'manager');

    expect(find.text('Halaman dashboard manager'), findsOneWidget);
  });

  testWidgets('login mengarahkan pengawas ke dashboard berdasarkan role API', (
    tester,
  ) async {
    await _loginAs(tester, 'pengawas');

    expect(find.text('Halaman dashboard pengawas'), findsOneWidget);
  });

  testWidgets('menampilkan pesan API saat kredensial ditolak', (tester) async {
    final client = MockClient((_) async {
      return http.Response(
        jsonEncode({'message': 'Email atau password salah'}),
        401,
        headers: {'content-type': 'application/json'},
      );
    });

    await tester.pumpWidget(
      MaterialApp(
        home: LoginScreen(authService: AuthService(client: client)),
      ),
    );

    await tester.enterText(
      find.byType(TextFormField).at(0),
      'user@example.com',
    );
    await tester.enterText(find.byType(TextFormField).at(1), 'wrong-password');
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    expect(find.text('Email atau password salah'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });

  testWidgets('menolak role yang tidak memiliki dashboard', (tester) async {
    final client = MockClient((_) async {
      return http.Response(
        jsonEncode({
          'user': {
            'id': 42,
            'name': 'Pengguna Demo',
            'email': 'user@example.com',
            'role': 'admin',
          },
        }),
        200,
        headers: {'content-type': 'application/json'},
      );
    });

    await tester.pumpWidget(
      MaterialApp(
        home: LoginScreen(authService: AuthService(client: client)),
      ),
    );

    await tester.enterText(
      find.byType(TextFormField).at(0),
      'user@example.com',
    );
    await tester.enterText(find.byType(TextFormField).at(1), 'password123');
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    expect(find.text('Role akun tidak didukung: admin.'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });
}
