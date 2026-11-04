import 'package:e_presensimobile/features/dashboard/widgets/lazy_dashboard_tab_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('tabs dibuat saat dipilih dan mempertahankan state', (
    tester,
  ) async {
    var firstTabBuilds = 0;
    var secondTabBuilds = 0;
    var selectedIndex = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: StatefulBuilder(
          builder: (context, setState) => Scaffold(
            body: LazyDashboardTabStack(
              index: selectedIndex,
              pageBuilders: [
                (_) {
                  firstTabBuilds++;
                  return const TextField(key: ValueKey('first-tab'));
                },
                (_) {
                  secondTabBuilds++;
                  return const TextField(key: ValueKey('second-tab'));
                },
              ],
            ),
            bottomNavigationBar: NavigationBar(
              selectedIndex: selectedIndex,
              onDestinationSelected: (index) {
                setState(() => selectedIndex = index);
              },
              destinations: const [
                NavigationDestination(icon: Icon(Icons.home), label: 'Tab 1'),
                NavigationDestination(icon: Icon(Icons.person), label: 'Tab 2'),
              ],
            ),
          ),
        ),
      ),
    );

    expect(firstTabBuilds, 1);
    expect(secondTabBuilds, 0);

    await tester.tap(find.text('Tab 2'));
    await tester.pumpAndSettle();
    expect(secondTabBuilds, 1);
    await tester.enterText(find.byKey(const ValueKey('second-tab')), 'Draft');

    await tester.tap(find.text('Tab 1'));
    await tester.pumpAndSettle();
    expect(firstTabBuilds, 1);

    await tester.tap(find.text('Tab 2'));
    await tester.pumpAndSettle();
    expect(secondTabBuilds, 1);
    expect(find.text('Draft'), findsOneWidget);
  });

  testWidgets('mengosongkan tab tersimpan saat identitas akun berubah', (
    tester,
  ) async {
    var account = 'first@example.com';

    await tester.pumpWidget(
      MaterialApp(
        home: StatefulBuilder(
          builder: (context, setState) => Scaffold(
            body: Column(
              children: [
                TextButton(
                  onPressed: () =>
                      setState(() => account = 'second@example.com'),
                  child: const Text('Ganti akun'),
                ),
                Expanded(
                  child: LazyDashboardTabStack(
                    index: 0,
                    cacheKey: account,
                    pageBuilders: [
                      (_) => Text('Data $account'),
                      (_) => const Text('Tab lain'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    expect(find.text('Data first@example.com'), findsOneWidget);
    await tester.tap(find.text('Ganti akun'));
    await tester.pumpAndSettle();

    expect(find.text('Data second@example.com'), findsOneWidget);
  });
}
