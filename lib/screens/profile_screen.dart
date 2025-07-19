import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_constants.dart';
import '../providers/auth_provider.dart';
import '../widgets/custom_button.dart';
import 'login_screen.dart';

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
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          final user = authProvider.currentUser;
          if (user == null) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFE53E3E),
              ),
            );
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Profil Kartı
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
                        ClipOval(
                          child: Container(
                            width: 100,
                            height: 100,
                            child: user.profileImage != null
                                ? Image.network(
                                    user.profileImage!,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          color: Color(AppConstants.primaryColorValue).withOpacity(0.1),
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
                                        width: 100,
                                        height: 100,
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
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: Color(AppConstants.primaryColorValue),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(Icons.person, size: 50, color: Colors.white),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Kullanıcı Adı
                        Text(
                          user.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF111111),
                          ),
                        ),
                        const SizedBox(height: 8),
                        // E-posta
                        Text(
                          user.email,
                          style: TextStyle(
                            fontSize: 16,
                            color: const Color(0xFF444444),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Online Durumu
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: user.isOnline
                                ? const Color(AppConstants.primaryColorValue).withOpacity(0.1)
                                : Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: user.isOnline
                                  ? const Color(AppConstants.primaryColorValue)
                                  : Colors.grey,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                user.isOnline ? Icons.circle : Icons.circle_outlined,
                                size: 12,
                                color: user.isOnline
                                    ? const Color(AppConstants.primaryColorValue)
                                    : Colors.grey,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                user.isOnline ? 'Çevrimiçi' : 'Çevrimdışı',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: user.isOnline
                                      ? const Color(AppConstants.primaryColorValue)
                                      : Colors.grey,
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
                        user.totalTrips.toString(),
                        Icons.directions_car,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard(
                        'Puan',
                        user.rating.toStringAsFixed(1),
                        Icons.star,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Bilgi Kartları
                _buildInfoCard(
                  'Kişisel Bilgiler',
                  [
                    _buildInfoRow('Telefon', user.phone),
                    if (user.licenseNumber != null)
                      _buildInfoRow('Ehliyet No', user.licenseNumber!),
                    if (user.vehicleModel != null)
                      _buildInfoRow('Araç Modeli', user.vehicleModel!),
                    if (user.vehiclePlate != null)
                      _buildInfoRow('Plaka', user.vehiclePlate!),
                  ],
                ),
                const SizedBox(height: 16),
                _buildInfoCard(
                  'Hesap Bilgileri',
                  [
                    _buildInfoRow('Üyelik Tarihi', 
                      '${user.createdAt.day}.${user.createdAt.month}.${user.createdAt.year}'),
                    _buildInfoRow('Son Güncelleme', 
                      '${user.updatedAt.day}.${user.updatedAt.month}.${user.updatedAt.year}'),
                  ],
                ),
                const SizedBox(height: 24),
                // Aksiyon Butonları
                ElevatedButton.icon(
                  icon: Icon(Icons.edit, color: Color(0xFF111111)),
                  label: Text('Profili Düzenle', style: TextStyle(color: Color(0xFF111111))),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(AppConstants.primaryColorValue),
                    foregroundColor: Color(0xFF111111),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  onPressed: () {},
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
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
                  onPressed: () {},
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  icon: Icon(Icons.help, color: Color(0xFF111111)),
                  label: Text('Yardım', style: TextStyle(color: Color(0xFF111111))),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(AppConstants.primaryColorValue),
                    foregroundColor: Color(0xFF111111),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          );
        },
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
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
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