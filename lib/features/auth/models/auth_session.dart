import 'package:e_presensimobile/shared/models/user_model.dart';

class AuthSession {
  final UserModel user;
  final String? token;

  const AuthSession({required this.user, required this.token});

  Map<String, dynamic> toJson() => {'user': user.toJson(), 'token': token};

  factory AuthSession.fromJson(Map<String, dynamic> json) {
    final rawUser = json['user'];
    final rawToken = json['token'];
    if (rawUser is! Map<String, dynamic> ||
        rawToken is! String ||
        rawToken.trim().isEmpty) {
      throw const FormatException('Sesi autentikasi tidak valid.');
    }

    return AuthSession(
      user: UserModel.fromJson(rawUser),
      token: rawToken.trim(),
    );
  }
}
