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
      backgroundColor: const Color(AppConstants.backgroundColorValue),
      appBar: AppBar(
        title: const Text(
          'Profil',
          style: TextStyle(
            color: Color(AppConstants.textColorValue),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Color(AppConstants.errorColorValue)),
            onPressed: () => _showLogoutDialog(context),
          ),
        ],
      ),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          final user = authProvider.currentUser;
          
          if (user == null) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(AppConstants.primaryColorValue),
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
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        // Profil Fotoğrafı
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: const Color(AppConstants.primaryColorValue),
                          backgroundImage: user.profileImage != null
                              ? NetworkImage(user.profileImage!)
                              : null,
                          child: user.profileImage == null
                              ? const Icon(Icons.person, size: 50, color: Colors.white)
                              : null,
                        ),
                        const SizedBox(height: 16),
                        
                        // Kullanıcı Adı
                        Text(
                          user.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(AppConstants.textColorValue),
                          ),
                        ),
                        const SizedBox(height: 8),
                        
                        // E-posta
                        Text(
                          user.email,
                          style: TextStyle(
                            fontSize: 16,
                            color: const Color(AppConstants.textColorValue).withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        // Online Durumu
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: user.isOnline
                                ? const Color(AppConstants.successColorValue).withOpacity(0.1)
                                : Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: user.isOnline
                                  ? const Color(AppConstants.successColorValue)
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
                                    ? const Color(AppConstants.successColorValue)
                                    : Colors.grey,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                user.isOnline ? 'Çevrimiçi' : 'Çevrimdışı',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: user.isOnline
                                      ? const Color(AppConstants.successColorValue)
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
                CustomButton(
                  text: 'Profili Düzenle',
                  onPressed: () {
                    // TODO: Profil düzenleme ekranına git
                  },
                  icon: Icons.edit,
                ),
                const SizedBox(height: 12),
                
                CustomButton(
                  text: 'Ayarlar',
                  onPressed: () {
                    // TODO: Ayarlar ekranına git
                  },
                  icon: Icons.settings,
                  backgroundColor: Colors.grey[600],
                ),
                const SizedBox(height: 12),
                
                CustomButton(
                  text: 'Yardım',
                  onPressed: () {
                    // TODO: Yardım ekranına git
                  },
                  icon: Icons.help,
                  backgroundColor: const Color(AppConstants.accentColorValue),
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
                color: Color(AppConstants.textColorValue),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: const Color(AppConstants.textColorValue).withOpacity(0.6),
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
                color: Color(AppConstants.textColorValue),
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
              color: const Color(AppConstants.textColorValue).withOpacity(0.7),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(AppConstants.textColorValue),
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
            child: const Text(
              'Çıkış Yap',
              style: TextStyle(color: Color(AppConstants.errorColorValue)),
            ),
          ),
        ],
      ),
    );
  }
} 