import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import 'chat_screen.dart';
import 'favorites_screen.dart';
import 'settings_screen.dart';
import 'driver_profile_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  
  final List<Widget> _screens = [
    _HomeContent(),
    ChatScreen(),
    FavoritesScreen(),
    SettingsScreen(),
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
              icon: Icon(Icons.favorite_outline),
              activeIcon: Icon(Icons.favorite),
              label: 'Favoriler',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Hesabım',
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(AppConstants.backgroundColorValue),
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: 120,
            floating: false,
            pinned: true,
            backgroundColor: Color(AppConstants.primaryColorValue),
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Sürücü Bul',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Container(
                color: Color(AppConstants.primaryColorValue),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.notifications_outlined, color: Colors.white),
                onPressed: () {
                  // Bildirimler sayfası
                },
              ),
              IconButton(
                icon: Icon(Icons.location_on_outlined, color: Colors.white),
                onPressed: () {
                  // Konum seçimi
                },
              ),
            ],
          ),
          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _HomeContentBody(),
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
        // Arama Çubuğu
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
          child: TextField(
          decoration: InputDecoration(
              hintText: 'Sürücü, araç, şehir veya hizmet ara...',
              prefixIcon: Icon(Icons.search, color: Color(AppConstants.primaryColorValue)),
              suffixIcon: IconButton(
                icon: Icon(Icons.tune, color: Color(AppConstants.primaryColorValue)),
                onPressed: () => _showFilterDialog(),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            filled: true,
            fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                        ),
          onChanged: (val) => setState(() => searchQuery = val),
          ),
                  ),
        const SizedBox(height: 20),

        // Hızlı Filtreler
        _buildQuickFilters(),
        const SizedBox(height: 20),

        // Kaydırmalı Reklamlar
        _buildBannerSection(),
        const SizedBox(height: 20),

        // Önerilen Sürücüler
        _buildDriversSection(),
        const SizedBox(height: 20),

        // Hızlı Aksiyonlar
        _buildQuickActions(),
        const SizedBox(height: 20),

        // Araç Reklamları
        _buildVehicleAdsSection(),
        const SizedBox(height: 20),

        // Kategoriler
        _buildCategoriesSection(),
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

  Widget _buildBannerSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kampanyalar',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(AppConstants.textPrimaryColorValue),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
                    height: 120,
          child: PageView.builder(
            itemCount: banners.length,
            controller: PageController(viewportFraction: 0.88),
            onPageChanged: (i) => setState(() => _currentBanner = i),
            itemBuilder: (context, i) {
              final banner = banners[i];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 6),
                padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                  color: Color(int.parse(banner['color']!)),
                  borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                        ),
                      ],
                    ),
                child: Row(
                  children: [
                    Icon(
                      banner['icon'],
                      color: Colors.white,
                      size: 32,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                      banner['title']!,
                                style: TextStyle(
                                  color: Colors.white,
                              fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                          const SizedBox(height: 4),
                              Text(
                      banner['desc']!,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                              fontSize: 12,
                            ),
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
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(banners.length, (i) => AnimatedContainer(
            duration: Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: _currentBanner == i ? 18 : 7,
            height: 7,
            decoration: BoxDecoration(
              color: _currentBanner == i ? Color(AppConstants.primaryColorValue) : Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
                  ),
          )),
        ),
      ],
    );
  }

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
                Icon(Icons.location_on, color: Colors.red, size: 16),
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
      case 'Kripto Para':
        return Colors.orange;
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
      case 'Kripto Para':
        return Icons.currency_bitcoin;
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
      case 'Kripto Para':
        return 'Bitcoin, Ethereum';
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
            _buildPaymentOptionTile('Kripto Para', 'Bitcoin, Ethereum', Icons.currency_bitcoin, Colors.orange),
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
      builder: (context) => _buildFilterDialog(),
    );
  }

  Widget _buildFilterDialog() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
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
                const SizedBox(height: 20),
                
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

class _DriverCard extends StatelessWidget {
  final Map<String, dynamic> driver;

  const _DriverCard({required this.driver});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(AppConstants.surfaceColorValue),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Color(AppConstants.borderColorValue),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(AppConstants.shadowLightColorValue).withOpacity(0.08),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
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
                        driver['image'],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Color(AppConstants.primaryColorValue).withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.person,
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
                        color: driver['isOnline'] 
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
                  if (driver['isVerified'])
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
              children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            driver['name'],
                  style: TextStyle(
                    color: Color(AppConstants.textPrimaryColorValue),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                          ),
                        ),
                        Text(
                          driver['price'],
                          style: TextStyle(
                            color: Color(AppConstants.primaryColorValue),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
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
                          '${driver['rating']}/10',
                      style: TextStyle(
                        color: Color(AppConstants.textSecondaryColorValue),
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                          '• ${driver['totalRides']} seyahat',
                      style: TextStyle(
                        color: Color(AppConstants.textSecondaryColorValue),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.directions_car,
                          color: Color(AppConstants.primaryColorValue),
                          size: 14,
                        ),
                        SizedBox(width: 4),
                Text(
                          driver['car'],
                  style: TextStyle(
                    color: Color(AppConstants.textTertiaryColorValue),
                    fontSize: 12,
                  ),
                ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.access_time,
              color: Color(AppConstants.primaryColorValue),
                          size: 14,
            ),
                        SizedBox(width: 4),
                        Text(
                          driver['responseTime'],
              style: TextStyle(
                            color: Color(AppConstants.textTertiaryColorValue),
                fontSize: 12,
              ),
            ),
                      ],
          ),
        ],
      ),
          ),
        ],
      ),
          SizedBox(height: 12),
          Row(
        children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/chat');
                  },
                  icon: Icon(Icons.message, size: 16),
                  label: Text('Mesaj'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Color(AppConstants.primaryColorValue),
                    side: BorderSide(color: Color(AppConstants.primaryColorValue)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
            ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DriverProfileScreen(driver: driver),
            ),
                    );
                  },
                  icon: Icon(Icons.person, size: 16),
                  label: Text('Profil'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(AppConstants.primaryColorValue),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
            ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
} 