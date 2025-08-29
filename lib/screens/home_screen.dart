import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import 'chat_screen.dart';
import 'notifications_screen.dart';
import 'profile_screen.dart';
import 'driver_profile_screen.dart';
import 'home_screen_functions.dart'; // Added for quick actions
import 'dart:async'; // Added for Timer

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  
  final List<Widget> _screens = [
    _HomeContent(),
    ChatScreen(),
    NotificationsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(AppConstants.backgroundColorValue),
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color(AppConstants.surfaceColorValue),
          boxShadow: [
            BoxShadow(
              color: Color(AppConstants.shadowLightColorValue).withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color(AppConstants.surfaceColorValue),
          selectedItemColor: Color(AppConstants.primaryColorValue),
          unselectedItemColor: Color(AppConstants.textSecondaryColorValue),
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
          unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Ana Sayfa',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_outlined),
              activeIcon: Icon(Icons.chat),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_outlined),
              activeIcon: Icon(Icons.notifications),
              label: 'Bildirimler',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeContent extends StatefulWidget {
  @override
  State<_HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<_HomeContent> {
  bool isAvailable = true;
  String workingStatus = 'Müsait';
  int todayTrips = 3;
  double todayEarnings = 450.0;
  double weeklyEarnings = 2450.0;
  double rating = 4.8;
  int totalTrips = 127;
  RangeValues priceRange = RangeValues(50, 300);
  double selectedRating = 0.0;
  String selectedLanguage = 'Tümü';
  
  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) => _buildFilterDialog(),
    );
  }

  Widget _buildFilterDialog() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Filtreler',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(AppConstants.textPrimaryColorValue),
                  ),
                ),
                const SizedBox(height: 20),
                
                // Şehir Seçimi
                Text(
                  'Şehir',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(AppConstants.textPrimaryColorValue),
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: 'İstanbul',
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  items: ['İstanbul', 'Ankara', 'İzmir', 'Antalya'].map((city) => DropdownMenuItem(
                    value: city,
                    child: Text(city),
                  )).toList(),
                  onChanged: (value) {},
                ),
                const SizedBox(height: 20),
                
                // Araç Tipi
                Text(
                  'Araç Tipi',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(AppConstants.textPrimaryColorValue),
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: 'Tümü',
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  items: ['Tümü', 'Sedan', 'SUV', 'Van', 'Lüks', 'Elektrikli'].map((type) => DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  )).toList(),
                  onChanged: (value) {},
                ),
                const SizedBox(height: 20),
                
                // Minimum Puan
                Text(
                  'Minimum Puan: ${selectedRating > 0 ? selectedRating.toStringAsFixed(1) : "Tümü"}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(AppConstants.textPrimaryColorValue),
                  ),
                ),
                const SizedBox(height: 8),
                Slider(
                  value: selectedRating,
                  min: 0,
                  max: 10,
                  divisions: 20,
                  activeColor: Color(AppConstants.primaryColorValue),
                  onChanged: (value) => setState(() => selectedRating = value),
                ),
                const SizedBox(height: 15),
                
                // Dil Seçimi
                Text(
                  'Dil',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(AppConstants.textPrimaryColorValue),
                  ),
                ),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  value: selectedLanguage,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  items: ['Tümü', 'Türkçe', 'İngilizce', 'Almanca', 'Fransızca', 'İspanyolca', 'Rusça'].map((language) => DropdownMenuItem(
                    value: language,
                    child: Text(language),
                  )).toList(),
                  onChanged: (value) => setState(() => selectedLanguage = value!),
                ),
                const SizedBox(height: 15),
                
                // Fiyat Aralığı
                Text(
                  'Fiyat Aralığı: ${priceRange.start.toInt()} - ${priceRange.end.toInt()} TL',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(AppConstants.textPrimaryColorValue),
                  ),
                ),
                const SizedBox(height: 6),
                RangeSlider(
                  values: priceRange,
                  min: 0,
                  max: 500,
                  divisions: 50,
                  activeColor: Color(AppConstants.primaryColorValue),
                  onChanged: (values) => setState(() => priceRange = values),
                ),
                const SizedBox(height: 15),
                
                // Butonlar
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text('Sıfırla'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(AppConstants.primaryColorValue),
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text('Uygula', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(AppConstants.backgroundColorValue),
      body: CustomScrollView(
        slivers: [
          // App Bar with status toggle
          SliverAppBar(
            expandedHeight: 280,
            floating: false,
            pinned: true,
            backgroundColor: Color(AppConstants.primaryColorValue),
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(AppConstants.primaryColorValue),
                      Color(AppConstants.accentColorValue),
                      Color(AppConstants.primaryColorValue).withOpacity(0.8),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        
                        // Header with greeting
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: Icon(
                                Icons.local_taxi,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Merhaba Ahmet! 👋',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Bugün nasıl gidiyor?',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.85),
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Notification Badge
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Icon(
                                    Icons.notifications_outlined,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  Positioned(
                                    right: 0,
                                    top: 0,
                                    child: Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        color: Colors.orange,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // Enhanced Status & Earnings Card
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              // Status Section
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Durum',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.8),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Container(
                                          width: 12,
                                          height: 12,
                                          decoration: BoxDecoration(
                                            color: isAvailable ? Color(0xFF2E7D32) : Color(0xFFE65100), // Mat yeşil ve turuncu
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: isAvailable ? Color(0xFF2E7D32).withOpacity(0.3) : Color(0xFFE65100).withOpacity(0.3),
                                                blurRadius: 6, // Daha mat glow
                                                spreadRadius: 1, // Daha kontrollü yayılım
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          workingStatus,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              
                              // Earnings Section
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    Text(
                                      'Bugün Kazandığım',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.8),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      '${todayEarnings.toStringAsFixed(0)} TL',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                              // Switch Section
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    Transform.scale(
                                      scale: 1.1,
                                      child:                                         Switch(
                                        value: isAvailable,
                                        onChanged: (value) {
                                          setState(() {
                                            isAvailable = value;
                                            workingStatus = value ? 'Müsait' : 'Meşgul';
                                          });
                                        },
                                        activeColor: Colors.white,
                                        activeTrackColor: Color(0xFF2E7D32), // Mat yeşil
                                        inactiveThumbColor: Colors.white,
                                        inactiveTrackColor: Color(0xFFE65100), // Mat turuncu
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
                  ),
                ),
              ),
            ),
          ),
          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0), // 12'den 8'e
              child: _buildDriverDashboard(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDriverDashboard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Enhanced İstatistik kartları - 2x2 grid
        _buildEnhancedStatsGrid(),
        SizedBox(height: 8), // 12'den 8'e
        
        // Today's Performance Summary
        _buildTodayPerformance(),
        SizedBox(height: 8), // 12'den 8'e
        

        
        // Recent trips with better design
        _buildModernRecentTrips(),
      ],
    );
  }

  Widget _buildEnhancedStatsGrid() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 90, // Increased height
            child: _buildSimpleStatCard(
              '127',
              'Toplam Sefer',
              Icons.directions_car,
              Colors.blue,
              '+12 bu hafta',
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Container(
            height: 90, // Increased height
            child: _buildSimpleStatCard(
              '5 Yıl',
              'Deneyim',
              Icons.work,
              Colors.purple,
              'Uzman Şöför',
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: GestureDetector(
            onTap: () => showCustomerReviews(context),
            child: Container(
              height: 90, // Increased height
              child: _buildSimpleStatCard(
                '4.8',
                'Puan',
                Icons.star,
                Colors.amber,
                '⭐⭐⭐⭐⭐',
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSimpleStatCard(String value, String label, IconData icon, Color color, String subtitle) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: color.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Icon
          Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          SizedBox(width: 8),
          // Text content
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
                SizedBox(height: 2),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 9,
                    color: Color(AppConstants.textSecondaryColorValue),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 8,
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedStatCard(String value, String label, IconData icon, Color color, String subtitle) {
    return Container(
      padding: EdgeInsets.all(12), // 14'den 12'ye düşürdüm
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 15,
            offset: Offset(0, 8),
          ),
        ],
        border: Border.all(
          color: color.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon with gradient background
          Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color.withOpacity(0.2), color.withOpacity(0.1)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          
          // Spacer to push content down
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16, // 18'den 16'ya düşürdüm
                    fontWeight: FontWeight.bold,
                    color: Color(AppConstants.textPrimaryColorValue),
                  ),
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 10, // 11'den 10'a düşürdüm
                    color: Color(AppConstants.textSecondaryColorValue),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 9, // 10'dan 9'a düşürdüm
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodayPerformance() {
    return Container(
      padding: EdgeInsets.all(20), // 24'den 20'ye
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(AppConstants.primaryColorValue).withOpacity(0.05),
            Color(AppConstants.accentColorValue).withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Color(AppConstants.primaryColorValue).withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(AppConstants.primaryColorValue),
                      Color(AppConstants.primaryColorValue).withOpacity(0.8),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Color(AppConstants.primaryColorValue).withOpacity(0.3),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.analytics,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Haftalık Performans',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(AppConstants.textPrimaryColorValue),
                      ),
                    ),
                    Text(
                      'Son 7 günün özeti',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(AppConstants.textSecondaryColorValue),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          SizedBox(height: 24),
          
          Row(
            children: [
              Expanded(
                child: _buildPerformanceItem(
                  Icons.visibility,
                  '89',
                  'Görüntülenme',
                  Color(AppConstants.primaryColorValue),
                ),
              ),
              Expanded(
                child: _buildPerformanceItem(
                  Icons.reply,
                  '%98',
                  'Yanıt Oranı',
                  Color(0xFF2E7D32), // Mat yeşil
                ),
              ),
              Expanded(
                child: _buildPerformanceItem(
                  Icons.star,
                  '4.9',
                  'Memnuniyet',
                  Colors.amber,
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // Chat sayfasına git
                    Navigator.pushNamed(context, '/chat');
                  },
                  child: _buildPerformanceItem(
                    Icons.chat,
                    '8',
                    'Aktif Sohbet',
                    Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceItem(IconData icon, String value, String label, Color color) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(AppConstants.textPrimaryColorValue),
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Color(AppConstants.textSecondaryColorValue),
          ),
        ),
      ],
    );
  }

  Widget _buildModernQuickActions() {
    return Container(
      padding: EdgeInsets.all(20), // 24'den 20'ye
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 15,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.flash_on,
                color: Color(AppConstants.primaryColorValue),
                size: 24,
              ),
              SizedBox(width: 8),
              Text(
                'Hızlı İşlemler',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(AppConstants.textPrimaryColorValue),
                ),
              ),
            ],
          ),
          
          SizedBox(height: 16), // 20'den 16'ya
          
          Row(
            children: [
              Expanded(
                child: _buildModernActionButton(
                  'Kazanç Raporu',
                  Icons.analytics,
                  Colors.green,
                  () => showEarningsReport(context),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildModernActionButton(
                  'Müşteri Yorumları',
                  Icons.star_rate,
                  Colors.amber,
                  () => showCustomerReviews(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildModernActionButton(String label, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: color.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: color,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernRecentTrips() {
    final trips = [
      {
        'name': 'Ahmet Y.',
        'route': 'Taksim → Havalimanı',
        'price': '150 TL',
        'time': '14:30',
        'rating': '5.0',
        'status': 'completed'
      },
      {
        'name': 'Fatma Ö.',
        'route': 'Kadıköy → Bostancı',
        'price': '85 TL',
        'time': '12:15',
        'rating': '4.8',
        'status': 'completed'
      },
      {
        'name': 'Mehmet K.',
        'route': 'Şişli → Levent',
        'price': '65 TL',
        'time': '09:45',
        'rating': '4.9',
        'status': 'completed'
      },
    ];

    return Container(
      padding: EdgeInsets.all(20), // 24'den 20'ye
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 15,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.history,
                    color: Color(AppConstants.primaryColorValue),
                    size: 24,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Son Seyahatler',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(AppConstants.textPrimaryColorValue),
                    ),
                  ),
                ],
              ),
                                      GestureDetector(
                          onTap: () => showTripHistory(context),
                          child: Text(
                            'Tümünü Gör →',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(AppConstants.primaryColorValue),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
            ],
          ),
          
          SizedBox(height: 16), // 20'den 16'ya
          
          ...trips.map((trip) => Container(
            margin: EdgeInsets.only(bottom: 12), // 16'dan 12'ye
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(AppConstants.primaryColorValue).withOpacity(0.02),
                  Color(AppConstants.accentColorValue).withOpacity(0.02),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Color(AppConstants.primaryColorValue).withOpacity(0.1),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Color(0xFF00C853), // Parlak yeşil
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF00C853).withOpacity(0.5), // Daha güçlü glow
                        blurRadius: 12,
                        spreadRadius: 3,
                      ),
                      BoxShadow(
                        color: Color(0xFF00C853).withOpacity(0.3),
                        blurRadius: 6,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            trip['name']!,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(AppConstants.textPrimaryColorValue),
                            ),
                          ),
                          SizedBox(width: 8),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 16),
                              SizedBox(width: 4),
                              Text(
                                trip['rating']!,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.amber,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(
                        trip['route']!,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(AppConstants.textSecondaryColorValue),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      trip['price']!,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF00C853), // Parlak yeşil
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      trip['time']!,
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(AppConstants.textSecondaryColorValue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  // Eski widget'lar silindi - yeni modern tasarım aktif

  Widget _buildOldCleanStatusCard() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(AppConstants.primaryColorValue),
            Color(AppConstants.accentColorValue),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color(AppConstants.primaryColorValue).withOpacity(0.2),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Sol taraf - Durum
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Durum',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: isAvailable ? Color(0xFF2E7D32) : Color(0xFFE65100),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      workingStatus,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Orta - Bugünkü Kazanç
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Text(
                  'Bugün',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '${todayEarnings.toStringAsFixed(0)} TL',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          // Sağ - Puan
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 20),
                SizedBox(height: 4),
                Text(
                  '$rating',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLiveStats() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(AppConstants.primaryColorValue),
            Color(AppConstants.accentColorValue),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Color(AppConstants.primaryColorValue).withOpacity(0.3),
            blurRadius: 15,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Anlık Durum',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: isAvailable ? Colors.green : Colors.orange,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        workingStatus,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Bugün Kazandığım',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${todayEarnings.toStringAsFixed(0)} TL',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            height: 1,
            color: Colors.white.withOpacity(0.3),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'Bugün',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '$todayTrips seyahat',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 30,
                color: Colors.white.withOpacity(0.3),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'Bu Hafta',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '${weeklyEarnings.toStringAsFixed(0)} TL',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 30,
                color: Colors.white.withOpacity(0.3),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'Puanım',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        SizedBox(width: 4),
                        Text(
                          '$rating',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
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

  Widget _buildCleanStatsGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.4,
      children: [
        _buildCleanStatCard(
          'Haftalık Kazanç',
          '${weeklyEarnings.toStringAsFixed(0)} TL',
          Icons.account_balance_wallet,
          Colors.green,
        ),
        _buildCleanStatCard(
          'Toplam Seyahat',
          '$totalTrips',
          Icons.directions_car,
          Colors.blue,
        ),
        _buildCleanStatCard(
          'Bu Ay Kazanç',
          '8,650 TL',
          Icons.calendar_month,
          Colors.purple,
        ),
        _buildCleanStatCard(
          'Ortalama Puan',
          '$rating/5.0',
          Icons.star,
          Colors.amber,
        ),
      ],
    );
  }

  Widget _buildCleanStatCard(String title, String value, IconData icon, Color color) {
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(AppConstants.textPrimaryColorValue),
            ),
          ),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              color: Color(AppConstants.textSecondaryColorValue),
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCards() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Genel İstatistikler',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(AppConstants.textPrimaryColorValue),
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                'Puanım',
                '$rating/5.0',
                Icons.star,
                Color(AppConstants.warningColorValue),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                'Toplam Seyahat',
                '$totalTrips',
                Icons.directions_car,
                Colors.blue,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                'Haftalık Kazanç',
                '${weeklyEarnings.toStringAsFixed(0)} TL',
                Icons.account_balance_wallet,
                Colors.green,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                'Bugünkü Kazanç',
                '${todayEarnings.toStringAsFixed(0)} TL',
                Icons.today,
                Color(AppConstants.primaryColorValue),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(16),
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
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(AppConstants.textPrimaryColorValue),
            ),
          ),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Color(AppConstants.textSecondaryColorValue),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTodaySummary() {
    return Container(
      padding: EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bugünkü Özet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(AppConstants.textPrimaryColorValue),
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSummaryItem('Seyahat', '$todayTrips', Icons.route),
              _buildSummaryItem('Kazanç', '${todayEarnings.toInt()} TL', Icons.monetization_on),
              _buildSummaryItem('Süre', '6 saat', Icons.access_time),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleTodaySummary() {
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
            'Bugünkü Özet',
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
                child: _buildSimpleSummaryItem(
                  Icons.route,
                  '$todayTrips',
                  'Seyahat',
                  Color(AppConstants.primaryColorValue),
                ),
              ),
              Expanded(
                child: _buildSimpleSummaryItem(
                  Icons.access_time,
                  '6h 30m',
                  'Çalışma',
                  Colors.orange,
                ),
              ),
              Expanded(
                child: _buildSimpleSummaryItem(
                  Icons.location_on,
                  '85km',
                  'Mesafe',
                  Colors.green,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleSummaryItem(IconData icon, String value, String label, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(AppConstants.textPrimaryColorValue),
          ),
        ),
        SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Color(AppConstants.textSecondaryColorValue),
          ),
        ),
      ],
    );
  }

  Widget _buildCleanQuickActions() {
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
                child: _buildCleanActionButton(
                  Icons.analytics,
                  'Kazanç',
                  Colors.green,
                  () {},
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _buildCleanActionButton(
                  Icons.history,
                  'Geçmiş',
                  Color(AppConstants.primaryColorValue),
                  () {},
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _buildCleanActionButton(
                  Icons.star,
                  'Yorumlar',
                  Colors.amber,
                  () {},
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _buildCleanActionButton(
                  Icons.settings,
                  'Ayarlar',
                  Colors.grey,
                  () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCleanActionButton(IconData icon, String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Color(AppConstants.textSecondaryColorValue),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCleanRecentTrips() {
    final trips = [
      {'name': 'Ahmet Y.', 'route': 'Taksim → Havalimanı', 'price': '150 TL', 'time': '14:30'},
      {'name': 'Fatma Ö.', 'route': 'Kadıköy → Bostancı', 'price': '85 TL', 'time': '12:15'},
      {'name': 'Mehmet K.', 'route': 'Şişli → Levent', 'price': '65 TL', 'time': '09:45'},
    ];

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Son Seyahatler',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(AppConstants.textPrimaryColorValue),
                ),
              ),
              Text(
                'Tümünü Gör',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(AppConstants.primaryColorValue),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          ...trips.map((trip) => Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        trip['name']!,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(AppConstants.textPrimaryColorValue),
                        ),
                      ),
                      Text(
                        trip['route']!,
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(AppConstants.textSecondaryColorValue),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      trip['price']!,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    Text(
                      trip['time']!,
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(AppConstants.textSecondaryColorValue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildTodaySummaryWithGoals() {
    double targetEarnings = 600.0;
    double targetTrips = 8.0;
    double earningsProgress = todayEarnings / targetEarnings;
    double tripsProgress = todayTrips / targetTrips;
    
    return Container(
      padding: EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Bugünkü Hedefler',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(AppConstants.textPrimaryColorValue),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Color(AppConstants.primaryColorValue).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${((earningsProgress + tripsProgress) * 50).toInt()}% tamamlandı',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(AppConstants.primaryColorValue),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          
          // Kazanç hedefi
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Kazanç Hedefi',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(AppConstants.textPrimaryColorValue),
                    ),
                  ),
                  Text(
                    '${todayEarnings.toInt()} / ${targetEarnings.toInt()} TL',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(AppConstants.textSecondaryColorValue),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              LinearProgressIndicator(
                value: earningsProgress.clamp(0.0, 1.0),
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(
                  earningsProgress >= 1.0 ? Colors.green : Color(AppConstants.primaryColorValue),
                ),
                minHeight: 8,
              ),
            ],
          ),
          
          SizedBox(height: 16),
          
          // Seyahat hedefi
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Seyahat Hedefi',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(AppConstants.textPrimaryColorValue),
                    ),
                  ),
                  Text(
                    '$todayTrips / ${targetTrips.toInt()} seyahat',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(AppConstants.textSecondaryColorValue),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              LinearProgressIndicator(
                value: tripsProgress.clamp(0.0, 1.0),
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(
                  tripsProgress >= 1.0 ? Colors.green : Color(AppConstants.primaryColorValue),
                ),
                minHeight: 8,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: Color(AppConstants.primaryColorValue),
          size: 28,
        ),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(AppConstants.textPrimaryColorValue),
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Color(AppConstants.textSecondaryColorValue),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hızlı Aksiyonlar',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(AppConstants.textPrimaryColorValue),
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                'Mesajlar',
                '3 yeni',
                Icons.message,
                Colors.blue,
                () => Navigator.of(context).pushNamed('/chat'),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _buildActionCard(
                'Bildirimler',
                '2 yeni',
                Icons.notifications,
                Colors.orange,
                () {},
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _buildActionCard(
                'Profil',
                'Düzenle',
                Icons.person,
                Colors.purple,
                () {},
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard(String title, String subtitle, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
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
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(AppConstants.textPrimaryColorValue),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 11,
                color: Color(AppConstants.textSecondaryColorValue),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentTrips() {
    final recentTrips = [
      {
        'customer': 'Ahmet Yılmaz',
        'from': 'Taksim',
        'to': 'İstanbul Havalimanı',
        'time': '14:30',
        'amount': '150 TL',
        'status': 'Tamamlandı',
      },
      {
        'customer': 'Fatma Özkan',
        'from': 'Kadıköy',
        'to': 'Bostancı',
        'time': '12:15',
        'amount': '85 TL',
        'status': 'Tamamlandı',
      },
      {
        'customer': 'Mehmet Kaya',
        'from': 'Şişli',
        'to': 'Levent',
        'time': '09:45',
        'amount': '65 TL',
        'status': 'Tamamlandı',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Son Seyahatler',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(AppConstants.textPrimaryColorValue),
          ),
        ),
        SizedBox(height: 12),
        ...recentTrips.map((trip) => Container(
          margin: EdgeInsets.only(bottom: 12),
          padding: EdgeInsets.all(16),
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
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 20,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      trip['customer']!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Color(AppConstants.textPrimaryColorValue),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '${trip['from']} → ${trip['to']}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(AppConstants.textSecondaryColorValue),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    trip['amount']!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(AppConstants.primaryColorValue),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    trip['time']!,
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(AppConstants.textSecondaryColorValue),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )).toList(),
      ],
    );
  }

  Widget _buildEnhancedQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hızlı İşlemler',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(AppConstants.textPrimaryColorValue),
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                'Seyahat Geçmişi',
                'Tüm seyahatlerini gör',
                Icons.history,
                Color(AppConstants.primaryColorValue),
                () => Navigator.pushNamed(context, '/trips'),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _buildActionCard(
                'Kazanç Raporu',
                'Detaylı gelir analizi',
                Icons.analytics,
                Colors.green,
                () => Navigator.pushNamed(context, '/earnings'),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                'Müşteri Yorumları',
                'Değerlendirmeleri incele',
                Icons.star_border,
                Colors.amber,
                () => Navigator.pushNamed(context, '/reviews'),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _buildActionCard(
                'Ayarlar',
                'Profil ve uygulama',
                Icons.settings,
                Colors.grey[600]!,
                () => Navigator.pushNamed(context, '/settings'),
              ),
            ),
          ],
        ),
      ],
    );
  }



  Widget _buildWeeklyChart() {
    final weeklyData = [
      {'day': 'Pzt', 'earnings': 320.0},
      {'day': 'Sal', 'earnings': 450.0},
      {'day': 'Çar', 'earnings': 380.0},
      {'day': 'Per', 'earnings': 520.0},
      {'day': 'Cum', 'earnings': 680.0},
      {'day': 'Cmt', 'earnings': 750.0},
      {'day': 'Paz', 'earnings': 420.0},
    ];

    double maxEarnings = weeklyData.map((e) => e['earnings'] as double).reduce((a, b) => a > b ? a : b);

    return Container(
      padding: EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Haftalık Kazanç Grafiği',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(AppConstants.textPrimaryColorValue),
                ),
              ),
              Text(
                '${weeklyEarnings.toStringAsFixed(0)} TL',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(AppConstants.primaryColorValue),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Container(
            height: 140,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: weeklyData.map((data) {
                double earnings = data['earnings'] as double;
                double height = (earnings / maxEarnings) * 80;
                bool isToday = data['day'] == 'Per'; // Perşembe bugün olsun
                
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '${earnings.toInt()}',
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(AppConstants.textSecondaryColorValue),
                      ),
                    ),
                    SizedBox(height: 4),
                    Container(
                      width: 24,
                      height: height,
                      decoration: BoxDecoration(
                        color: isToday 
                          ? Color(AppConstants.primaryColorValue)
                          : Color(AppConstants.primaryColorValue).withOpacity(0.3),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      data['day'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                        color: isToday 
                          ? Color(AppConstants.primaryColorValue)
                          : Color(AppConstants.textSecondaryColorValue),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeContentBody extends StatefulWidget {
  @override
  State<_HomeContentBody> createState() => _HomeContentBodyState();
}

class _HomeContentBodyState extends State<_HomeContentBody> {
  String searchQuery = '';
  int _currentBanner = 0;
  String selectedCategory = 'Tümü';
  String selectedCity = 'İstanbul';
  String selectedVehicleType = 'Tümü';
  double selectedRating = 0.0;
  bool showOnlineOnly = false;
  bool showVerifiedOnly = false;
  String selectedPaymentMethod = 'Nakit';
  String selectedLanguage = 'Tümü';
  double minPrice = 0.0;
  double maxPrice = 500.0;
  
  final List<String> categories = [
    'Tümü',
    'Havalimanı Transferi',
    'Şehir Turu',
    'İş Seyahati',
    'VIP Hizmet',
    'Grup Seyahati',
    'Gece Transferi',
  ];

  final List<String> cities = [
    'İstanbul',
    'Ankara',
    'İzmir',
    'Antalya',
    'Bursa',
    'Adana',
    'Konya',
  ];

  final List<String> vehicleTypes = [
    'Tümü',
    'Sedan',
    'SUV',
    'Van',
    'Lüks',
    'Elektrikli',
  ];

  final List<String> languages = [
    'Tümü',
    'Türkçe',
    'İngilizce',
    'Almanca',
    'Fransızca',
    'İspanyolca',
    'Rusça',
  ];

  final List<Map<String, dynamic>> drivers = [
    {
      'name': 'Ahmet Yılmaz',
      'rating': 9.2,
      'experience': '5 yıl',
      'car': 'Mercedes C200',
      'carType': 'Sedan',
      'city': 'İstanbul',
      'image': 'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=150&h=150&fit=crop&crop=face',
      'isOnline': true,
      'isVerified': true,
      'category': 'Havalimanı Transferi',
      'price': '150 TL',
      'languages': ['Türkçe', 'İngilizce'],
      'specialties': ['Havalimanı Transferi', 'İş Seyahati'],
      'totalRides': 1247,
      'responseTime': '2 dk',
    },
    {
      'name': 'Mehmet Kaya',
      'rating': 9.8,
      'experience': '8 yıl',
      'car': 'BMW X5',
      'carType': 'SUV',
      'city': 'Ankara',
      'image': 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=150&h=150&fit=crop&crop=face',
      'isOnline': true,
      'isVerified': true,
      'category': 'VIP Hizmet',
      'price': '200 TL',
      'languages': ['Türkçe', 'İngilizce', 'Almanca'],
      'specialties': ['VIP Hizmet', 'Şehir Turu'],
      'totalRides': 892,
      'responseTime': '1 dk',
    },
    {
      'name': 'Ali Demir',
      'rating': 8.9,
      'experience': '3 yıl',
      'car': 'Audi A4',
      'carType': 'Sedan',
      'city': 'İzmir',
      'image': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
      'isOnline': false,
      'isVerified': true,
      'category': 'İş Seyahati',
      'price': '120 TL',
      'languages': ['Türkçe', 'İngilizce'],
      'specialties': ['İş Seyahati'],
      'totalRides': 567,
      'responseTime': '5 dk',
    },
    {
      'name': 'Fatma Özkan',
      'rating': 9.5,
      'experience': '6 yıl',
      'car': 'Volkswagen Caravelle',
      'carType': 'Van',
      'city': 'Antalya',
      'image': 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&h=150&fit=crop&crop=face',
      'isOnline': true,
      'isVerified': true,
      'category': 'Grup Seyahati',
      'price': '180 TL',
      'languages': ['Türkçe', 'İngilizce', 'Rusça'],
      'specialties': ['Grup Seyahati', 'Turistik Transfer'],
      'totalRides': 734,
      'responseTime': '3 dk',
    },
    {
      'name': 'Can Yıldız',
      'rating': 9.7,
      'experience': '7 yıl',
      'car': 'Tesla Model S',
      'carType': 'Elektrikli',
      'city': 'İstanbul',
      'image': 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face',
      'isOnline': true,
      'isVerified': true,
      'category': 'VIP Hizmet',
      'price': '250 TL',
      'languages': ['Türkçe', 'İngilizce', 'Fransızca'],
      'specialties': ['VIP Hizmet', 'Çevre Dostu Seyahat'],
      'totalRides': 1567,
      'responseTime': '1 dk',
    },
    {
      'name': 'Zeynep Kaya',
      'rating': 9.3,
      'experience': '4 yıl',
      'car': 'Volvo XC60',
      'carType': 'SUV',
      'city': 'Bursa',
      'image': 'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=150&h=150&fit=crop&crop=face',
      'isOnline': true,
      'isVerified': true,
      'category': 'Şehir Turu',
      'price': '160 TL',
      'languages': ['Türkçe', 'İngilizce', 'Arapça'],
      'specialties': ['Şehir Turu', 'Güvenli Seyahat'],
      'totalRides': 892,
      'responseTime': '2 dk',
    },
  ];

  final List<Map<String, dynamic>> banners = [
    {
      'title': 'İlk Yolculuğunda %20 İndirim!',
      'desc': 'Kampanyadan hemen yararlan.',
      'color': '0xFFD32F2F',
      'icon': Icons.local_offer,
    },
    {
      'title': 'Premium Araç Filosu',
      'desc': 'Lüks araçlarla seyahat edin.',
      'color': '0xFF1976D2',
      'icon': Icons.directions_car,
    },
    {
      'title': '7/24 Destek Hattı',
      'desc': 'Her zaman yanınızdayız.',
      'color': '0xFF388E3C',
      'icon': Icons.support_agent,
    },
    {
      'title': 'Güvenli Sürücüler',
      'desc': 'Tüm sürücülerimiz onaylı ve puanlıdır.',
      'color': '0xFFF57C00',
      'icon': Icons.verified_user,
    },
  ];

  final List<Map<String, dynamic>> vehicleAds = [
    {
      'brand': 'Mercedes',
      'model': 'S-Class',
      'year': '2023',
      'price': '500 TL',
      'image': 'https://images.unsplash.com/photo-1563720223186-11003d516935?auto=format&fit=crop&w=300&h=200&q=80',
      'features': ['Lüks', 'Klima', 'WiFi'],
    },
    {
      'brand': 'BMW',
      'model': '7 Series',
      'year': '2023',
      'price': '450 TL',
      'image': 'https://images.unsplash.com/photo-1555215695-3004980ad54e?auto=format&fit=crop&w=300&h=200&q=80',
      'features': ['Lüks', 'Klima', 'WiFi'],
    },
    {
      'brand': 'Audi',
      'model': 'A8',
      'year': '2023',
      'price': '480 TL',
      'image': 'https://images.unsplash.com/photo-1606664515524-ed2f786a0bd6?auto=format&fit=crop&w=300&h=200&q=80',
      'features': ['Lüks', 'Klima', 'WiFi'],
    },
    {
      'brand': 'Tesla',
      'model': 'Model S',
      'year': '2023',
      'price': '600 TL',
      'image': 'https://images.unsplash.com/photo-1617814076367-b759c7d7e738?auto=format&fit=crop&w=300&h=200&q=80',
      'features': ['Elektrikli', 'Lüks', 'WiFi'],
    },
    {
      'brand': 'Volvo',
      'model': 'XC90',
      'year': '2023',
      'price': '520 TL',
      'image': 'https://images.unsplash.com/photo-1618843479313-40f8afb4b4d8?auto=format&fit=crop&w=300&h=200&q=80',
      'features': ['Güvenli', 'Lüks', 'Klima'],
    },
  ];

  List<Map<String, dynamic>> get filteredDrivers {
    return drivers.where((driver) {
      // Arama filtresi
      if (searchQuery.isNotEmpty) {
    final query = searchQuery.toLowerCase();
        if (!driver['name'].toLowerCase().contains(query) &&
            !driver['car'].toLowerCase().contains(query) &&
            !driver['city'].toLowerCase().contains(query) &&
            !driver['category'].toLowerCase().contains(query)) {
          return false;
        }
      }
      
      // Kategori filtresi
      if (selectedCategory != 'Tümü' && driver['category'] != selectedCategory) {
        return false;
      }
      
      // Şehir filtresi
      if (selectedCity != 'Tümü' && driver['city'] != selectedCity) {
        return false;
      }
      
      // Araç tipi filtresi
      if (selectedVehicleType != 'Tümü' && driver['carType'] != selectedVehicleType) {
        return false;
      }
      
      // Puan filtresi
      if (selectedRating > 0 && driver['rating'] < selectedRating) {
        return false;
      }
      
      // Sadece çevrimiçi filtresi
      if (showOnlineOnly && !driver['isOnline']) {
        return false;
      }
      
      // Sadece onaylı filtresi
      if (showVerifiedOnly && !driver['isVerified']) {
        return false;
      }
      
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Kaydırmalı Reklamlar
        // _buildBannerSection(),
        // const SizedBox(height: 20),

        // Önerilen Sürücüler
        _buildDriversSection(),
        const SizedBox(height: 20),

        // TODO: Bu bölümler daha sonra kullanılacak
        // // Hızlı Aksiyonlar
        // _buildQuickActions(),
        // const SizedBox(height: 20),

        // // Araç Reklamları
        // _buildVehicleAdsSection(),
        // const SizedBox(height: 20),

        // // Kategoriler
        // _buildCategoriesSection(),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hızlı Aksiyonlar',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(AppConstants.textPrimaryColorValue),
          ),
        ),
        const SizedBox(height: 12),
                  Container(
          height: 120,
          child: Row(
            children: [
              Expanded(
                child: _buildActionCard(
                  icon: Icons.history,
                  title: 'Son Seyahat',
                  subtitle: 'Ahmet Yılmaz',
                  color: Color(AppConstants.primaryColorValue),
                  onTap: () {
                    _showLastTripDialog();
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildActionCard(
                  icon: Icons.location_on,
                  title: 'Konum Paylaş',
                  subtitle: 'Sürücü ile Paylaş',
                  color: Colors.green,
                  onTap: () {
                    _shareLocationWithDriver();
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildActionCard(
                  icon: _getPaymentIcon(selectedPaymentMethod),
                  title: 'Ödeme',
                  subtitle: selectedPaymentMethod,
                  color: _getPaymentColor(selectedPaymentMethod),
                  onTap: () {
                    _showPaymentMethodDialog();
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

      ],
    );
  }

    Widget _buildPaymentOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ödeme Yöntemi',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(AppConstants.textPrimaryColorValue),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
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
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _getPaymentColor(selectedPaymentMethod).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _getPaymentIcon(selectedPaymentMethod),
                  color: _getPaymentColor(selectedPaymentMethod),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                      selectedPaymentMethod,
                          style: TextStyle(
                        fontSize: 16,
                            fontWeight: FontWeight.bold,
                        color: Color(AppConstants.textPrimaryColorValue),
                          ),
                        ),
                        Text(
                      _getPaymentSubtitle(selectedPaymentMethod),
                          style: TextStyle(
                        fontSize: 14,
                        color: Color(AppConstants.textSecondaryColorValue),
                          ),
                        ),
                      ],
                    ),
                  ),
              IconButton(
                onPressed: () {
                  _showPaymentMethodDialog();
                },
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Color(AppConstants.textSecondaryColorValue),
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }



  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
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
                    child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
                  Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: color,
                size: 28,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Color(AppConstants.textPrimaryColorValue),
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 11,
                color: Color(AppConstants.textSecondaryColorValue),
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickFilters() {
    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
          'Hızlı Filtreler',
                          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(AppConstants.textPrimaryColorValue),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildFilterChip(
                label: 'Çevrimiçi',
                isSelected: showOnlineOnly,
                onTap: () => setState(() => showOnlineOnly = !showOnlineOnly),
                icon: Icons.circle,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildFilterChip(
                label: 'Onaylı',
                isSelected: showVerifiedOnly,
                onTap: () => setState(() => showVerifiedOnly = !showVerifiedOnly),
                icon: Icons.verified,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildFilterChip(
                label: '9+ Puan',
                isSelected: selectedRating >= 9.0,
                onTap: () => setState(() => selectedRating = selectedRating >= 9.0 ? 0.0 : 9.0),
                icon: Icons.star,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFilterChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? Color(AppConstants.primaryColorValue) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Color(AppConstants.primaryColorValue) : Colors.grey[300]!,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? Colors.white : Color(AppConstants.primaryColorValue),
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Color(AppConstants.textPrimaryColorValue),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildBannerSection() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         'Kampanyalar',
  //         style: TextStyle(
  //           fontSize: 18,
  //           fontWeight: FontWeight.bold,
  //           color: Color(AppConstants.textPrimaryColorValue),
  //         ),
  //       ),
  //       const SizedBox(height: 12),
  //       SizedBox(
  //                   height: 120,
  //         child: PageView.builder(
  //           itemCount: banners.length,
  //           controller: PageController(viewportFraction: 0.88),
  //           onPageChanged: (i) => setState(() => _currentBanner = i),
  //           itemBuilder: (context, i) {
  //             final banner = banners[i];
  //             return Container(
  //               margin: const EdgeInsets.symmetric(horizontal: 6),
  //               padding: const EdgeInsets.all(20),
  //                   decoration: BoxDecoration(
  //                 color: Color(int.parse(banner['color']!)),
  //                 borderRadius: BorderRadius.circular(18),
  //                     boxShadow: [
  //                       BoxShadow(
  //                 color: Colors.black.withOpacity(0.1),
  //                 blurRadius: 8,
  //                 offset: Offset(0, 4),
  //                       ),
  //                     ],
  //                   ),
  //               child: Row(
  //                 children: [
  //                   Icon(
  //                     banner['icon'],
  //                           color: Colors.white,
  //                     size: 32,
  //                   ),
  //                   const SizedBox(width: 16),
  //                   Expanded(
  //                         child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                           children: [
  //                             Text(
  //                 banner['title']!,
  //                               style: TextStyle(
  //                                 color: Colors.white,
  //                 fontSize: 16,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //             const SizedBox(height: 4),
  //           Text(
  //                 banner['desc']!,
  //             style: TextStyle(
  //               color: Colors.white.withOpacity(0.9),
  //                 fontSize: 12,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ],
  //   ),
  //               ],
  //             ),
  //           );
  //         },
  //       ),
  //     ),
  //     const SizedBox(height: 8),
  //     Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: List.generate(banners.length, (i) => AnimatedContainer(
  //         duration: Duration(milliseconds: 300),
  //         margin: const EdgeInsets.symmetric(horizontal: 3),
  //         width: _currentBanner == i ? 18 : 7,
  //         height: 7,
  //                   decoration: BoxDecoration(
  //         color: _currentBanner == i ? Color(AppConstants.primaryColorValue) : Colors.grey[300],
  //         borderRadius: BorderRadius.circular(8),
  //             ),
  //       )),
  //     ),
  //   ],
  // );
  // }

  Widget _buildVehicleAdsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
                  Text(
          'Premium Araçlar',
                    style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
                      color: Color(AppConstants.textPrimaryColorValue),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: vehicleAds.length,
            itemBuilder: (context, index) {
              final ad = vehicleAds[index];
              return Container(
                width: 280,
                margin: const EdgeInsets.only(right: 16),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                      child: Image.network(
                        ad['image'],
                            height: 100,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.directions_car,
                                  size: 40,
                                  color: Colors.grey[400],
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '${ad['brand']} ${ad['model']}',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                            ),
                            child: Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Color(AppConstants.primaryColorValue)),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${ad['brand']} ${ad['model']}',
                                style: TextStyle(
                                  fontSize: 16,
                      fontWeight: FontWeight.bold,
                                  color: Color(AppConstants.textPrimaryColorValue),
                  ),
                              ),
                              Text(
                                ad['price'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(AppConstants.primaryColorValue),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${ad['year']} Model',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(AppConstants.textSecondaryColorValue),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: ad['features'].map<Widget>((feature) => 
                              Container(
                                margin: const EdgeInsets.only(right: 4),
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Color(AppConstants.primaryColorValue).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  feature,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Color(AppConstants.primaryColorValue),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            ).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Hizmet Kategorileri',
              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                color: Color(AppConstants.textPrimaryColorValue),
                                ),
                              ),
                              Text(
              '${categories.length} kategori',
                                style: TextStyle(
                                  fontSize: 14,
                color: Color(AppConstants.textSecondaryColorValue),
                                ),
                              ),
                            ],
                          ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              final isSelected = selectedCategory == category;
              return Container(
                width: 120,
                margin: EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: () => setState(() => selectedCategory = category),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      color: isSelected ? Color(AppConstants.primaryColorValue) : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected ? Color(AppConstants.primaryColorValue) : Colors.grey[200]!,
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 12,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.white.withOpacity(0.2) : Colors.grey[50],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            _getCategoryIcon(category),
                            color: isSelected ? Colors.white : Color(AppConstants.primaryColorValue),
                            size: 32,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          category,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : Color(AppConstants.textPrimaryColorValue),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Tümü':
        return Icons.apps;
      case 'Havalimanı Transferi':
        return Icons.flight_takeoff;
      case 'Şehir Turu':
        return Icons.explore;
      case 'İş Seyahati':
        return Icons.business_center;
      case 'VIP Hizmet':
        return Icons.star;
      case 'Grup Seyahati':
        return Icons.group;
      case 'Gece Transferi':
        return Icons.nightlife;
      default:
        return Icons.category;
    }
  }

  Widget _buildDriversSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
                  Text(
                    'Önerilen Sürücüler',
                    style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                      color: Color(AppConstants.textPrimaryColorValue),
              ),
            ),
            Text(
              '${filteredDrivers.length} sürücü',
              style: TextStyle(
                fontSize: 14,
                color: Color(AppConstants.textSecondaryColorValue),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (filteredDrivers.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 32),
              child: Column(
                children: [
                  Icon(
                    Icons.search_off,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Kriterlerinize uygun sürücü bulunamadı',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Filtrelerinizi değiştirmeyi deneyin',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
                  ),
            ),
          )
        else
          ...filteredDrivers.map((driver) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DriverProfileScreen(driver: driver),
                        ),
                );
              },
              child: _DriverCard(driver: driver),
              ),
          )),
        ],
    );
  }

  void _showLastTripDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.history, color: Color(AppConstants.primaryColorValue)),
            const SizedBox(width: 8),
            Text('Son Seyahat'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage('https://images.unsplash.com/photo-1560250097-0b93528c311a?w=150&h=150&fit=crop&crop=face'),
                  radius: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ahmet Yılmaz',
                        style: TextStyle(
                      fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Mercedes C200 • 9.2/10',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
                  Text(
              'Son Seyahat:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                fontSize: 14,
                    ),
                  ),
            const SizedBox(height: 8),
                  Row(
                    children: [
                Icon(Icons.location_on, color: Colors.green, size: 16),
                const SizedBox(width: 8),
                      Expanded(
                  child: Text('İstanbul Havalimanı'),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.location_on, color: Color(AppConstants.primaryColorValue), size: 16),
                const SizedBox(width: 8),
                      Expanded(
                  child: Text('Taksim'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Fiyat: 150 TL • Tarih: 15 Mart 2024',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
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
              Navigator.pop(context);
              _callLastDriver();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(AppConstants.primaryColorValue),
            ),
            child: Text('Tekrar Çağır', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _shareLocation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.location_on, color: Colors.green),
            const SizedBox(width: 8),
            Text('Konum Paylaş'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Konumunuzu kiminle paylaşmak istiyorsunuz?',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                _buildShareOption(Icons.family_restroom, 'Aile'),
                _buildShareOption(Icons.people, 'Arkadaşlar'),
                _buildShareOption(Icons.work, 'İş'),
              ],
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
              Navigator.pop(context);
              _performLocationShare();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            child: Text('Paylaş', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildShareOption(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.green, size: 24),
        ),
        const SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }





  void _callLastDriver() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Ahmet Yılmaz aranıyor...'),
        backgroundColor: Color(AppConstants.primaryColorValue),
      ),
    );
  }

  void _performLocationShare() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Konum paylaşıldı'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _shareLocationWithDriver() {
    print('Konum paylaş dialog açılıyor...');
    print('Drivers listesi uzunluğu: ${drivers.length}');
    
    // Test için basit dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Test Dialog'),
        content: Text('Konum paylaş dialog açıldı!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Tamam'),
          ),
        ],
      ),
    );
    return;
    
    if (drivers.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Henüz sürücü bulunmuyor'),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Sürücü ile Konum Paylaş'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hangi sürücü ile konumunuzu paylaşmak istiyorsunuz?',
              style: TextStyle(
                fontSize: 16,
                color: Color(AppConstants.textSecondaryColorValue),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 200,
              child: ListView.builder(
                itemCount: drivers.length > 5 ? 5 : drivers.length,
                itemBuilder: (context, index) {
                  final driver = drivers[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(driver['image']),
                      radius: 20,
                    ),
                    title: Text(
                      driver['name'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(AppConstants.textPrimaryColorValue),
                      ),
                    ),
                    subtitle: Text(
                      '${driver['car']} • ${driver['city']}',
                      style: TextStyle(
                        color: Color(AppConstants.textSecondaryColorValue),
                      ),
                    ),
                    trailing: driver['isOnline'] 
                      ? Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        )
                      : null,
                    onTap: () {
                      Navigator.pop(context);
                      _confirmLocationShare(driver);
                    },
                  );
                },
              ),
            ),
          ],
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

  void _confirmLocationShare(Map<String, dynamic> driver) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Konum Paylaşımı Onayı'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(driver['image']),
                  radius: 25,
                ),
                const SizedBox(width: 12),
                      Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        driver['name'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(AppConstants.textPrimaryColorValue),
                        ),
                      ),
                      Text(
                        '${driver['car']} • ${driver['city']}',
                        style: TextStyle(
                          color: Color(AppConstants.textSecondaryColorValue),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Konumunuzu ${driver['name']} ile paylaşmak istediğinizden emin misiniz?',
              style: TextStyle(
                fontSize: 14,
                color: Color(AppConstants.textSecondaryColorValue),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.blue, size: 20),
                  const SizedBox(width: 8),
                      Expanded(
                    child: Text(
                      'Sürücü sadece seyahat süresince konumunuza erişebilecek',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue[700],
                      ),
                        ),
                      ),
                    ],
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
              Navigator.pop(context);
              _executeLocationShare(driver);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            child: Text('Paylaş'),
          ),
        ],
      ),
    );
  }

  void _executeLocationShare(Map<String, dynamic> driver) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(
              child: Text('Konum ${driver['name']} ile paylaşıldı'),
            ),
          ],
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Görüntüle',
          textColor: Colors.white,
          onPressed: () {
            // Konum paylaşım detaylarını gösterebilir
          },
        ),
      ),
    );
  }

  void _selectPaymentMethod(String method) {
    setState(() {
      selectedPaymentMethod = method;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Ödeme yöntemi: $method seçildi'),
        backgroundColor: Color(AppConstants.primaryColorValue),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Color _getPaymentColor(String method) {
    switch (method) {
      case 'Nakit':
        return Colors.green;
      case 'Kredi Kartı':
        return Colors.blue;
      case 'Dijital Cüzdan':
        return Colors.purple;
      default:
        return Colors.green;
    }
  }

  IconData _getPaymentIcon(String method) {
    switch (method) {
      case 'Nakit':
        return Icons.money;
      case 'Kredi Kartı':
        return Icons.credit_card;
      case 'Dijital Cüzdan':
        return Icons.account_balance_wallet;
      default:
        return Icons.money;
    }
  }

  String _getPaymentSubtitle(String method) {
    switch (method) {
      case 'Nakit':
        return 'Peşin Ödeme';
      case 'Kredi Kartı':
        return 'Güvenli Ödeme';
      case 'Dijital Cüzdan':
        return 'PayPal, Apple Pay';
      default:
        return 'Peşin Ödeme';
    }
  }

  void _showPaymentMethodDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Ödeme Yöntemi Seçin'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildPaymentOptionTile('Nakit', 'Peşin Ödeme', Icons.money, Colors.green),
            _buildPaymentOptionTile('Kredi Kartı', 'Güvenli Ödeme', Icons.credit_card, Colors.blue),
            _buildPaymentOptionTile('Dijital Cüzdan', 'PayPal, Apple Pay', Icons.account_balance_wallet, Colors.purple),
          ],
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

  Widget _buildPaymentOptionTile(String title, String subtitle, IconData icon, Color color) {
    final isSelected = selectedPaymentMethod == title;
    
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? color : Color(AppConstants.textPrimaryColorValue),
        ),
      ),
      subtitle: Text(subtitle),
      trailing: isSelected ? Icon(Icons.check, color: color) : null,
      onTap: () {
        _selectPaymentMethod(title);
        Navigator.pop(context);
      },
    );
  }



  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) => _buildFilterDialog(),
    );
  }

  Widget _buildFilterDialog() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Filtreler',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(AppConstants.textPrimaryColorValue),
                  ),
                ),
                const SizedBox(height: 20),
                
                // Şehir Seçimi
                Text(
                  'Şehir',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(AppConstants.textPrimaryColorValue),
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: selectedCity,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  items: cities.map((city) => DropdownMenuItem(
                    value: city,
                    child: Text(city),
                  )).toList(),
                  onChanged: (value) => setState(() => selectedCity = value!),
                ),
                const SizedBox(height: 20),
                
                // Araç Tipi
                Text(
                  'Araç Tipi',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(AppConstants.textPrimaryColorValue),
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: selectedVehicleType,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  items: vehicleTypes.map((type) => DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  )).toList(),
                  onChanged: (value) => setState(() => selectedVehicleType = value!),
                ),
                const SizedBox(height: 10),
                
                // Minimum Puan
                Text(
                  'Minimum Puan: ${selectedRating > 0 ? selectedRating.toStringAsFixed(1) : "Tümü"}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(AppConstants.textPrimaryColorValue),
                  ),
                ),
                const SizedBox(height: 3),
                Slider(
                  value: selectedRating,
                  min: 0,
                  max: 10,
                  divisions: 20,
                  activeColor: Color(AppConstants.primaryColorValue),
                  onChanged: (value) => setState(() => selectedRating = value),
                ),
                const SizedBox(height: 10),
                
                // Dil Seçimi
                Text(
                  'Dil',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(AppConstants.textPrimaryColorValue),
                  ),
                ),
                const SizedBox(height: 3),
                DropdownButtonFormField<String>(
                  value: selectedLanguage,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  items: languages.map((language) => DropdownMenuItem(
                    value: language,
                    child: Text(language),
                  )).toList(),
                  onChanged: (value) => setState(() => selectedLanguage = value!),
                ),
                const SizedBox(height: 12),
                
                // Fiyat Aralığı
                Text(
                  'Fiyat Aralığı: ${minPrice.toInt()} - ${maxPrice.toInt()} TL',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(AppConstants.textPrimaryColorValue),
                  ),
                ),
                const SizedBox(height: 4),
                RangeSlider(
                  values: RangeValues(minPrice, maxPrice),
                  min: 0,
                  max: 500,
                  divisions: 50,
                  activeColor: Color(AppConstants.primaryColorValue),
                  onChanged: (values) => setState(() {
                    minPrice = values.start;
                    maxPrice = values.end;
                  }),
                ),
                const SizedBox(height: 15),
                
                // Butonlar
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            selectedCategory = 'Tümü';
                            selectedCity = 'İstanbul';
                            selectedVehicleType = 'Tümü';
                            selectedRating = 0.0;
                            showOnlineOnly = false;
                            showVerifiedOnly = false;
                            selectedLanguage = 'Tümü';
                            minPrice = 0.0;
                            maxPrice = 500.0;
                          });
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text('Sıfırla'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(AppConstants.primaryColorValue),
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text('Uygula', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DriverCard extends StatefulWidget {
  final Map<String, dynamic> driver;

  const _DriverCard({required this.driver});

  @override
  State<_DriverCard> createState() => _DriverCardState();
}

class _DriverCardState extends State<_DriverCard> {
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        if (_currentPage < 2) {
          _pageController.nextPage(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        } else {
          _pageController.animateToPage(
            0,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240, // Mesaj butonu kaldırıldığı için yüksekliği azalttık
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(AppConstants.surfaceColorValue),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Color(AppConstants.primaryColorValue).withValues(alpha: 0.2),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(AppConstants.primaryColorValue).withValues(alpha: 0.15),
            blurRadius: 15,
            offset: Offset(0, 4),
            spreadRadius: 2,
          ),
          BoxShadow(
            color: Color(AppConstants.shadowLightColorValue).withValues(alpha: 0.1),
            blurRadius: 20,
            offset: Offset(0, 8),
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        children: [
          // Sayfa göstergeleri
          Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: Color(AppConstants.primaryColorValue).withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) => AnimatedContainer(
                duration: Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: 3),
                width: _currentPage == index ? 24 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _currentPage == index 
                    ? Color(AppConstants.primaryColorValue) 
                    : Colors.grey[400],
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: _currentPage == index ? [
                    BoxShadow(
                      color: Color(AppConstants.primaryColorValue).withValues(alpha: 0.3),
                      blurRadius: 4,
            offset: Offset(0, 2),
          ),
                  ] : null,
                ),
              )),
            ),
          ),
          SizedBox(height: 8),
          
          // Kaydırmalı içerik
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                _buildProfilePage(),
                _buildDetailsPage(),
                _buildReviewsPage(),
              ],
            ),
          ),
          

        ],
      ),
    );
  }

  Widget _buildProfilePage() {
    return Container(
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
        children: [
          Stack(
            children: [
              ClipOval(
                child: Container(
                  width: 60,
                  height: 60,
                  child: Image.network(
                        widget.driver['image'],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                              color: Color(AppConstants.primaryColorValue).withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                              Icons.directions_car,
                          size: 30,
                          color: Color(AppConstants.primaryColorValue),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                        color: widget.driver['isOnline'] 
                        ? Color(AppConstants.onlineColorValue)
                        : Color(AppConstants.offlineColorValue),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Color(AppConstants.surfaceColorValue),
                      width: 2,
                    ),
                      ),
                    ),
                  ),
                  if (widget.driver['isVerified'])
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.verified,
                          color: Colors.white,
                          size: 12,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
              children: [
                    Text(
                      widget.driver['name'],
                  style: TextStyle(
                    color: Color(AppConstants.textPrimaryColorValue),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                          ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Color(AppConstants.warningColorValue),
                          size: 16,
                        ),
                        SizedBox(width: 4),
                        Text(
                          '${widget.driver['rating']}/10',
                          style: TextStyle(
                            color: Color(AppConstants.textPrimaryColorValue),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2),
                    Text(
                      widget.driver['price'],
                      style: TextStyle(
                        color: Color(AppConstants.primaryColorValue),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2),
                Row(
                  children: [
                    Icon(
                          Icons.directions_car,
                          color: Color(AppConstants.primaryColorValue),
                          size: 14,
                    ),
                    SizedBox(width: 4),
                    Text(
                          widget.driver['car'],
                      style: TextStyle(
                            color: Color(AppConstants.textPrimaryColorValue),
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.location_city,
                          color: Color(AppConstants.primaryColorValue),
                          size: 14,
                        ),
                        SizedBox(width: 4),
                Text(
                          widget.driver['city'],
                  style: TextStyle(
                            color: Color(AppConstants.textPrimaryColorValue),
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.language,
              color: Color(AppConstants.primaryColorValue),
                          size: 14,
            ),
                        SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            widget.driver['languages'].join(', '),
              style: TextStyle(
                              color: Color(AppConstants.textPrimaryColorValue),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
              ),
            ),
                      ],
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

  Widget _buildDetailsPage() {
    return Container(
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildDetailRow(Icons.work, 'Deneyim', widget.driver['experience']),
          _buildDetailRow(Icons.category, 'Kategori', widget.driver['category']),
          _buildDetailRow(Icons.attach_money, 'Fiyat', widget.driver['price']),
          _buildDetailRow(Icons.access_time, 'Yanıt Süresi', widget.driver['responseTime']),
          _buildDetailRow(Icons.directions_car_filled, 'Toplam Seyahat', '${widget.driver['totalRides']}'),

        ],
      ),
    );
  }

  Widget _buildReviewsPage() {
    // Örnek yorumlar
    final List<Map<String, dynamic>> reviews = [
      {'name': 'Ayşe K.', 'rating': 5, 'comment': 'Çok güvenli ve temiz bir sürüş deneyimi yaşadım.'},
      {'name': 'Mehmet A.', 'rating': 5, 'comment': 'Zamanında geldi, çok nazik bir sürücü.'},
      {'name': 'Fatma S.', 'rating': 4, 'comment': 'İyi bir deneyimdi, tavsiye ederim.'},
    ];

    return Container(
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...reviews.map((review) => Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
          Row(
        children: [
                    Text(
                      review['name'] as String,
                      style: TextStyle(
                        color: Color(AppConstants.textPrimaryColorValue),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8),
                    Row(
                      children: List.generate(5, (i) => Icon(
                        Icons.star,
                        size: 14,
                        color: i < (review['rating'] as int)
                          ? Color(AppConstants.warningColorValue)
                          : Colors.grey[300],
                      )),
                    ),
                  ],
                ),
                SizedBox(height: 2),
                Text(
                  review['comment'] as String,
                  style: TextStyle(
                    color: Color(AppConstants.textPrimaryColorValue),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            icon,
            color: Color(AppConstants.primaryColorValue),
            size: 16,
          ),
          SizedBox(width: 8),
          Text(
            '$label: ',
            style: TextStyle(
              color: Color(AppConstants.textPrimaryColorValue),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: Color(AppConstants.textPrimaryColorValue),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
} 