import 'package:e_presensimobile/app/theme/app_colors.dart';
import 'package:e_presensimobile/app/router/app_router.dart';
import 'package:e_presensimobile/features/attendance/views/attendance_page.dart';
import 'package:e_presensimobile/features/auth/data/auth_service.dart';
import 'package:e_presensimobile/features/dashboard/widgets/attendance_summary.dart';
import 'package:e_presensimobile/features/dashboard/widgets/dashboard_header.dart';
import 'package:e_presensimobile/features/dashboard/widgets/dashboard_navigation_bar.dart';
import 'package:e_presensimobile/features/dashboard/widgets/dashboard_summary_backdrop.dart';
import 'package:e_presensimobile/features/dashboard/widgets/lazy_dashboard_tab_stack.dart';
import 'package:e_presensimobile/features/dashboard/widgets/quick_access_section.dart';
import 'package:e_presensimobile/features/dashboard/widgets/recent_activity_section.dart';
import 'package:e_presensimobile/features/history/views/history_page.dart';
import 'package:e_presensimobile/features/profile/views/profile_page.dart';
import 'package:e_presensimobile/features/requests/views/requests_page.dart';
import 'package:e_presensimobile/shared/widgets/activity.dart';
import 'package:flutter/material.dart';

class DashboardKaryawan extends StatefulWidget {
  final String email;
  final String name;
  final String role;

  const DashboardKaryawan({
    super.key,
    required this.email,
    this.name = '',
    required this.role,
  });

  @override
  State<DashboardKaryawan> createState() => _DashboardKaryawanState();
}

class _DashboardKaryawanState extends State<DashboardKaryawan> {
  int _selectedIndex = 0;
  bool _isLoggingOut = false;

  static const _activities = [
    Activity(
      title: 'Absensi Masuk Berhasil',
      date: '24 Mei 2024 • 07:15 WIB',
      location: 'Kantor Pusat (Head Office)',
      isLate: false,
    ),
    Activity(
      title: 'Absensi Masuk Terlambat',
      date: '23 Mei 2024 • 08:05 WIB',
      location: 'Kantor Pusat (Head Office)',
      isLate: true,
    ),
  ];

  Future<void> _logout() async {
    if (_isLoggingOut) return;
    setState(() => _isLoggingOut = true);

    String? warning;
    try {
      warning = await AuthService().logout();
    } on AuthException catch (error) {
      if (!mounted) return;
      setState(() => _isLoggingOut = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message)),
      );
      return;
    }

    if (!mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login,
      (route) => false,
    );
    if (warning != null) {
      messenger.showSnackBar(SnackBar(content: Text(warning)));
    }
  }

  Widget _buildHomePage() {
    return CustomScrollView(
      slivers: [
        DashboardHeader(
          email: widget.email,
          name: widget.name,
          role: widget.role,
        ),
        const DashboardSummaryBackdrop(child: AttendanceSummary()),
        QuickAccessSection(
          onNavigateToAttendance: () =>
              setState(() => _selectedIndex = 1),
          onNavigateToRequests: () =>
              setState(() => _selectedIndex = 2),
        ),
        RecentActivitySection(
          activities: _activities,
          onSeeAllTap: () => setState(() => _selectedIndex = 3),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: LazyDashboardTabStack(
        index: _selectedIndex,
        cacheKey: (widget.email, widget.name, widget.role),
        pageBuilders: [
          (_) => _buildHomePage(),
          (_) => const AttendancePage(),
          (_) => const RequestsPage(),
          (_) => const HistoryPage(),
          (_) => ProfilePage(
            email: widget.email,
            name: widget.name,
            role: widget.role,
            onLogout: _logout,
          ),
        ],
      ),
      bottomNavigationBar: DashboardNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        role: widget.role,
      ),
    );
  }
}
