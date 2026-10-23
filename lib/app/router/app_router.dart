class ApiConstants {
  // Ganti sesuai environment:
  // Android Emulator: 10.0.2.2 | Device Fisik: IP Laptop (misal: 192.168.1.15)
  static const String baseUrl = 'http://10.0.2.2:8000/api';

  static const String login = '$baseUrl/login';
  static const String logout = '$baseUrl/logout';
}