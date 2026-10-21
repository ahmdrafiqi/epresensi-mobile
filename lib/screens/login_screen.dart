import 'package:flutter/material.dart';
import 'package:e_presensimobile/core/theme/app_colors.dart';
import 'package:e_presensimobile/screens/karyawan/dashboard_karyawan.dart';
import 'package:e_presensimobile/screens/manager/dashboard_manager.dart';
import 'package:e_presensimobile/screens/pengawas/dashboard_pengawas.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;
  bool _rememberMe = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    const accounts = {
      'karyawan': {'password': '123', 'role': 'karyawan'},
      'pengawas': {'password': '123', 'role': 'pengawas'},
      'manager': {'password': '123', 'role': 'manager'},
    };

    final account = accounts[username];

    if (account == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Akun tidak terdaftar')));
      return;
    }

    if (account['password'] != password) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Password salah')));
      return;
    }

    final role = account['role'];

    if (role == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Role tidak dikenali')));
      return;
    }

    Widget destination;

    switch (role) {
      case 'karyawan':
        destination = DashboardKaryawan(username: username, role: role);
        break;

      case 'manager':
        destination = DashboardManager(username: username, role: role);
        break;

      case 'pengawas':
        destination = DashboardPengawas(username: username, role: role);
        break;

      default:
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Role tidak dikenali')));
        return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => destination),
    );
  } // Fungsi _login selesai di sini

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // logo
                  Image.asset('assets/images/logo_pertamina.png', width: 245),

                  SizedBox(height: screenHeight * 0.08),
                  
                  // text
                  Text(
                    'Selamat Datang',
                    style: textTheme.headlineLarge?.copyWith(
                      color: AppColors.primaryNavy,
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.01),

                  //  text
                  Text(
                    'Silahkan masuk untuk melanjutkan ke aplikasi e-Presensi',
                    textAlign: TextAlign.center,
                    style: textTheme.bodyLarge?.copyWith(
                      color: AppColors.primaryNavy,
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.08),

                  // input username
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      hintText: 'Username',
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Username wajib diisi';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: screenHeight * 0.02),

                  // input password
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password wajib diisi';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: screenHeight * 0.01),

                  // lupa password dan ingat saya
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: _rememberMe,
                            onChanged: (value) {
                              setState(() {
                                _rememberMe = value ?? false;
                              });
                            },
                          ),
                          Text(
                            'Ingat Saya',
                            style: textTheme.bodyMedium?.copyWith(
                              color: AppColors.primaryRed,
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          // TODO: Navigasi lupa password
                        },
                        child: const Text('Lupa Password?'),
                      ),
                    ],
                  ),

                  SizedBox(height: screenHeight * 0.05),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _login,
                      child: Text(
                        'Login',
                        style: textTheme.titleSmall?.copyWith(
                          color: AppColors.whitePrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
