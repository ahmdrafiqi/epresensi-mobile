import 'package:e_presensimobile/shared/widgets/activity.dart';
import 'package:e_presensimobile/shared/widgets/activity_card.dart';
import 'package:e_presensimobile/shared/widgets/section_title.dart';
import 'package:flutter/material.dart';

class RecentActivitySection extends StatelessWidget {
  final List<Activity> activities;
  final VoidCallback onSeeAllTap;

  const RecentActivitySection({
    super.key,
    required this.activities,
    required this.onSeeAllTap,
  });

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
          child: SectionTitle(
            title: 'Aktivitas Terbaru',
            actionLabel: 'Lihat Semua',
            onActionTap: onSeeAllTap,
          ),
        ),
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Text(
              'DATA CONTOH',
              style: TextStyle(fontSize: 11, color: Color(0xFF757575)),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverList.separated(
            itemCount: activities.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) =>
                ActivityCard(activity: activities[index]),
          ),
        ),
      ],
    );
  }
}
