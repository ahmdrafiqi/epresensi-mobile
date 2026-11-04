import 'package:e_presensimobile/shared/models/user_model.dart';

class ApiConstants {
  static const _configuredBaseUrl = String.fromEnvironment('API_BASE_URL');
  static const _isReleaseBuild = bool.fromEnvironment('dart.vm.product');

  static String get baseUrl {
    final value = _configuredBaseUrl.isEmpty
        ? (_isReleaseBuild
              ? ''
              : 'http://10.0.2.2:8000/api')
        : _configuredBaseUrl.trim();
    final uri = Uri.tryParse(value);

    if (uri == null ||
        !uri.hasAuthority ||
        uri.host.isEmpty ||
        uri.userInfo.isNotEmpty ||
        (uri.scheme != 'https' && !(!_isReleaseBuild && uri.scheme == 'http')) ||
        uri.hasQuery ||
        uri.hasFragment) {
      throw StateError(
        'API_BASE_URL tidak valid. Gunakan URL HTTPS untuk build rilis.',
      );
    }

    return value.replaceFirst(RegExp(r'/+$'), '');
  }

  static String get login => '$baseUrl/login';
  static String get logout => '$baseUrl/logout';
}

class DashboardRouteArgs {
  final UserModel user;

  const DashboardRouteArgs({required this.user});
}

class AppRoutes {
  static const login = '/login';
  static const dashboardKaryawan = '/dashboard-karyawan';
  static const dashboardManager = '/dashboard-manager';
  static const dashboardPengawas = '/dashboard-pengawas';

  static String? dashboardForRole(String role) {
    switch (role.trim().toLowerCase()) {
      case 'karyawan':
        return dashboardKaryawan;
      case 'manager':
        return dashboardManager;
      case 'pengawas':
        return dashboardPengawas;
      default:
        return null;
    }
  }
}