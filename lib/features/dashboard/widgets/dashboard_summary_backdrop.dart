import 'package:e_presensimobile/app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class DashboardSummaryBackdrop extends StatelessWidget {
  final Widget child;

  const DashboardSummaryBackdrop({super.key, required this.child});

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
          child,
        ],
      ),
    );
  }
}
