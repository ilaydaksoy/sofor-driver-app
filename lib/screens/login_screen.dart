import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_constants.dart';
import '../providers/auth_provider.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
import 'register_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final success = await authProvider.login(
      _emailController.text.trim(),
      _passwordController.text,
    );

    if (success && mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  void _navigateToRegister() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const RegisterScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(AppConstants.backgroundColorValue),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 60),
                
                // Logo ve Başlık
                Icon(
                  Icons.directions_car,
                  size: 80,
                  color: const Color(AppConstants.primaryColorValue),
                ),
                const SizedBox(height: 24),
                
                Text(
                  AppConstants.appName,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(AppConstants.textColorValue),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                
                Text(
                  AppConstants.welcomeMessage,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(AppConstants.textColorValue),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                
                // Giriş Formu
                CustomTextField(
                  controller: _emailController,
                  hintText: AppConstants.emailHint,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppConstants.fieldRequired;
                    }
                    if (!Provider.of<AuthProvider>(context, listen: false)
                        .validateEmail(value)) {
                      return AppConstants.invalidEmail;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                
                CustomTextField(
                  controller: _passwordController,
                  hintText: AppConstants.passwordHint,
                  obscureText: _obscurePassword,
                  prefixIcon: Icons.lock,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppConstants.fieldRequired;
                    }
                    if (value.length < 6) {
                      return AppConstants.weakPassword;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                
                // Giriş Butonu
                Consumer<AuthProvider>(
                  builder: (context, authProvider, child) {
                    return CustomButton(
                      text: AppConstants.loginButton,
                      onPressed: authProvider.isLoading ? null : _login,
                      isLoading: authProvider.isLoading,
                    );
                  },
                ),
                const SizedBox(height: 16),
                
                // Hata Mesajı
                Consumer<AuthProvider>(
                  builder: (context, authProvider, child) {
                    if (authProvider.error != null) {
                      return Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(AppConstants.errorColorValue).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: const Color(AppConstants.errorColorValue),
                          ),
                        ),
                        child: Text(
                          authProvider.error!,
                          style: const TextStyle(
                            color: Color(AppConstants.errorColorValue),
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                const SizedBox(height: 24),
                
                // Kayıt Ol Linki
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppConstants.noAccount,
                      style: const TextStyle(
                        color: Color(AppConstants.textColorValue),
                      ),
                    ),
                    TextButton(
                      onPressed: _navigateToRegister,
                      child: Text(
                        AppConstants.registerTitle,
                        style: const TextStyle(
                          color: Color(AppConstants.primaryColorValue),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 