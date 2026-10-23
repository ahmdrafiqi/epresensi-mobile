import 'package:e_presensimobile/shared/widgets/quick_access_button.dart';
import 'package:e_presensimobile/shared/widgets/section_title.dart';
import 'package:flutter/material.dart';

class QuickAccessSection extends StatelessWidget {
  const QuickAccessSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          const SectionTitle(title: 'Akses Cepat'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 2.6,
              children: [
                QuickAccessButton(
                  icon: Icons.login,
                  label: 'Absen\nMasuk',
                  onTap: () {},
                ),
                QuickAccessButton(
                  icon: Icons.logout,
                  label: 'Absen\nPulang',
                  onTap: () {},
                ),
                QuickAccessButton(
                  icon: Icons.event_note_outlined,
                  label: 'Ajukan\nCuti',
                  onTap: () {},
                ),
                QuickAccessButton(
                  icon: Icons.more_time,
                  label: 'Ajukan\nLembur',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
