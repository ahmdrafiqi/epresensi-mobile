import 'package:e_presensimobile/app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Ini halaman Riwayat',
        style: TextStyle(color: AppColors.primaryNavy, fontSize: 20),
      ),
    );
  }
}
