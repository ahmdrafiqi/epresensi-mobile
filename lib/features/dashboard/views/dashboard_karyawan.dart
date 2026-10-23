import 'package:e_presensimobile/app/theme/app_colors.dart';
import 'package:e_presensimobile/features/dashboard/widgets/attendance_summary.dart';
import 'package:e_presensimobile/features/dashboard/widgets/dashboard_header.dart';
import 'package:e_presensimobile/features/dashboard/widgets/quick_access_section.dart';
import 'package:e_presensimobile/features/dashboard/widgets/recent_activity_section.dart';
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

  static const _bottomNavigationItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home),
      label: 'Beranda',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.camera_alt_outlined),
      activeIcon: Icon(Icons.camera_alt),
      label: 'Presensi',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.description_outlined),
      activeIcon: Icon(Icons.description),
      label: 'Pengajuan',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person_2_outlined),
      activeIcon: Icon(Icons.person),
      label: 'Profile',
    ),
  ];

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
          const AttendanceSummary(),
          const QuickAccessSection(),
          const RecentActivitySection(activities: _activities),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primaryRed,
        backgroundColor: AppColors.whitePrimary,
        unselectedItemColor: AppColors.whiteDisabled,
        items: _bottomNavigationItems,
      ),
    );
  }
}
