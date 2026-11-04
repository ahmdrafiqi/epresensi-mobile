import 'package:e_presensimobile/app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class RequestsPage extends StatelessWidget {
  const RequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Ini halaman Pengajuan',
        style: TextStyle(color: AppColors.primaryNavy, fontSize: 20),
      ),
    );
  }
}
