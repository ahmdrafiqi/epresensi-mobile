import 'package:e_presensimobile/features/profile/views/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('menampilkan profil dan menu akun', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ProfilePage(
            email: 'budi@example.com',
            name: 'Budi Santoso',
            role: 'karyawan',
            onLogout: () {},
          ),
        ),
      ),
    );

    expect(find.text('Profile'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back), findsNothing);
    expect(find.text('Budi Santoso'), findsOneWidget);
    expect(find.text('budi@example.com'), findsOneWidget);
    expect(find.text('Karyawan'), findsNWidgets(2));
    expect(find.text('Belum tersedia'), findsOneWidget);
    expect(find.text('Ubah Password'), findsOneWidget);
    expect(find.text('Kebijakan Privasi'), findsOneWidget);
    expect(find.text('Keluar'), findsOneWidget);
  });

  testWidgets('menu yang belum tersedia memberi keterangan', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ProfilePage(
            email: 'budi@example.com',
            name: 'Budi Santoso',
            role: 'karyawan',
            onLogout: () {},
          ),
        ),
      ),
    );

    await tester.tap(find.text('Ubah Password'));
    await tester.pumpAndSettle();

    expect(
      find.text('Ubah Password belum tersedia di aplikasi.'),
      findsOneWidget,
    );
  });
}
