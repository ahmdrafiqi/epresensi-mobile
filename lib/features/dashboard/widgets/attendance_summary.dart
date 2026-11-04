import 'package:e_presensimobile/shared/widgets/stat_card.dart';
import 'package:flutter/material.dart';

class AttendanceSummary extends StatelessWidget {
  const AttendanceSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              'DATA CONTOH',
              style: TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
              ),
            ),
          ),
          GridView.count(
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
        ],
      ),
    );
  }
}
