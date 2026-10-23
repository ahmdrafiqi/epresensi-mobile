class UserModel {
  final int id;
  final String name;
  final String email;
  final String role;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final rawId = json['id'];
    final id = rawId is int ? rawId : int.tryParse(rawId?.toString() ?? '');
    final name = json['name'];
    final email = json['email'];
    final role = json['role'];

    if (id == null ||
        name is! String ||
        email is! String ||
        role is! String ||
        name.trim().isEmpty ||
        email.trim().isEmpty ||
        role.trim().isEmpty) {
      throw const FormatException(
        'User response must include a valid id, name, email, and role.',
      );
    }

    return UserModel(
      id: id,
      name: name,
      email: email,
      role: role.trim().toLowerCase(),
    );
  }
}
