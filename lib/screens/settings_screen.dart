import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_constants.dart';
import '../providers/auth_provider.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  String? get profileImagePath => Provider.of<AuthProvider>(context, listen: false).currentUser?.profileImage ?? 'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=150&h=150&fit=crop&crop=face';

  // Dil seçimi için state - sadece 3 dil olacak
  String _selectedLanguage = 'Türkçe';
  final List<String> _languages = ['Türkçe', 'العربية', 'English'];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: const Color(AppConstants.primaryColorValue),
        title: const Text(
          'Hesabım',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        // TODO: Düzenle ikonu daha sonra kullanılacak
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.edit, color: Colors.white),
        //     onPressed: () {
        //       // Profil düzenleme sayfasına git
        //     },
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            // Profil Kartı (Geliştirilmiş)
            _buildEnhancedProfileCard(),
            const SizedBox(height: 24),
            
            // Profili Düzenle
            _buildMenuButton(
              icon: Icons.edit,
              title: 'Profili Düzenle',
              onTap: () => _navigateToEditProfile(context),
            ),
            const SizedBox(height: 16),
            
            // Dil Seçeneği - Daha kullanışlı hale getirildi
            _buildExpandableLanguageSection(),
            const SizedBox(height: 16),
            
            // Yorum Yap
            _buildMenuButton(
              icon: Icons.rate_review,
              title: 'Yorum Yap',
              onTap: () {},
            ),
            const SizedBox(height: 24),
            
            // Hesap Ayarları Başlığı
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 24, bottom: 12),
                child: Text(
                  'Hesap Ayarları',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            
            // Şifre Değiştirme
            _buildMenuButton(
              icon: Icons.lock,
              title: 'Şifre Değiştirme',
              onTap: () => _navigateToChangePassword(context),
            ),
            const SizedBox(height: 16),
            
            // Hesap Silme Talebi
            _buildMenuButton(
              icon: Icons.delete_forever,
              title: 'Hesap Silme Talebi',
              titleColor: Color(AppConstants.primaryColorValue),
              onTap: () => _showDeleteAccountDialog(context),
            ),
            const SizedBox(height: 32),
            
            // Çıkış Yap Butonu
            _buildLogoutButton(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildEnhancedProfileCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 2,
        color: Color(AppConstants.primaryColorValue),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Profil Fotoğrafı
            ClipOval(
              child: Container(
                width: 90,
                height: 90,
                child: profileImagePath != null
                    ? Image.network(
                        profileImagePath!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              color: Color(AppConstants.primaryColorValue),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.person,
                              size: 45,
                              color: Colors.white,
                            ),
                          );
                        },
                      )
                    : Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: Color(AppConstants.primaryColorValue),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.person, size: 45, color: Colors.white),
                      ),
              ),
            ),
            const SizedBox(height: 16),
            // Kullanıcı Adı
            Text(
              'Demo Turist',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 6),
            // E-posta
            Text(
              'demo@turist.com',
              style: TextStyle(
                fontSize: 13,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
            const SizedBox(height: 2),
            // Telefon
            Text(
              '+90 555 123 4567',
              style: TextStyle(
                fontSize: 13,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }

  Widget _buildMenuButton({
    required IconData icon,
    required String title,
    Widget? trailing,
    Color? titleColor,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: Color(AppConstants.primaryColorValue),
          size: 24,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: titleColor ?? Colors.black87,
          ),
        ),
        trailing: trailing ?? Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Color(0xFF444444),
        ),
        onTap: onTap,
      ),
    );
  }

  // Yeni kullanışlı fonksiyonlar
  void _navigateToEditProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _EditProfileScreen(),
      ),
    );
  }

  void _navigateToChangePassword(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _ChangePasswordScreen(),
      ),
    );
  }

  Widget _buildExpandableLanguageSection() {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          leading: Icon(
            Icons.language,
            color: Color(AppConstants.primaryColorValue),
            size: 24,
          ),
          title: Text(
            'Dil',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _selectedLanguage,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
              Icon(
                Icons.expand_more,
                color: Color(0xFF444444),
              ),
            ],
          ),
          children: _languages.map((language) {
            return ListTile(
              title: Text(
                language,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              trailing: _selectedLanguage == language
                  ? Icon(
                      Icons.check,
                      color: Color(AppConstants.primaryColorValue),
                    )
                  : null,
              onTap: () {
                setState(() {
                  _selectedLanguage = language;
                });
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showEditProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Profili Düzenle'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'İsim',
                  border: OutlineInputBorder(),
                ),
                controller: TextEditingController(text: 'Demo'),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Soyisim',
                  border: OutlineInputBorder(),
                ),
                controller: TextEditingController(text: 'Turist'),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'E-posta',
                  border: OutlineInputBorder(),
                ),
                controller: TextEditingController(text: 'demo@turist.com'),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Telefon',
                  border: OutlineInputBorder(),
                ),
                controller: TextEditingController(text: '+90 555 123 4567'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Profil güncelleme işlemi burada yapılacak
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(AppConstants.primaryColorValue),
            ),
            child: Text('Kaydet', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Dil Seçin'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Türkçe'),
              leading: Radio(
                value: 'Türkçe',
                groupValue: _selectedLanguage,
                onChanged: (value) {
                  setState(() {
                    _selectedLanguage = value!;
                  });
                  Navigator.pop(context);
                },
                activeColor: Color(AppConstants.primaryColorValue),
              ),
            ),
            ListTile(
              title: const Text('العربية'),
              leading: Radio(
                value: 'العربية',
                groupValue: _selectedLanguage,
                onChanged: (value) {
                  setState(() {
                    _selectedLanguage = value!;
                  });
                  Navigator.pop(context);
                },
                activeColor: Color(AppConstants.primaryColorValue),
              ),
            ),
            ListTile(
              title: const Text('English'),
              leading: Radio(
                value: 'English',
                groupValue: _selectedLanguage,
                onChanged: (value) {
                  setState(() {
                    _selectedLanguage = value!;
                  });
                  Navigator.pop(context);
                },
                activeColor: Color(AppConstants.primaryColorValue),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('İptal'),
          ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Şifre Değiştir'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Mevcut Şifre',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Yeni Şifre',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Yeni Şifre Tekrar',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Şifre değiştirme işlemi burada yapılacak
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(AppConstants.primaryColorValue),
            ),
            child: Text('Değiştir', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Hesap Silme Talebi',
          style: TextStyle(color: Color(AppConstants.primaryColorValue)),
        ),
        content: const Text(
          'Hesabınızı silmek istediğinizden emin misiniz? Bu işlem geri alınamaz.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Hesap silme talebi burada yapılacak
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Hesap silme talebiniz alınmıştır. En kısa sürede işleme alınacaktır.'),
                  backgroundColor: Color(AppConstants.primaryColorValue),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(AppConstants.primaryColorValue),
            ),
            child: Text('Sil', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }









  Widget _buildLogoutButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: Icon(Icons.logout, color: Colors.white),
        label: Text('Çıkış Yap', style: TextStyle(color: Colors.white)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(AppConstants.primaryColorValue),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
          padding: EdgeInsets.symmetric(vertical: 16),
        ),
        onPressed: () => _showLogoutDialog(),
      ),
    );
  }





  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Çıkış Yap'),
        content: const Text('Hesabınızdan çıkmak istediğinizden emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () {
              // Dialog'u kapat
              Navigator.pop(context);
              
              // Gerçek çıkış işlemi
              _performLogout();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Çıkış Yap', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _performLogout() {
    // AuthProvider'dan çıkış yap
    try {
      Provider.of<AuthProvider>(context, listen: false).logout();
      
      // Login ekranına yönlendir
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/login',
        (route) => false, // Tüm önceki sayfaları temizle
      );
      
      // Başarı mesajı göster
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Başarıyla çıkış yapıldı'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      // Hata durumunda
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Çıkış yapılırken bir hata oluştu'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}

// Profil Düzenleme Sayfası
class _EditProfileScreen extends StatefulWidget {
  @override
  __EditProfileScreenState createState() => __EditProfileScreenState();
}

class __EditProfileScreenState extends State<_EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: 'Demo');
  final _surnameController = TextEditingController(text: 'Turist');
  final _emailController = TextEditingController(text: 'demo@turist.com');
  final _phoneController = TextEditingController(text: '+90 555 123 4567');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Color(AppConstants.primaryColorValue),
        title: Text('Profili Düzenle', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Profil Fotoğrafı Değiştirme
              Center(
                child: Stack(
                  children: [
                    ClipOval(
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Color(AppConstants.primaryColorValue),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.person, size: 60, color: Colors.white),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(AppConstants.primaryColorValue),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: Icon(Icons.camera_alt, color: Colors.white, size: 20),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),
              
              // Form Alanları
              _buildTextField('İsim', _nameController, Icons.person),
              SizedBox(height: 16),
              _buildTextField('Soyisim', _surnameController, Icons.person_outline),
              SizedBox(height: 16),
              _buildTextField('E-posta', _emailController, Icons.email),
              SizedBox(height: 16),
              _buildTextField('Telefon', _phoneController, Icons.phone),
              SizedBox(height: 32),
              
              // Kaydet Butonu
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(AppConstants.primaryColorValue),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Kaydet',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Color(AppConstants.primaryColorValue)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(AppConstants.primaryColorValue)),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$label boş olamaz';
        }
        return null;
      },
    );
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Profil başarıyla güncellendi'),
          backgroundColor: Color(AppConstants.primaryColorValue),
        ),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}

// Şifre Değiştirme Sayfası
class _ChangePasswordScreen extends StatefulWidget {
  @override
  __ChangePasswordScreenState createState() => __ChangePasswordScreenState();
}

class __ChangePasswordScreenState extends State<_ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Color(AppConstants.primaryColorValue),
        title: Text('Şifre Değiştir', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 32),
              
              // Mevcut Şifre
              _buildPasswordField(
                'Mevcut Şifre',
                _currentPasswordController,
                _obscureCurrentPassword,
                () => setState(() => _obscureCurrentPassword = !_obscureCurrentPassword),
              ),
              SizedBox(height: 16),
              
              // Yeni Şifre
              _buildPasswordField(
                'Yeni Şifre',
                _newPasswordController,
                _obscureNewPassword,
                () => setState(() => _obscureNewPassword = !_obscureNewPassword),
              ),
              SizedBox(height: 16),
              
              // Yeni Şifre Tekrar
              _buildPasswordField(
                'Yeni Şifre Tekrar',
                _confirmPasswordController,
                _obscureConfirmPassword,
                () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                validator: (value) {
                  if (value != _newPasswordController.text) {
                    return 'Şifreler eşleşmiyor';
                  }
                  return null;
                },
              ),
              SizedBox(height: 32),
              
              // Şifre Güvenlik Kuralları
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Şifre Kuralları:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(AppConstants.primaryColorValue),
                      ),
                    ),
                    SizedBox(height: 8),
                    _buildPasswordRule('En az 8 karakter'),
                    _buildPasswordRule('En az 1 büyük harf'),
                    _buildPasswordRule('En az 1 küçük harf'),
                    _buildPasswordRule('En az 1 rakam'),
                  ],
                ),
              ),
              SizedBox(height: 32),
              
              // Değiştir Butonu
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _changePassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(AppConstants.primaryColorValue),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Şifre Değiştir',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField(
    String label,
    TextEditingController controller,
    bool obscureText,
    VoidCallback toggleVisibility, {
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(Icons.lock, color: Color(AppConstants.primaryColorValue)),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility : Icons.visibility_off,
            color: Color(AppConstants.primaryColorValue),
          ),
          onPressed: toggleVisibility,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(AppConstants.primaryColorValue)),
        ),
      ),
      validator: validator ?? (value) {
        if (value == null || value.isEmpty) {
          return '$label boş olamaz';
        }
        if (value.length < 8) {
          return 'Şifre en az 8 karakter olmalı';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordRule(String rule) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 16,
            color: Colors.grey[600],
          ),
          SizedBox(width: 8),
          Text(rule, style: TextStyle(color: Colors.grey[600])),
        ],
      ),
    );
  }

  void _changePassword() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Şifre başarıyla değiştirildi'),
          backgroundColor: Color(AppConstants.primaryColorValue),
        ),
      );
    }
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
} 