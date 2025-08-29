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
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          // Modern App Bar
          SliverAppBar(
            expandedHeight: 120,
            floating: false,
            pinned: true,
            backgroundColor: Color(AppConstants.primaryColorValue),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Profil',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
            ),
          ),
          
          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Modern Profil Kartı
                  _buildModernProfileCard(),
                  SizedBox(height: 16),
                  
                                // Compact Stats
              _buildCompactStats(),
              SizedBox(height: 16),
                  
                  // Vehicle Information
                  _buildVehicleInfo(),
                  SizedBox(height: 16),
                  
                  // Quick Actions
                  _buildQuickActions(context),
                  SizedBox(height: 16),
                  
                  // Account Settings
                  _buildAccountSettings(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernProfileCard() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Profil Resmi ve Temel Bilgiler
          Row(
            children: [
              // Profil Fotoğrafı
              Stack(
                children: [
                  ClipOval(
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Color(AppConstants.primaryColorValue),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.person, size: 35, color: Colors.white),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Icon(Icons.verified, color: Colors.white, size: 12),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 16),
              
              // Şöför Bilgileri
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ahmet Yılmaz',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(AppConstants.textPrimaryColorValue),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'ahmet.yilmaz@sofor.com',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(AppConstants.textSecondaryColorValue),
                      ),
                    ),
                    SizedBox(height: 8),
                    // Müsaitlik Durumu
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 6),
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
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCompactStats() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(child: _buildCompactStatItem('127', 'Sefer', Icons.directions_car, Colors.blue)),
          Container(width: 1, height: 40, color: Colors.grey[200]),
          Expanded(child: _buildCompactStatItem('4.8', 'Puan', Icons.star, Colors.amber)),
          Container(width: 1, height: 40, color: Colors.grey[200]),
          Expanded(child: _buildCompactStatItem('5 Yıl', 'Deneyim', Icons.work, Colors.purple)),
        ],
      ),
    );
  }

  Widget _buildCompactStatItem(String value, String label, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 20),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(AppConstants.textPrimaryColorValue),
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Color(AppConstants.textSecondaryColorValue),
          ),
        ),
      ],
    );
  }

  Widget _buildModernStatCard(String value, String label, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(AppConstants.textPrimaryColorValue),
                  ),
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(AppConstants.textSecondaryColorValue),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hızlı İşlemler',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(AppConstants.textPrimaryColorValue),
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  'Düzenle',
                  Icons.edit,
                  Color(AppConstants.primaryColorValue),
                  () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileEditScreen())),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _buildActionButton(
                  'Yorumlar',
                  Icons.star,
                  Colors.amber,
                  () => Navigator.push(context, MaterialPageRoute(builder: (context) => ReviewsScreen())),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _buildActionButton(
                  'Performans',
                  Icons.analytics,
                  Colors.green,
                  () => Navigator.push(context, MaterialPageRoute(builder: (context) => PerformanceAnalyticsScreen())),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 20),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountSettings(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hesap',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(AppConstants.textPrimaryColorValue),
            ),
          ),
          SizedBox(height: 12),
          _buildSettingItem(
            'Ayarlar',
            Icons.settings,
            () => Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen())),
          ),
          _buildSettingItem(
            'Yardım & Destek',
            Icons.help_outline,
            () {},
          ),

          Divider(),
          _buildSettingItem(
            'Çıkış Yap',
            Icons.logout,
            () => _showLogoutDialog(context),
            isDestructive: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(String title, IconData icon, VoidCallback onTap, {bool isDestructive = false}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        icon, 
        color: isDestructive ? Colors.red : Color(AppConstants.textSecondaryColorValue),
        size: 20,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          color: isDestructive ? Colors.red : Color(AppConstants.textPrimaryColorValue),
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: Color(AppConstants.textSecondaryColorValue),
        size: 18,
      ),
      onTap: onTap,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Çıkış Yap'),
          content: Text('Hesabınızdan çıkış yapmak istediğinizden emin misiniz?'),
          actions: [
            TextButton(
              child: Text('İptal'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Çıkış Yap', style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop();
                Provider.of<AuthProvider>(context, listen: false).logout();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildVehicleInfo() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(AppConstants.primaryColorValue).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.directions_car,
                  color: Color(AppConstants.primaryColorValue),
                  size: 24,
                ),
              ),
              SizedBox(width: 12),
              Text(
                'Araç Bilgileri',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(AppConstants.textPrimaryColorValue),
                ),
              ),
            ],
          ),
          
          SizedBox(height: 20),
          
          // Vehicle Photo Gallery
          Container(
            height: 180,
            child: Column(
              children: [
                // Gallery
                Expanded(
                  child: PageView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(AppConstants.primaryColorValue).withOpacity(0.1),
                              Color(AppConstants.accentColorValue).withOpacity(0.1),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Color(AppConstants.primaryColorValue).withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.directions_car,
                              size: 50,
                              color: Color(AppConstants.primaryColorValue).withOpacity(0.7),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Araç Fotoğrafı ${index + 1}',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(AppConstants.primaryColorValue),
                              ),
                            ),
                            Text(
                              'Mercedes C200',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(AppConstants.textSecondaryColorValue),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 8),
                // Page Indicators
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(10, (index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: index == 0 
                          ? Color(AppConstants.primaryColorValue) 
                          : Color(AppConstants.primaryColorValue).withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
          
          SizedBox(height: 20),
          
          // Vehicle Details Grid
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 2.5,
            children: [
              _buildVehicleDetailCard('Marka/Model', 'Mercedes C200', Icons.car_rental),
              _buildVehicleDetailCard('Plaka', '34 ABC 123', Icons.confirmation_number),
              _buildVehicleDetailCard('Yıl', '2020', Icons.calendar_today),
              _buildVehicleDetailCard('Renk', 'Siyah', Icons.palette),
              _buildVehicleDetailCard('Yakıt Tipi', 'Dizel', Icons.local_gas_station),
              _buildVehicleDetailCard('Koltuk Sayısı', '4+1', Icons.airline_seat_recline_normal),
            ],
          ),
          
          SizedBox(height: 16),
          
          // Vehicle Features
          Container(
            padding: EdgeInsets.all(12), // 16'dan 12'ye
            decoration: BoxDecoration(
              color: Color(AppConstants.primaryColorValue).withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Color(AppConstants.primaryColorValue).withOpacity(0.1),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Araç Özellikleri',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(AppConstants.textPrimaryColorValue),
                  ),
                ),
                SizedBox(height: 8), // 12'den 8'e
                Wrap(
                  spacing: 6, // 8'den 6'ya
                  runSpacing: 6, // 8'den 6'ya
                  children: [
                    _buildFeatureChip('Klima', Icons.ac_unit, Colors.blue),
                    _buildFeatureChip('GPS', Icons.navigation, Colors.green),
                    _buildFeatureChip('Bluetooth', Icons.bluetooth, Colors.purple),
                    _buildFeatureChip('USB Şarj', Icons.usb, Colors.orange),
                    _buildFeatureChip('Wi-Fi', Icons.wifi, Colors.teal),
                    _buildFeatureChip('Kamera', Icons.videocam, Colors.red), // Daha kısa isim
                    _buildFeatureChip('Navigasyon', Icons.map, Colors.indigo),
                    _buildFeatureChip('Müzik', Icons.music_note, Colors.pink),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleDetailCard(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Color(AppConstants.primaryColorValue).withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: Color(AppConstants.primaryColorValue),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(AppConstants.textPrimaryColorValue),
                  ),
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(AppConstants.textSecondaryColorValue),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureChip(String label, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), // Daha küçük padding
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16), // Daha küçük radius
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14, // 16'dan 14'e
            color: color,
          ),
          SizedBox(width: 4), // 6'dan 4'e
          Text(
            label,
            style: TextStyle(
              fontSize: 10, // 12'den 10'a
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}