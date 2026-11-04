import 'package:e_presensimobile/app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class DashboardNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final String role;

  const DashboardNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.role,
  });

  static const _karyawanItems = [
    NavigationDestination(
      icon: Icon(Icons.home_outlined),
      selectedIcon: Icon(Icons.home),
      label: 'Beranda',
    ),
    NavigationDestination(
      icon: Icon(Icons.login_outlined),
      selectedIcon: Icon(Icons.login),
      label: 'Presensi',
    ),
    NavigationDestination(
      icon: Icon(Icons.assignment_outlined),
      selectedIcon: Icon(Icons.assignment),
      label: 'Pengajuan',
    ),
    NavigationDestination(
      icon: Icon(Icons.history),
      selectedIcon: Icon(Icons.history),
      label: 'Riwayat',
    ),
    NavigationDestination(
      icon: Icon(Icons.person_outline),
      selectedIcon: Icon(Icons.person),
      label: 'Profil',
    ),
  ];

  static const _managerItems = [
    NavigationDestination(
      icon: Icon(Icons.home_outlined),
      selectedIcon: Icon(Icons.home),
      label: 'Beranda',
    ),
    NavigationDestination(
      icon: Icon(Icons.login_outlined),
      selectedIcon: Icon(Icons.login),
      label: 'Presensi',
    ),
    NavigationDestination(
      icon: Icon(Icons.analytics_outlined),
      selectedIcon: Icon(Icons.analytics),
      label: 'Pengajuan',
    ),
    NavigationDestination(
      icon: Icon(Icons.person_outline),
      selectedIcon: Icon(Icons.person),
      label: 'Profil',
    ),
  ];

  static const _pengawasItems = [
    NavigationDestination(
      icon: Icon(Icons.home_outlined),
      selectedIcon: Icon(Icons.home),
      label: 'Beranda',
    ),
    NavigationDestination(
      icon: Icon(Icons.login_outlined),
      selectedIcon: Icon(Icons.login),
      label: 'Presensi',
    ),
    NavigationDestination(
      icon: Icon(Icons.fact_check_outlined),
      selectedIcon: Icon(Icons.fact_check),
      label: 'Approval',
    ),
    NavigationDestination(
      icon: Icon(Icons.person_outline),
      selectedIcon: Icon(Icons.person),
      label: 'Profil',
    ),
  ];

  List<NavigationDestination> _getItemsForRole() {
    switch (role.trim().toLowerCase()) {
      case 'manager':
        return _managerItems;
      case 'pengawas':
        return _pengawasItems;
      case 'karyawan':
      default:
        return _karyawanItems;
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = _getItemsForRole();

    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: AppColors.whitePrimary,
          indicatorColor: Color(0x1AA81A1A),
          elevation: 0,
          labelTextStyle: WidgetStateProperty.resolveWith(
            (states) => TextStyle(
              color: states.contains(WidgetState.selected)
                  ? AppColors.primaryRed
                  : AppColors.primaryNavy,
              fontSize: 11,
              fontWeight: states.contains(WidgetState.selected)
                  ? FontWeight.w600
                  : FontWeight.w500,
            ),
          ),
          iconTheme: WidgetStateProperty.resolveWith(
            (states) => IconThemeData(
              color: states.contains(WidgetState.selected)
                  ? AppColors.primaryRed
                  : AppColors.primaryNavy,
              size: 22,
            ),
          ),
        ),
        child: NavigationBar(
          height: 76,
          selectedIndex: currentIndex < 0 || currentIndex >= items.length
              ? 0
              : currentIndex,
          onDestinationSelected: onTap,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: items,
        ),
      ),
    );
  }
}
