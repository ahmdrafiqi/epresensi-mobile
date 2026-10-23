import 'package:e_presensimobile/app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ManagerSummary extends StatelessWidget {
  const ManagerSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 64,
            child: Container(color: AppColors.primaryRed),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Expanded(
                  child: _ManagerMetricCard(
                    icon: Icons.pending_actions,
                    iconColor: AppColors.primaryRed,
                    label: 'Final Approval Menunggu',
                    value: '12',
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _ManagerMetricCard(
                    icon: Icons.check_circle_outline,
                    iconColor: Color(0xFF07516B),
                    label: 'Disetujui Hari Ini',
                    value: '8',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ManagerMetricCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  const _ManagerMetricCard({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 132),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border.all(color: const Color(0xFFE7B7B7)),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 22),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF493B3B),
              height: 1.2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 26,
              height: 1,
              fontWeight: FontWeight.bold,
              color: iconColor,
            ),
          ),
        ],
      ),
    );
  }
}
