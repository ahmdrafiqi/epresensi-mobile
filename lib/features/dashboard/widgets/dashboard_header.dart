import 'package:e_presensimobile/app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class DashboardHeader extends StatelessWidget {
  final String email;
  final String name;
  final String role;
  final VoidCallback onLogout;

  const DashboardHeader({
    super.key,
    required this.email,
    this.name = '',
    required this.role,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      backgroundColor: AppColors.primaryRed,
      toolbarHeight: 100,
      leadingWidth: 64,
      leading: const Padding(
        padding: EdgeInsets.only(left: 16),
        child: CircleAvatar(
          backgroundImage: AssetImage('assets/images/profile.jpg'),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Selamat Datang,',
            style: Theme.of(context).textTheme.bodyMedium
                ?.copyWith(color: AppColors.whitePrimary),
          ),
          Text(
            name.isEmpty ? email : name,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.whitePrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            role.toUpperCase(),
            style: Theme.of(context).textTheme.bodySmall
                ?.copyWith(color: AppColors.whitePrimary),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: IconButton(
            onPressed: onLogout,
            icon: const Icon(Icons.logout, color: AppColors.whitePrimary),
            tooltip: 'Logout',
          ),
        ),
      ],
    );
  }
}
