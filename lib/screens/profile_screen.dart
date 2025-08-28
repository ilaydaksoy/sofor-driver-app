import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_constants.dart';
import '../providers/auth_provider.dart';
import '../widgets/custom_button.dart';
import 'login_screen.dart';
import 'profile_edit_screen.dart';
import 'performance_analytics_screen.dart';
import 'settings_screen.dart';
import 'reviews_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(AppConstants.primaryColorValue),
      appBar: AppBar(
        backgroundColor: Color(0xFF111111),
        foregroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          'Profil',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Şöför Profil Kartı
            Card(
              elevation: 2,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    // Profil Fotoğrafı
                    Stack(
                      children: [
                        ClipOval(
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Color(AppConstants.primaryColorValue),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.person, size: 50, color: Colors.white),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: Icon(Icons.verified, color: Colors.white, size: 16),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Şöför Adı
                    Text(
                      'Ahmet Yılmaz',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF111111),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // E-posta
                    Text(
                      'ahmet.yilmaz@sofor.com',
                      style: TextStyle(
                        fontSize: 16,
                        color: const Color(0xFF444444),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Müsaitlik Durumu
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.green),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.circle, size: 12, color: Colors.green),
                          const SizedBox(width: 6),
                          Text(
                            'Müsait',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // İstatistikler
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Toplam Sefer',
                    '127',
                    Icons.directions_car,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    'Puan',
                    '4.8',
                    Icons.star,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Bu Ay Kazanç',
                    '12.800 TL',
                    Icons.account_balance_wallet,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    'Deneyim',
                    '5 Yıl',
                    Icons.work,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Kişisel Bilgiler (Belgeye Göre)
            _buildInfoCard(
              'Kişisel Bilgiler',
              [
                _buildInfoRow('Telefon', '+90 555 123 4567'),
                _buildInfoRow('Ehliyet No', 'E-123456789'),
                _buildInfoRow('Ehliyet Tarihi', '15.03.2019'),
                _buildInfoRow('Deneyim Süresi', '5 Yıl'),
                _buildInfoRow('Doğum Tarihi', '12.05.1985'),
                _buildInfoRow('Şehir', 'İstanbul'),
                _buildPersonalIntroduction(),
              ],
            ),
            const SizedBox(height: 16),
            // Araç Detayları (Belgeye Göre)
            _buildInfoCard(
              'Araç Detayları',
              [
                _buildInfoRow('Marka/Model', 'Mercedes C200'),
                _buildInfoRow('Plaka', '34 ABC 123'),
                _buildInfoRow('Renk', 'Siyah'),
                _buildInfoRow('Yıl', '2020'),
                _buildInfoRow('Yakıt Tipi', 'Dizel'),
                _buildInfoRow('Koltuk Sayısı', '4+1'),
                _buildInfoRow('Klima', 'Var'),
                _buildInfoRow('Bagaj Hacmi', 'Büyük'),
              ],
            ),
            const SizedBox(height: 16),
            // Dil Yetkinlikleri (Belgeye Göre)
            _buildInfoCard(
              'Dil Yetkinlikleri',
              [
                _buildLanguageChips(['Türkçe', 'İngilizce', 'Almanca']),
                SizedBox(height: 8),
                Text(
                  'Konuşma düzeyleri belirlenmesi',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(AppConstants.textSecondaryColorValue),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Başvuru Sistemi (Belgeye Göre)
            _buildInfoCard(
              'Başvuru Sistemi',
              [
                _buildStatusRow('Platform Onayı', 'Onaylandı', true),
                _buildInfoRow('Onay Tarihi', '15.03.2020'),
                _buildInfoRow('Son Güncelleme', '28.11.2024'),
                _buildInfoRow('Hesap Tipi', 'Bireysel'),
                _buildInfoRow('Durum', 'Aktif'),
              ],
            ),
            const SizedBox(height: 16),
            // Performans İstatistikleri
            _buildInfoCard(
              'Performans İstatistikleri',
              [
                _buildInfoRow('Profil Görüntülenme', '1,247 kez'),
                _buildInfoRow('Mesaj Yanıt Oranı', '%98'),
                _buildInfoRow('Ortalama Yanıt Süresi', '5 dakika'),
                _buildInfoRow('Müşteri Memnuniyeti', '4.8/5.0'),
              ],
            ),
            const SizedBox(height: 24),
            // Aksiyon Butonları
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.edit, color: Color(0xFF111111)),
                    label: Text('Düzenle', style: TextStyle(color: Color(0xFF111111))),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(AppConstants.primaryColorValue),
                      foregroundColor: Color(0xFF111111),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfileEditScreen()),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.settings, color: Colors.white),
                    label: Text('Ayarlar', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF111111),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SettingsScreen()),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.rate_review, color: Color(0xFF111111)),
                    label: Text('Yorumlar', style: TextStyle(color: Color(0xFF111111))),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(AppConstants.primaryColorValue),
                      foregroundColor: Color(0xFF111111),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ReviewsScreen()),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.help, color: Colors.white),
                    label: Text('Yardım', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF111111),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              icon: Icon(Icons.logout, color: Colors.white),
              label: Text('Çıkış Yap', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
                minimumSize: Size(double.infinity, 48),
              ),
              onPressed: () => _showLogoutDialog(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(
              icon,
              color: const Color(AppConstants.primaryColorValue),
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF111111),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: const Color(0xFF444444),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF111111),
              ),
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: const Color(0xFF444444),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF111111),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageChips(List<String> languages) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: languages.map((language) => Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Color(AppConstants.primaryColorValue).withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Color(AppConstants.primaryColorValue).withOpacity(0.3),
          ),
        ),
        child: Text(
          language,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(AppConstants.primaryColorValue),
          ),
        ),
      )).toList(),
    );
  }

  Widget _buildPersonalIntroduction() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12),
        Text(
          'Kişisel Tanıtım',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(AppConstants.textPrimaryColorValue),
          ),
        ),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Text(
            'Merhaba! Ben Ahmet, 5 yıllık tecrübeli bir şöförüm. Güvenli ve konforlu seyahatler için bana ulaşabilirsiniz. İngilizce ve Almanca konuşabiliyorum.',
            style: TextStyle(
              fontSize: 13,
              color: Color(AppConstants.textPrimaryColorValue),
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusRow(String label, String value, bool isPositive) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: const Color(0xFF444444),
            ),
          ),
          Row(
            children: [
              Icon(
                isPositive ? Icons.check_circle : Icons.cancel,
                size: 16,
                color: isPositive ? Colors.green : Colors.red,
              ),
              SizedBox(width: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isPositive ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Çıkış Yap'),
        content: const Text('Hesabınızdan çıkış yapmak istediğinizden emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              final authProvider = Provider.of<AuthProvider>(context, listen: false);
              await authProvider.logout();
              if (context.mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false,
                );
              }
            },
            child: Text(
              'Çıkış Yap',
              style: TextStyle(color: Color(AppConstants.primaryColorValue)),
            ),
          ),
        ],
      ),
    );
  }
} 