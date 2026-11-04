import 'package:e_presensimobile/features/dashboard/views/dashboard_karyawan.dart';
import 'package:e_presensimobile/features/dashboard/views/dashboard_manager.dart';
import 'package:e_presensimobile/features/dashboard/views/dashboard_pengawas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> _expectTabPage(
  WidgetTester tester, {
  required Widget dashboard,
  required String destination,
  required String pageTitle,
}) async {
  await tester.pumpWidget(MaterialApp(home: dashboard));

  await tester.tap(
    find.descendant(
      of: find.byType(NavigationBar),
      matching: find.text(destination),
    ),
  );
  await tester.pumpAndSettle();

  expect(find.text('Ini halaman $pageTitle'), findsOneWidget);

  await tester.tap(
    find.descendant(
      of: find.byType(NavigationBar),
      matching: find.text('Beranda'),
    ),
  );
  await tester.pumpAndSettle();
  expect(find.text('Selamat Datang,'), findsOneWidget);
}

void main() {
  testWidgets('navbar karyawan membuka halaman setiap tab', (tester) async {
    const dashboard = DashboardKaryawan(
      email: 'karyawan@example.com',
      name: 'Karyawan',
      role: 'karyawan',
    );

    await _expectTabPage(
      tester,
      dashboard: dashboard,
      destination: 'Presensi',
      pageTitle: 'Presensi',
    );
    await _expectTabPage(
      tester,
      dashboard: dashboard,
      destination: 'Pengajuan',
      pageTitle: 'Pengajuan',
    );
    await _expectTabPage(
      tester,
      dashboard: dashboard,
      destination: 'Riwayat',
      pageTitle: 'Riwayat',
    );

    await tester.pumpWidget(MaterialApp(home: dashboard));
    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Profil'),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Ubah Password'), findsOneWidget);
  });

  testWidgets('navbar manager membuka halaman setiap tab', (tester) async {
    const dashboard = DashboardManager(
      email: 'manager@example.com',
      name: 'Manager',
      role: 'manager',
    );

    await _expectTabPage(
      tester,
      dashboard: dashboard,
      destination: 'Presensi',
      pageTitle: 'Presensi',
    );
    await _expectTabPage(
      tester,
      dashboard: dashboard,
      destination: 'Pengajuan',
      pageTitle: 'Pengajuan',
    );

    await tester.pumpWidget(MaterialApp(home: dashboard));
    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Profil'),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Ubah Password'), findsOneWidget);
  });

  testWidgets('navbar pengawas membuka halaman setiap tab', (tester) async {
    const dashboard = DashboardPengawas(
      email: 'pengawas@example.com',
      name: 'Pengawas',
      role: 'pengawas',
    );

    await _expectTabPage(
      tester,
      dashboard: dashboard,
      destination: 'Presensi',
      pageTitle: 'Presensi',
    );
    await _expectTabPage(
      tester,
      dashboard: dashboard,
      destination: 'Approval',
      pageTitle: 'Approval',
    );

    await tester.pumpWidget(MaterialApp(home: dashboard));
    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Profil'),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Ubah Password'), findsOneWidget);
  });
}
