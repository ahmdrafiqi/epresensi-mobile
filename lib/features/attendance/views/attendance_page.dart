import 'package:e_presensimobile/app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AttendancePage extends StatelessWidget {
  const AttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Ini halaman Presensi',
        style: TextStyle(color: AppColors.primaryNavy, fontSize: 20),
      ),
    );
  }
}
