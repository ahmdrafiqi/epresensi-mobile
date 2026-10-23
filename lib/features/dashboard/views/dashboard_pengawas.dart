import 'package:e_presensimobile/app/theme/app_colors.dart';
import 'package:e_presensimobile/features/dashboard/widgets/dashboard_header.dart';
import 'package:e_presensimobile/features/dashboard/widgets/dashboard_navigation_bar.dart';
import 'package:e_presensimobile/features/dashboard/widgets/inspector_validation_section.dart';
import 'package:e_presensimobile/features/dashboard/widgets/inspector_summary.dart';
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

  void _logout() {
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          DashboardHeader(
            email: widget.email,
            name: widget.name,
            role: widget.role,
            onLogout: _logout,
          ),
          const InspectorSummary(),
          const InspectorValidationSection(),
        ],
      ),
      bottomNavigationBar: DashboardNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}
