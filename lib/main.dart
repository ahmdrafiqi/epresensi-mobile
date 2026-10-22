import 'package:e_presensimobile/app/theme/app_theme.dart';
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

      routes: {'/login': (context) => const LoginScreen()},

      onGenerateRoute: (settings) {
        final args = settings.arguments as Map<String, dynamic>?;

        switch (settings.name) {
          case '/dashboard-karyawan':
            if (args == null) break;

            return MaterialPageRoute(
              builder: (context) => DashboardKaryawan(
                email: args['email'] as String,
                role: args['role'] as String,
              ),
            );

          case '/dashboard-manager':
            if (args == null) break;

            return MaterialPageRoute(
              builder: (context) => DashboardManager(
                email: args['email'] as String,
                role: args['role'] as String,
              ),
            );

          case '/dashboard-pengawas':
            if (args == null) break;

            return MaterialPageRoute(
              builder: (context) => DashboardPengawas(
                email: args['email'] as String,
                role: args['role'] as String,
              ),
            );
        }

        return null;
      },
    );
  }
}
