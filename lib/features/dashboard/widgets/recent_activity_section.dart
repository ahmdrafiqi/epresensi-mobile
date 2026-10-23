import 'package:e_presensimobile/shared/widgets/activity.dart';
import 'package:e_presensimobile/shared/widgets/activity_card.dart';
import 'package:e_presensimobile/shared/widgets/section_title.dart';
import 'package:flutter/material.dart';

class RecentActivitySection extends StatelessWidget {
  final List<Activity> activities;

  const RecentActivitySection({super.key, required this.activities});

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
          child: SectionTitle(
            title: 'Aktivitas Terbaru',
            actionLabel: 'Lihat Semua',
            onActionTap: () {},
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverList.separated(
            itemCount: activities.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) =>
                ActivityCard(activity: activities[index], onDetailTap: () {}),
          ),
        ),
      ],
    );
  }
}
