import 'package:e_presensimobile/app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ApprovalPage extends StatelessWidget {
  const ApprovalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Ini halaman Approval',
        style: TextStyle(color: AppColors.primaryNavy, fontSize: 20),
      ),
    );
  }
}
