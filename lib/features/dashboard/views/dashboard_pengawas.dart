import 'package:e_presensimobile/app/theme/app_colors.dart';
import 'package:e_presensimobile/app/router/app_router.dart';
import 'package:e_presensimobile/features/approval/views/approval_page.dart';
import 'package:e_presensimobile/features/attendance/views/attendance_page.dart';
import 'package:e_presensimobile/features/auth/data/auth_service.dart';
import 'package:e_presensimobile/features/dashboard/widgets/dashboard_header.dart';
import 'package:e_presensimobile/features/dashboard/widgets/dashboard_navigation_bar.dart';
import 'package:e_presensimobile/features/dashboard/widgets/dashboard_summary_backdrop.dart';
import 'package:e_presensimobile/features/dashboard/widgets/lazy_dashboard_tab_stack.dart';
import 'package:e_presensimobile/features/dashboard/widgets/inspector_validation_section.dart';
import 'package:e_presensimobile/features/dashboard/widgets/inspector_summary.dart';
import 'package:e_presensimobile/features/profile/views/profile_page.dart';
import 'package:flutter/material.dart';

class DashboardPengawas extends StatefulWidget {
  final String email;
  final String name;
  final String role;

  const DashboardPengawas({
    super.key,
    required this.email,
    this.name = '',
    required this.role,
  });

  @override
  State<DashboardPengawas> createState() => _DashboardPengawasState();
}

class _DashboardPengawasState extends State<DashboardPengawas> {
  int _selectedIndex = 0;
  bool _isLoggingOut = false;

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
        const DashboardSummaryBackdrop(child: InspectorSummary()),
        const InspectorValidationSection(),
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
          (_) => const ApprovalPage(),
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
        role: widget.role,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}
