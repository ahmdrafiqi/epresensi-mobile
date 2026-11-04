import 'package:e_presensimobile/app/theme/app_colors.dart';
import 'package:e_presensimobile/app/router/app_router.dart';
import 'package:e_presensimobile/features/auth/data/auth_service.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final AuthService? authService;

  const LoginScreen({super.key, this.authService});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late final AuthService _authService = widget.authService ?? AuthService();

  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _rememberMe = false;
  bool _emailWasEdited = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadRememberedEmail();
  }

  Future<void> _loadRememberedEmail() async {
    try {
      final email = await _authService.readRememberedEmail();
      if (!mounted || _emailWasEdited || email == null) return;
      setState(() {
        _emailController.text = email;
        _rememberMe = true;
      });
    } on AuthException catch (error) {
      if (mounted) _showMessage(error.message);
    }
  }

  Future<void> _login() async {
    if (_isLoading || !_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      final session = await _authService.login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (!mounted) return;

      final routeName = AppRoutes.dashboardForRole(session.user.role);
      if (routeName == null) {
        _showMessage('Role akun tidak didukung: ${session.user.role}.');
        return;
      }

      if (session.token == null) {
        _showMessage('Server tidak mengembalikan token autentikasi.');
        return;
      }

      await _authService.saveSession(session);
      try {
        await _authService.saveRememberedEmail(
          _rememberMe ? _emailController.text : null,
        );
      } on AuthException catch (error) {
        _showMessage(error.message);
      }

      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(
        context,
        routeName,
        (route) => false,
        arguments: DashboardRouteArgs(user: session.user),
      );
    } on AuthException catch (error) {
      if (mounted) {
        _showMessage(error.message);
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: AppColors.primaryNavy),
    );
  }

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
                  Image.asset('assets/images/logo_pertamina.png', width: 245),
                  SizedBox(height: screenHeight * 0.08),
                  Text(
                    'Selamat Datang',
                    style: textTheme.headlineLarge?.copyWith(
                      color: AppColors.primaryNavy,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    'Silahkan masuk untuk melanjutkan ke aplikasi e-Presensi',
                    textAlign: TextAlign.center,
                    style: textTheme.bodyLarge?.copyWith(
                      color: AppColors.primaryNavy,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.08),
                  TextFormField(
                    controller: _emailController,
                    onChanged: (_) => _emailWasEdited = true,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    autofillHints: const [AutofillHints.username],
                    autocorrect: false,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      prefixIcon: Icon(Icons.email),
                    ),
                    validator: (value) {
                      final email = value?.trim() ?? '';
                      if (email.isEmpty) {
                        return 'Email wajib diisi';
                      }
                      if (!email.contains('@') ||
                          email.endsWith('@') ||
                          email.startsWith('@')) {
                        return 'Masukkan alamat email yang valid';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    textInputAction: TextInputAction.done,
                    autofillHints: const [AutofillHints.password],
                    onFieldSubmitted: (_) => _login(),
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () => setState(
                          () => _obscurePassword = !_obscurePassword,
                        ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: _rememberMe,
                            onChanged: (value) =>
                                setState(() => _rememberMe = value ?? false),
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
                        onPressed: _showForgotPasswordUnavailable,
                        child: Text(
                          'Lupa Password?',
                          style: textTheme.bodyMedium?.copyWith(
                            color: AppColors.primaryRed,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _login,
                      child: _isLoading
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.whitePrimary,
                              ),
                            )
                          : Text(
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

  void _showForgotPasswordUnavailable() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Lupa Password'),
        content: const Text(
          'Pemulihan password belum tersedia. Hubungi administrator.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }
}
