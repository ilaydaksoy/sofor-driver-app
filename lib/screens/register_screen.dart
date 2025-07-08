import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_constants.dart';
import '../providers/auth_provider.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
import 'home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _licenseController = TextEditingController();
  final _vehicleModelController = TextEditingController();
  final _vehiclePlateController = TextEditingController();
  
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _licenseController.dispose();
    _vehicleModelController.dispose();
    _vehiclePlateController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final success = await authProvider.register(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
      phone: _phoneController.text.trim(),
      licenseNumber: _licenseController.text.trim().isEmpty 
          ? null 
          : _licenseController.text.trim(),
      vehicleModel: _vehicleModelController.text.trim().isEmpty 
          ? null 
          : _vehicleModelController.text.trim(),
      vehiclePlate: _vehiclePlateController.text.trim().isEmpty 
          ? null 
          : _vehiclePlateController.text.trim(),
    );

    if (success && mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(AppConstants.backgroundColorValue),
      appBar: AppBar(
        title: const Text(
          AppConstants.registerTitle,
          style: TextStyle(
            color: Color(AppConstants.textColorValue),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(AppConstants.textColorValue)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Kişisel Bilgiler
                _buildSectionTitle('Kişisel Bilgiler'),
                const SizedBox(height: 16),
                
                CustomTextField(
                  controller: _nameController,
                  hintText: AppConstants.nameHint,
                  prefixIcon: Icons.person,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppConstants.fieldRequired;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                
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
                  controller: _phoneController,
                  hintText: AppConstants.phoneHint,
                  keyboardType: TextInputType.phone,
                  prefixIcon: Icons.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppConstants.fieldRequired;
                    }
                    if (!Provider.of<AuthProvider>(context, listen: false)
                        .validatePhone(value)) {
                      return 'Geçersiz telefon numarası';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                
                // Şifre Bilgileri
                _buildSectionTitle('Şifre Bilgileri'),
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
                const SizedBox(height: 16),
                
                CustomTextField(
                  controller: _confirmPasswordController,
                  hintText: AppConstants.confirmPasswordHint,
                  obscureText: _obscureConfirmPassword,
                  prefixIcon: Icons.lock,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppConstants.fieldRequired;
                    }
                    if (value != _passwordController.text) {
                      return 'Şifreler eşleşmiyor';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                
                // Araç Bilgileri (Opsiyonel)
                _buildSectionTitle('Araç Bilgileri (Opsiyonel)'),
                const SizedBox(height: 16),
                
                CustomTextField(
                  controller: _licenseController,
                  hintText: 'Ehliyet Numarası',
                  prefixIcon: Icons.card_membership,
                ),
                const SizedBox(height: 16),
                
                CustomTextField(
                  controller: _vehicleModelController,
                  hintText: 'Araç Modeli',
                  prefixIcon: Icons.directions_car,
                ),
                const SizedBox(height: 16),
                
                CustomTextField(
                  controller: _vehiclePlateController,
                  hintText: 'Plaka',
                  prefixIcon: Icons.confirmation_number,
                ),
                const SizedBox(height: 32),
                
                // Kayıt Butonu
                Consumer<AuthProvider>(
                  builder: (context, authProvider, child) {
                    return CustomButton(
                      text: AppConstants.registerButton,
                      onPressed: authProvider.isLoading ? null : _register,
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(AppConstants.textColorValue),
      ),
    );
  }
} 