import 'package:e_presensimobile/app/theme/app_theme.dart';
import 'package:e_presensimobile/app/router/app_router.dart';
import 'package:e_presensimobile/features/auth/presentation/login_screen.dart';
import 'package:e_presensimobile/features/dashboard/views/dashboard_karyawan.dart';
import 'package:e_presensimobile/features/dashboard/views/dashboard_manager.dart';
import 'package:e_presensimobile/features/dashboard/views/dashboard_pengawas.dart';
import 'package:flutter/material.dart';

import 'features/auth/presentation/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Presensi Mobile',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),

      onGenerateRoute: (settings) {
        switch (settings.name) {
          case AppRoutes.login:
            return MaterialPageRoute<void>(
              settings: settings,
              builder: (_) => const LoginScreen(),
            );
          case AppRoutes.dashboardKaryawan:
          case AppRoutes.dashboardManager:
          case AppRoutes.dashboardPengawas:
            final arguments = settings.arguments;
            if (arguments is! DashboardRouteArgs) {
              return MaterialPageRoute<void>(
                settings: settings,
                builder: (_) => const _InvalidRoutePage(),
              );
            }

            return MaterialPageRoute(
              settings: settings,
              builder: (context) {
                final user = arguments.user;
                return switch (settings.name) {
                  AppRoutes.dashboardKaryawan => DashboardKaryawan(
                    email: user.email,
                    name: user.name,
                    role: user.role,
                  ),
                  AppRoutes.dashboardManager => DashboardManager(
                    email: user.email,
                    name: user.name,
                    role: user.role,
                  ),
                  AppRoutes.dashboardPengawas => DashboardPengawas(
                    email: user.email,
                    name: user.name,
                    role: user.role,
                  ),
                  _ => const _InvalidRoutePage(),
                };
              },
            );
        }

        return null;
      },
    );
  }
}

class _InvalidRoutePage extends StatelessWidget {
  const _InvalidRoutePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Data pengguna tidak valid. Silakan masuk kembali.'),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.login,
                  (_) => false,
                ),
                child: const Text('Ke halaman login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
