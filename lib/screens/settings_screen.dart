import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_constants.dart';
import '../providers/auth_provider.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  bool isEmailVerified = true;
  bool isPhoneVerified = false;
  String? get profileImagePath => Provider.of<AuthProvider>(context, listen: false).currentUser?.profileImage ?? 'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=150&h=150&fit=crop&crop=face';
  
  // Ayarlar için state değişkenleri
  bool _notificationsEnabled = true;
  bool _locationEnabled = true;
  bool _biometricEnabled = false;
  
  // Demo veriler
  final List<Map<String, dynamic>> recentTrips = [
    {
      'driver': 'Ahmet Yılmaz',
      'date': '15 Mart 2024',
      'from': 'İstanbul Havalimanı',
      'to': 'Taksim',
      'price': '150 TL',
      'rating': 5.0,
    },
    {
      'driver': 'Mehmet Demir',
      'date': '10 Mart 2024',
      'from': 'Kadıköy',
      'to': 'Beşiktaş',
      'price': '80 TL',
      'rating': 4.5,
    },
  ];
  
  final List<Map<String, dynamic>> favoriteDrivers = [
    {
      'name': 'Ahmet Yılmaz',
      'rating': 5.0,
      'car': 'Mercedes C200',
      'plate': '34 ABC 123',
      'image': null,
    },
    {
      'name': 'Mehmet Demir',
      'rating': 4.8,
      'car': 'BMW 320i',
      'plate': '34 XYZ 789',
      'image': null,
    },
  ];

  // Dil seçimi için state
  String _selectedLanguage = 'Türkçe';
  final List<String> _languages = ['Türkçe', 'English', 'Deutsch', 'Русский', 'العربية'];


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
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () {
              // Profil düzenleme sayfasına git
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            // Profil Kartı
            _buildProfileCard(),
            const SizedBox(height: 16),
            // Hızlı İstatistikler
            _buildQuickStats(),
            const SizedBox(height: 16),
            // Hesap Ayarları (dil seçimi dahil)
            _buildAccountSettings(),
            const SizedBox(height: 16),
            // Güvenlik Ayarları
            _buildSecuritySettings(),
            const SizedBox(height: 16),
            // Bildirim Ayarları
            _buildNotificationSettings(),
            const SizedBox(height: 16),
            // Çıkış Butonu
            _buildLogoutButton(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
                width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
          colors: [
            const Color(AppConstants.primaryColorValue),
            const Color(AppConstants.primaryColorValue).withOpacity(0.8),
          ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
                ),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
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
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.person,
                                size: 50,
                                color: Color(AppConstants.primaryColorValue),
                              ),
                            );
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              width: 90,
                              height: 90,
                                      decoration: BoxDecoration(
                                color: Colors.grey[200],
                                        shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                  valueColor: AlwaysStoppedAnimation<Color>(Color(AppConstants.primaryColorValue)),
                                ),
                              ),
                            );
                          },
                        )
                      : Container(
                          width: 90,
                          height: 90,
                                        decoration: BoxDecoration(
                            color: Colors.white,
                                          shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.person,
                            size: 50,
                            color: Color(AppConstants.primaryColorValue),
                                            ),
                                          ),
                                        ),
                                      ),
              Container(
                padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(Icons.camera_alt, size: 16, color: Color(AppConstants.primaryColorValue)),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                    const Text(
                      'Demo Turist',
                                  style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                                    fontSize: 22,
                      ),
                    ),
          const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
              const Icon(Icons.email, color: Colors.white70, size: 16),
              const SizedBox(width: 4),
                        const Text(
                          'demo@turist.com',
                style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                        const SizedBox(width: 8),
                        _verificationBadge(isEmailVerified),
                      ],
                                ),
                                const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
              const Icon(Icons.phone, color: Colors.white70, size: 16),
              const SizedBox(width: 4),
                        const Text(
                          '+90 555 123 4567',
                style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                        const SizedBox(width: 8),
                        _verificationBadge(isPhoneVerified),
                      ],
                    ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _profileActionButton(Icons.edit, 'Profili Düzenle'),
              _profileActionButton(Icons.lock_reset, 'Şifre Değiştir'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
          _statItem('Toplam Seyahat', '24', Icons.directions_car),
          _statItem('Favori Sürücü', '3', Icons.favorite),
          _statItem('Puan', '9.2/10', Icons.star),
        ],
      ),
    );
  }

  Widget _buildAccountSettings() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
                                    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _settingsTile(
            icon: Icons.person,
            title: 'Profil Bilgileri',
            onTap: () {},
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          _divider(),
          _settingsTile(
            icon: Icons.email,
            title: 'E-posta Adresi',
            onTap: () {},
            trailing: Icon(Icons.arrow_forward_ios),
            subtitle: 'demo@turist.com',
          ),
          _divider(),
          _settingsTile(
            icon: Icons.phone,
            title: 'Telefon Numarası',
            onTap: () {},
            trailing: Icon(Icons.arrow_forward_ios),
            subtitle: '+90 555 123 4567',
          ),
          _divider(),
          _settingsTile(
            icon: Icons.lock,
            title: 'Şifre Değiştir',
            onTap: () {},
            trailing: Icon(Icons.arrow_forward_ios),
            subtitle: 'Güvenlik için şifrenizi güncelleyin',
          ),
          // Divider yok! Direkt dil seçimi geliyor
          _settingsTile(
            icon: Icons.language,
            title: 'Dil Seçimi',
            onTap: _showLanguageDialog,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(_selectedLanguage, style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black)),
                const SizedBox(width: 8),
                Icon(Icons.arrow_forward_ios, size: 20, color: Color(0xFF111111)),
              ],
            ),
                                ),
                              ],
                            ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Dil Seçimi'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: _languages.map((lang) => RadioListTile<String>(
            value: lang,
            groupValue: _selectedLanguage,
            title: Text(lang),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _selectedLanguage = value;
                });
                Navigator.pop(context);
              }
            },
          )).toList(),
        ),
      ),
    );
  }

  Widget _buildSecuritySettings() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
                            ),
                            child: Column(
                              children: [
          _settingsTile(
            icon: Icons.security,
            title: 'Güvenlik Ayarları',
            subtitle: 'Şifre, parmak izi, yüz tanıma',
            onTap: () {},
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          _divider(),
          _settingsTile(
            icon: Icons.fingerprint,
            title: 'Biyometrik Giriş',
            subtitle: 'Parmak izi ile giriş',
            onTap: () {},
            trailing: Switch(
              value: _biometricEnabled,
              onChanged: (value) {
                setState(() {
                  _biometricEnabled = value;
                });
              },
            ),
          ),
          _divider(),
          _settingsTile(
            icon: Icons.location_on,
            title: 'Konum Paylaşımı',
            subtitle: 'Seyahat sırasında konum paylaş',
            onTap: () {},
            trailing: Switch(
              value: _locationEnabled,
              onChanged: (value) {
                setState(() {
                  _locationEnabled = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationSettings() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
                                ),
                              ],
                            ),
      child: Column(
        children: [
          _settingsTile(
            icon: Icons.notifications,
            title: 'Bildirim Ayarları',
            subtitle: 'Bildirim türlerini yönetin',
            onTap: () {},
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          _divider(),
          _settingsTile(
            icon: Icons.notifications_active,
            title: 'Bildirimler',
            subtitle: 'Tüm bildirimleri aç/kapat',
            onTap: () {},
            trailing: Switch(
              value: _notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
                      ),
                    ),
                  ],
                ),
    );
  }







  Widget _buildLogoutButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
                width: double.infinity,
      height: 50,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red[600],
                    shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
          _showLogoutDialog();
                  },
                  icon: const Icon(Icons.logout, color: Colors.white),
                  label: const Text(
                    'Çıkış Yap',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
    );
  }

  // Yardımcı Widget'lar
  Widget _profileActionButton(IconData icon, String label) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: OutlinedButton.icon(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.white),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 8),
          ),
          onPressed: () {},
          icon: Icon(icon, color: Colors.white, size: 16),
          label: Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
        ),
      ),
    );
  }

  Widget _statItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Color(AppConstants.primaryColorValue), size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _settingsTile({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
    Widget? trailing,
    String? subtitle,
    bool centerTitle = false,
  }) {
    return ListTile(
      leading: Icon(icon, color: Color(AppConstants.primaryColorValue)),
      title: centerTitle
          ? Center(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)))
          : Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: subtitle != null && subtitle.isNotEmpty ? Text(subtitle, style: const TextStyle(color: Colors.grey)) : null,
      trailing: trailing,
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
    );
  }

  Widget _divider() {
    return const Divider(height: 1, indent: 56);
  }



  Widget _verificationBadge(bool verified) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
        color: verified ? Colors.green : Colors.orange,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            verified ? Icons.check_circle : Icons.error,
            color: Colors.white,
            size: 12,
          ),
          const SizedBox(width: 2),
          Text(
            verified ? '✓' : '!',
            style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ],
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