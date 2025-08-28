import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String selectedLanguage = 'Türkçe';
  bool pushNotifications = true;
  bool emailNotifications = false;
  bool smsNotifications = true;
  bool locationAccess = true;
  bool darkMode = false;
  bool autoAcceptTrips = false;
  
  final List<String> languages = ['Türkçe', 'English', 'Deutsch', 'Français'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(AppConstants.backgroundColorValue),
      appBar: AppBar(
        title: Text('Ayarlar'),
        backgroundColor: Color(AppConstants.primaryColorValue),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Uygulama Ayarları
            _buildSettingsSection(
              'Uygulama Ayarları',
              [
                _buildLanguageSelector(),
                _buildSwitchTile(
                  'Karanlık Mod', 
                  'Koyu tema kullan',
                  darkMode, 
                  Icons.dark_mode,
                  (value) => setState(() => darkMode = value),
                ),
                _buildSwitchTile(
                  'Otomatik Seyahat Kabul', 
                  'Uygun seyahatleri otomatik kabul et',
                  autoAcceptTrips, 
                  Icons.auto_mode,
                  (value) => setState(() => autoAcceptTrips = value),
                ),
              ],
            ),
            
            SizedBox(height: 24),
            
            // Bildirim Ayarları
            _buildSettingsSection(
              'Bildirim Ayarları',
              [
                _buildSwitchTile(
                  'Push Bildirimleri', 
                  'Anlık bildirimler al',
                  pushNotifications, 
                  Icons.notifications,
                  (value) => setState(() => pushNotifications = value),
                ),
                _buildSwitchTile(
                  'E-posta Bildirimleri', 
                  'E-posta ile bildirim al',
                  emailNotifications, 
                  Icons.email,
                  (value) => setState(() => emailNotifications = value),
                ),
                _buildSwitchTile(
                  'SMS Bildirimleri', 
                  'SMS ile bildirim al',
                  smsNotifications, 
                  Icons.sms,
                  (value) => setState(() => smsNotifications = value),
                ),
              ],
            ),
            
            SizedBox(height: 24),
            
            // Gizlilik ve Güvenlik
            _buildSettingsSection(
              'Gizlilik ve Güvenlik',
              [
                _buildSwitchTile(
                  'Konum Erişimi', 
                  'Konum servislerini kullan',
                  locationAccess, 
                  Icons.location_on,
                  (value) => setState(() => locationAccess = value),
                ),
                _buildNavigationTile(
                  'Veri ve Gizlilik',
                  'Veri kullanımı ve gizlilik ayarları',
                  Icons.privacy_tip,
                  () => _showPrivacyDialog(),
                ),
                _buildNavigationTile(
                  'KVKK Aydınlatma Metni',
                  'Kişisel verilerin korunması',
                  Icons.description,
                  () => _showKVKKDialog(),
                ),
              ],
            ),
            
            SizedBox(height: 24),
            
            // Hesap Ayarları
            _buildSettingsSection(
              'Hesap Ayarları',
              [
                _buildNavigationTile(
                  'Şifre Değiştir',
                  'Hesap şifrenizi güncelleyin',
                  Icons.lock,
                  () => _showChangePasswordDialog(),
                ),
                _buildNavigationTile(
                  'Hesabı Sil',
                  'Hesabınızı kalıcı olarak silin',
                  Icons.delete_forever,
                  () => _showDeleteAccountDialog(),
                  isDestructive: true,
                ),
              ],
            ),
            
            SizedBox(height: 24),
            
            // Yardım ve Destek
            _buildSettingsSection(
              'Yardım ve Destek',
              [
                _buildNavigationTile(
                  'Yardım Merkezi',
                  'SSS ve yardım konuları',
                  Icons.help,
                  () => _openHelpCenter(),
                ),
                _buildNavigationTile(
                  'İletişim',
                  'Bizimle iletişime geçin',
                  Icons.contact_support,
                  () => _openContact(),
                ),
                _buildNavigationTile(
                  'Uygulama Hakkında',
                  'Versiyon ve yasal bilgiler',
                  Icons.info,
                  () => _showAboutDialog(),
                ),
              ],
            ),
            
            SizedBox(height: 32),
            
            // Çıkış yap butonu
            _buildLogoutButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(AppConstants.textPrimaryColorValue),
          ),
        ),
        SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildLanguageSelector() {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Color(AppConstants.primaryColorValue).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          Icons.language,
          color: Color(AppConstants.primaryColorValue),
          size: 20,
        ),
      ),
      title: Text(
        'Uygulama Dili',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Color(AppConstants.textPrimaryColorValue),
        ),
      ),
      subtitle: Text(
        selectedLanguage,
        style: TextStyle(
          color: Color(AppConstants.textSecondaryColorValue),
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Color(AppConstants.textSecondaryColorValue),
      ),
      onTap: () => _showLanguageDialog(),
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    bool value,
    IconData icon,
    Function(bool) onChanged,
  ) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Color(AppConstants.primaryColorValue).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: Color(AppConstants.primaryColorValue),
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Color(AppConstants.textPrimaryColorValue),
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: Color(AppConstants.textSecondaryColorValue),
          fontSize: 12,
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Color(AppConstants.primaryColorValue),
      ),
    );
  }

  Widget _buildNavigationTile(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: (isDestructive ? Colors.red : Color(AppConstants.primaryColorValue)).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: isDestructive ? Colors.red : Color(AppConstants.primaryColorValue),
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: isDestructive ? Colors.red : Color(AppConstants.textPrimaryColorValue),
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: Color(AppConstants.textSecondaryColorValue),
          fontSize: 12,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Color(AppConstants.textSecondaryColorValue),
      ),
      onTap: onTap,
    );
  }

  Widget _buildLogoutButton() {
    return Container(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: Icon(Icons.logout, color: Colors.white),
        label: Text(
          'Çıkış Yap',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        onPressed: () => _showLogoutDialog(),
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Uygulama Dili'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: languages.map((language) => RadioListTile<String>(
            title: Text(language),
            value: language,
            groupValue: selectedLanguage,
            onChanged: (value) {
              setState(() => selectedLanguage = value!);
              Navigator.pop(context);
            },
            activeColor: Color(AppConstants.primaryColorValue),
          )).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('İptal'),
          ),
        ],
      ),
    );
  }

  void _showPrivacyDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Veri ve Gizlilik'),
        content: SingleChildScrollView(
          child: Text(
            'Kişisel verileriniz güvenliğiniz için şifrelenerek saklanmaktadır. '
            'Verileriniz sadece hizmet kalitesini artırmak için kullanılır ve '
            'üçüncü şahıslarla paylaşılmaz.\n\n'
            'Konum verileriniz sadece seyahat sırasında kullanılır ve '
            'seyahat sonunda silinir.',
            style: TextStyle(height: 1.5),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Tamam'),
          ),
        ],
      ),
    );
  }

  void _showKVKKDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('KVKK Aydınlatma Metni'),
        content: SingleChildScrollView(
          child: Text(
            'KİŞİSEL VERİLERİN KORUNMASI KANUNU KAPSAMINDA AYDINLATMA METNİ\n\n'
            'Kişisel verileriniz, 6698 sayılı Kişisel Verilerin Korunması Kanunu '
            'kapsamında işlenmektedir.\n\n'
            'Veri Sorumlusu: Şöför Uygulaması\n'
            'İletişim: info@soforapp.com\n\n'
            'Kişisel verileriniz:\n'
            '• Hizmet sunumu\n'
            '• Güvenlik\n'
            '• İletişim\n'
            'amaçlarıyla işlenmektedir.\n\n'
            'Haklarınız:\n'
            '• Bilgi talep etme\n'
            '• Düzeltme isteme\n'
            '• Silme talep etme\n'
            '• İtiraz etme',
            style: TextStyle(height: 1.5, fontSize: 12),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Tamam'),
          ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog() {
    final _currentPasswordController = TextEditingController();
    final _newPasswordController = TextEditingController();
    final _confirmPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Şifre Değiştir'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _currentPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Mevcut Şifre',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _newPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Yeni Şifre',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Yeni Şifre Tekrar',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Şifre değiştirme işlemi
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Şifre başarıyla değiştirildi')),
              );
            },
            child: Text('Değiştir'),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Hesabı Sil'),
        content: Text(
          'Hesabınızı silmek istediğinizden emin misiniz? '
          'Bu işlem geri alınamaz ve tüm verileriniz silinecektir.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Hesap silme işlemi
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Sil', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Çıkış Yap'),
        content: Text('Hesabınızdan çıkış yapmak istediğinizden emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Çıkış yapma işlemi
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Çıkış Yap', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _openHelpCenter() {
    // TODO: Yardım merkezi sayfasını aç
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Yardım merkezi açılıyor...')),
    );
  }

  void _openContact() {
    // TODO: İletişim sayfasını aç
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('İletişim sayfası açılıyor...')),
    );
  }

  void _showAboutDialog() {
    showAboutDialog(
      context: context,
      applicationName: 'Şöför Uygulaması',
      applicationVersion: '1.0.0',
      applicationLegalese: '© 2024 Şöför Uygulaması. Tüm hakları saklıdır.',
      children: [
        Text('Şöförler için geliştirilmiş modern uygulama.'),
      ],
    );
  }
}