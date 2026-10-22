import 'package:e_presensimobile/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:e_presensimobile/shared/widgets/stat_card.dart';
import 'package:e_presensimobile/shared/widgets/quick_access_button.dart';
import 'package:e_presensimobile/shared/widgets/section_title.dart';
import 'package:e_presensimobile/shared/widgets/activity_card.dart';
import 'package:e_presensimobile/shared/widgets/activity.dart';

class DashboardKaryawan extends StatefulWidget {
  final String email;
  final String role;

  const DashboardKaryawan({
    super.key,
    required this.email,
    required this.role,
  });

  @override
  State<DashboardKaryawan> createState() => _DashboardKaryawanState();
}

class _DashboardKaryawanState extends State<DashboardKaryawan> {
  int _selectedIndex = 0;

  final List<BottomNavigationBarItem> bottomNavList = const [
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

  final List<Activity> _activities = const [
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

  void _logout() {
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: CustomScrollView(
        slivers: [
          // 1. AppBar: pinned, satu-satunya yang tersisa di atas saat scroll
          SliverAppBar(
            pinned: true,
            elevation: 0,
            scrolledUnderElevation: 0,
            surfaceTintColor: Colors.transparent,
            backgroundColor: AppColors.primaryRed,
            toolbarHeight: 100,
            leadingWidth: 64.0,

            leading: const Padding(
              padding: EdgeInsets.only(left: 16.0),
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
                  'Bapak ${widget.email}',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.whitePrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.role.toUpperCase(),
                  style: Theme.of(context).textTheme.bodySmall
                      ?.copyWith(color: AppColors.whitePrimary),
                ),
              ],
            ),

            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: IconButton(
                  onPressed: _logout,
                  icon: Icon(
                    Icons.notifications_outlined,
                    color: AppColors.whitePrimary,
                  ),
                  tooltip: 'Notifikasi',
                ),
              ),
            ],
          ),

          // 2. Background merah + kartu statistik yang overlap
          SliverToBoxAdapter(
            child: Stack(
              children: [
                // Background merah hanya setinggi 50, kartu lebih tinggi
                // sehingga kartu "keluar" dan terlihat menimpa batas merah.
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

                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.45,
                    children: const [
                      StatCard(
                        icon: Icons.person_outline,
                        iconColor: Color(0xFFD32F2F),
                        value: '98%',
                        label: 'Rasio Kehadiran',
                      ),
                      StatCard(
                        icon: Icons.calendar_today_outlined,
                        iconColor: Color(0xFFF57C00),
                        value: '12',
                        label: 'Sisa Cuti Tahunan',
                      ),
                      StatCard(
                        icon: Icons.access_time,
                        iconColor: Color(0xFF1976D2),
                        value: '8.5h',
                        label: 'Total Lembur',
                      ),
                      StatCard(
                        icon: Icons.check_circle_outline,
                        iconColor: Color(0xFF388E3C),
                        value: '07.15',
                        label: 'Absen Terakhir',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 3. Akses Cepat
          const SliverToBoxAdapter(child: SectionTitle(title: 'Akses Cepat')),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 2.6,
                children: [
                  QuickAccessButton(
                    icon: Icons.login,
                    label: 'Absen\nMasuk',
                    onTap: () {},
                  ),
                  QuickAccessButton(
                    icon: Icons.logout,
                    label: 'Absen\nPulang',
                    onTap: () {},
                  ),
                  QuickAccessButton(
                    icon: Icons.event_note_outlined,
                    label: 'Ajukan\nCuti',
                    onTap: () {},
                  ),
                  QuickAccessButton(
                    icon: Icons.more_time,
                    label: 'Ajukan\nLembur',
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),

          // 4. Aktivitas Terbaru
          SliverToBoxAdapter(
            child: SectionTitle(
              title: 'Aktivitas Terbaru',
              actionLabel: 'Lihat Semua',
              onActionTap: () {},
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList.separated(
              itemCount: _activities.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) => ActivityCard(
                activity: _activities[index],
                onDetailTap: () {},
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primaryRed,
        backgroundColor: AppColors.whitePrimary,
        unselectedItemColor: AppColors.whiteDisabled,
        items: bottomNavList,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Widget pendukung (nanti bisa dipindah ke folder widgets/)
// ---------------------------------------------------------------------------
