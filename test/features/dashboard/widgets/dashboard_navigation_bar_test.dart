import 'package:e_presensimobile/features/dashboard/widgets/dashboard_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _buildNavigationBar({
  required String role,
  int currentIndex = 0,
  ValueChanged<int>? onTap,
}) {
  return MaterialApp(
    home: Scaffold(
      bottomNavigationBar: DashboardNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap ?? (_) {},
        role: role,
      ),
    ),
  );
}

void main() {
  testWidgets('karyawan melihat menu navigasi karyawan', (tester) async {
    await tester.pumpWidget(_buildNavigationBar(role: 'karyawan'));

    expect(find.text('Beranda'), findsOneWidget);
    expect(find.text('Presensi'), findsOneWidget);
    expect(find.text('Pengajuan'), findsOneWidget);
    expect(find.text('Riwayat'), findsOneWidget);
    expect(find.text('Approval'), findsNothing);
  });

  testWidgets('manager dan pengawas melihat menu sesuai role', (tester) async {
    await tester.pumpWidget(_buildNavigationBar(role: 'manager'));

    expect(find.text('Pengajuan'), findsOneWidget);
    expect(find.text('Approval'), findsNothing);

    await tester.pumpWidget(_buildNavigationBar(role: ' PENGAWAS '));

    expect(find.text('Approval'), findsOneWidget);
    expect(find.text('Pengajuan'), findsNothing);
  });

  testWidgets('indeks di luar rentang dibatasi dan tap diteruskan', (
    tester,
  ) async {
    var tappedIndex = -1;
    await tester.pumpWidget(
      _buildNavigationBar(
        role: 'karyawan',
        currentIndex: 99,
        onTap: (index) => tappedIndex = index,
      ),
    );

    expect(
      tester.widget<NavigationBar>(find.byType(NavigationBar)).selectedIndex,
      0,
    );

    await tester.tap(find.text('Pengajuan'));
    expect(tappedIndex, 2);
  });
}
