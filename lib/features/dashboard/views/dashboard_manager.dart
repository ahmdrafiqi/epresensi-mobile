import 'package:flutter/material.dart';

class DashboardManager extends StatefulWidget {
  final String email;
  final String role;
  const DashboardManager({
    super.key,
    required this.email,
    required this.role,
  });

  @override
  State<DashboardManager> createState() => _DashboardManagerState();
}

class _DashboardManagerState extends State<DashboardManager> {
  void _logout() {
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Manager'),
        actions: [
          IconButton(
            onPressed: _logout,
            icon: Icon(Icons.logout),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Selamat datang, ${widget.email}!\n'
          'Role: ${widget.role}',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
