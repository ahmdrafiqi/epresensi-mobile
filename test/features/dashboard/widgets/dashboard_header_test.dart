import 'package:e_presensimobile/features/dashboard/widgets/dashboard_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('header menampilkan notifikasi dan tidak melakukan logout', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CustomScrollView(
            slivers: [
              DashboardHeader(
                email: 'user@example.com',
                name: 'Pengguna',
                role: 'karyawan',
              ),
            ],
          ),
        ),
      ),
    );

    expect(find.byIcon(Icons.notifications_none_outlined), findsOneWidget);
    expect(find.byIcon(Icons.logout), findsNothing);

    await tester.tap(find.byTooltip('Notifikasi'));
    await tester.pump();

    expect(find.text('Notifikasi belum tersedia.'), findsOneWidget);
  });
}
