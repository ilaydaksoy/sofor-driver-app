import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_constants.dart';
import '../providers/auth_provider.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _showFAQ = false;
  bool isEmailVerified = true;
  bool isPhoneVerified = false;
  String? get profileImagePath => Provider.of<AuthProvider>(context, listen: false).currentUser?.profileImage ?? 'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=150&h=150&fit=crop&crop=face';
  
  // Ayarlar için state değişkenleri
  bool _notificationsEnabled = true;
  bool _locationEnabled = true;
  bool _darkModeEnabled = false;
  String _selectedLanguage = 'Türkçe';
  String _selectedCurrency = 'TL';
  bool _biometricEnabled = false;
  bool _autoLoginEnabled = true;
  
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

  final List<Map<String, String>> faqs = [
    {
      'question': 'Uygulama nasıl çalışıyor?',
      'answer': 'Turistler ve sürücüler uygulama üzerinden iletişim kurabilir. Konumunuzu belirleyin, sürücü seçin ve güvenle seyahat edin.'
    },
    {
      'question': 'Ödeme nasıl yapılır?',
      'answer': 'Nakit, kredi kartı veya uygulama içi cüzdan ile ödeme yapabilirsiniz. Tüm ödemeler güvenli şekilde işlenir.'
    },
    {
      'question': 'Sürücü seçimi nasıl yapılır?',
      'answer': 'Size yakın sürücüler listelenir. Puanları, araç bilgileri ve fiyatları görebilir, tercih ettiğiniz sürücüyü seçebilirsiniz.'
    },
    {
      'question': 'Güvenlik nasıl sağlanır?',
      'answer': 'Tüm sürücüler kimlik doğrulaması yapılmıştır. Seyahat sırasında konum paylaşımı ve acil durum butonu mevcuttur.'
    },
    {
      'question': 'İptal işlemi nasıl yapılır?',
      'answer': 'Sürücü gelmeden önce ücretsiz iptal edebilirsiniz. Sürücü yola çıktıktan sonra iptal ücreti uygulanabilir.'
    },
    {
      'question': 'Destek ile nasıl iletişime geçerim?',
      'answer': 'Destek için info@turist.com adresine mail atabilir veya uygulama içi destek hattını kullanabilirsiniz.'
    },
  ];

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
              // Profil Kartı
            _buildProfileCard(),
            const SizedBox(height: 16),
            
            // Hızlı İstatistikler
            _buildQuickStats(),
            const SizedBox(height: 16),
            
            // Hesap Ayarları
            _buildAccountSettings(),
            const SizedBox(height: 16),
            
            // Güvenlik Ayarları
            _buildSecuritySettings(),
            const SizedBox(height: 16),
            
            // Bildirim Ayarları
            _buildNotificationSettings(),
            const SizedBox(height: 16),
            
            // Uygulama Ayarları
            _buildAppSettings(),
            const SizedBox(height: 16),
            
            // SSS Bölümü
            _buildFAQSection(),
            const SizedBox(height: 16),
            
            // Destek ve İletişim
            _buildSupportSection(),
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
            subtitle: 'Ad, soyad, doğum tarihi',
            onTap: () {},
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          _divider(),
          _settingsTile(
            icon: Icons.email,
            title: 'E-posta Adresi',
            subtitle: 'demo@turist.com',
            onTap: () {},
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          _divider(),
          _settingsTile(
            icon: Icons.phone,
            title: 'Telefon Numarası',
            subtitle: '+90 555 123 4567',
            onTap: () {},
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          _divider(),
          _settingsTile(
            icon: Icons.lock,
            title: 'Şifre Değiştir',
            subtitle: 'Güvenlik için şifrenizi güncelleyin',
            onTap: () {},
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ],
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

  Widget _buildAppSettings() {
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
            icon: Icons.language,
            title: 'Dil',
            subtitle: _selectedLanguage,
            onTap: () {
              _showLanguageDialog();
            },
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          _divider(),
          _settingsTile(
            icon: Icons.attach_money,
            title: 'Para Birimi',
            subtitle: _selectedCurrency,
            onTap: () {
              _showCurrencyDialog();
            },
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          _divider(),
          _settingsTile(
            icon: Icons.dark_mode,
            title: 'Karanlık Mod',
            subtitle: 'Karanlık tema kullan',
            onTap: () {},
            trailing: Switch(
              value: _darkModeEnabled,
              onChanged: (value) {
                setState(() {
                  _darkModeEnabled = value;
                });
              },
            ),
          ),
          _divider(),
          _settingsTile(
            icon: Icons.auto_awesome,
            title: 'Otomatik Giriş',
            subtitle: 'Uygulama açıldığında otomatik giriş',
            onTap: () {},
            trailing: Switch(
              value: _autoLoginEnabled,
              onChanged: (value) {
                setState(() {
                  _autoLoginEnabled = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQSection() {
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
                    InkWell(
                      onTap: () {
                        setState(() {
                          _showFAQ = !_showFAQ;
                        });
                      },
            child: Padding(
              padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.help_outline, color: Color(AppConstants.primaryColorValue)),
                      SizedBox(width: 12),
                              Text(
                                'Sıkça Sorulan Sorular',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ],
                          ),
                          Icon(_showFAQ ? Icons.expand_less : Icons.expand_more, color: Color(AppConstants.primaryColorValue)),
                        ],
                      ),
                    ),
          ),
          if (_showFAQ) ...[
            _divider(),
                      ...faqs.map((faq) => _faqTile(faq['question']!, faq['answer']!)).toList(),
                  ],
        ],
      ),
    );
  }

  Widget _buildSupportSection() {
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
            icon: Icons.support_agent,
            title: 'Müşteri Desteği',
            subtitle: '7/24 canlı destek',
            onTap: () {},
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          _divider(),
          _settingsTile(
            icon: Icons.email,
            title: 'E-posta Desteği',
            subtitle: 'info@turist.com',
            onTap: () {},
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          _divider(),
          _settingsTile(
            icon: Icons.phone,
            title: 'Telefon Desteği',
            subtitle: '+90 212 123 4567',
            onTap: () {},
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          _divider(),
          _settingsTile(
            icon: Icons.info,
            title: 'Hakkında',
            subtitle: 'Uygulama bilgileri',
            onTap: () {},
            trailing: Icon(Icons.arrow_forward_ios),
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
    required String subtitle,
    required VoidCallback onTap,
    required Widget trailing,
  }) {
    return ListTile(
      leading: Icon(icon, color: Color(AppConstants.primaryColorValue)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey)),
      trailing: trailing,
      onTap: onTap,
    );
  }

  Widget _divider() {
    return const Divider(height: 1, indent: 56);
  }

  Widget _faqTile(String question, String answer) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87),
          ),
          const SizedBox(height: 4),
          Text(
            answer,
            style: const TextStyle(color: Colors.black54, fontSize: 13),
          ),
        ],
      ),
    );
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

  // Dialog'lar
  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Dil Seçin'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ['Türkçe', 'English', 'Deutsch', 'Français', 'Español']
              .map((lang) => ListTile(
                    title: Text(lang),
                    onTap: () {
                      setState(() {
                        _selectedLanguage = lang;
                      });
                      Navigator.pop(context);
                    },
                  ))
              .toList(),
        ),
      ),
    );
  }

  void _showCurrencyDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Para Birimi Seçin'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ['TL', 'USD', 'EUR', 'GBP']
              .map((currency) => ListTile(
                    title: Text(currency),
                    onTap: () {
                      setState(() {
                        _selectedCurrency = currency;
                      });
                      Navigator.pop(context);
                    },
                  ))
              .toList(),
        ),
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
              // Çıkış işlemi
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Çıkış Yap', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
} 