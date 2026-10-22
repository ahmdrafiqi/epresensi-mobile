import 'package:e_presensimobile/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'activity.dart';

class ActivityCard extends StatelessWidget {
  final Activity activity;
  final VoidCallback onDetailTap;

  const ActivityCard({required this.activity, required this.onDetailTap});

  @override
  Widget build(BuildContext context) {
    final Color statusColor = activity.isLate
        ? const Color(0xFFF57C00)
        : const Color(0xFF388E3C);
    final Color statusBg = activity.isLate
        ? const Color(0xFFFFF3E0)
        : const Color(0xFFE8F5E9);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                activity.isLate
                    ? Icons.warning_amber_rounded
                    : Icons.check_circle,
                color: statusColor,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activity.title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      activity.date,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: statusBg,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  activity.isLate ? 'TERLAMBAT' : 'HADIR',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'LOKASI',
            style: TextStyle(fontSize: 10, color: Colors.black45),
          ),
          const SizedBox(height: 2),
          Text(
            activity.location,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: onDetailTap,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primaryRed,
                side: const BorderSide(color: AppColors.primaryRed),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Lihat Detail'),
            ),
          ),
        ],
      ),
    );
  }
}
