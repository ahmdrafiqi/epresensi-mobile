import 'package:flutter/material.dart';

class DashboardPengawas extends StatefulWidget {
  final String email;
  final String role;

  const DashboardPengawas({
    super.key,
    required this.email,
    required this.role,
  });

  @override
  State<DashboardPengawas> createState() => _DashboardPengawasState();
}

class _DashboardPengawasState extends State<DashboardPengawas> {
  void _logout() {
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Pengawas'),
        actions: [IconButton(onPressed: _logout, icon: Icon(Icons.logout))],
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
