import 'package:e_presensimobile/app/router/app_router.dart';
import 'package:e_presensimobile/features/auth/data/auth_service.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final AuthService? authService;

  const SplashScreen({super.key, this.authService});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final AuthService _authService = widget.authService ?? AuthService();

  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    try {
      final session = await _authService.restoreSession();
      if (!mounted) return;

      if (session == null) {
        _navigateToLogin();
        return;
      }

      final routeName = AppRoutes.dashboardForRole(session.user.role);
      if (routeName == null) {
        await _authService.logout();
        if (!mounted) return;
        _navigateToLogin('Role akun tidak didukung: ${session.user.role}.');
        return;
      }

      Navigator.pushReplacementNamed(
        context,
        routeName,
        arguments: DashboardRouteArgs(user: session.user),
      );
    } on AuthException catch (error) {
      if (mounted) _navigateToLogin(error.message);
    }
  }

  void _navigateToLogin([String? message]) {
    Navigator.pushReplacementNamed(context, AppRoutes.login);
    if (message == null) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo_pertamina.png', width: 200),
            const SizedBox(height: 24),
            const CircularProgressIndicator(color: Colors.red),
          ],
        ),
      ),
    );
  }
}
