import 'package:e_presensimobile/app/theme/app_colors.dart';
import 'package:e_presensimobile/shared/widgets/stat_card.dart';
import 'package:flutter/material.dart';

class AttendanceSummary extends StatelessWidget {
  const AttendanceSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 80,
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.primaryRed,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(24),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.45,
              children: const [
                StatCard(
                  icon: Icons.person_outline,
                  iconColor: Color(0xFFD32F2F),
                  value: '98%',
                  label: 'Rasio Kehadiran',
                ),
                StatCard(
                  icon: Icons.calendar_today_outlined,
                  iconColor: Color(0xFFF57C00),
                  value: '12',
                  label: 'Sisa Cuti Tahunan',
                ),
                StatCard(
                  icon: Icons.access_time,
                  iconColor: Color(0xFF1976D2),
                  value: '8.5h',
                  label: 'Total Lembur',
                ),
                StatCard(
                  icon: Icons.check_circle_outline,
                  iconColor: Color(0xFF388E3C),
                  value: '07.15',
                  label: 'Absen Terakhir',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
