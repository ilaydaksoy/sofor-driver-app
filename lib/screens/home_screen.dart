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
              icon: Icon(Icons.settings_outlined),
              activeIcon: Icon(Icons.settings),
              label: 'Ayarlar',
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
  final List<Map<String, dynamic>> drivers = [
    {
      'name': 'Ahmet Yılmaz',
      'rating': 4.8,
      'experience': '5 yıl',
      'car': 'Mercedes C200',
      'city': 'İstanbul',
      'image': 'https://randomuser.me/api/portraits/men/1.jpg',
      'isOnline': true,
    },
    {
      'name': 'Mehmet Kaya',
      'rating': 4.9,
      'experience': '8 yıl',
      'car': 'BMW 320i',
      'city': 'Ankara',
      'image': 'https://randomuser.me/api/portraits/men/2.jpg',
      'isOnline': true,
    },
    {
      'name': 'Ali Demir',
      'rating': 4.7,
      'experience': '3 yıl',
      'car': 'Audi A4',
      'city': 'İzmir',
      'image': 'https://randomuser.me/api/portraits/men/3.jpg',
      'isOnline': false,
    },
  ];

  final List<Map<String, String>> banners = [
    {
      'title': 'İlk Yolculuğunda %20 İndirim!',
      'desc': 'Kampanyadan hemen yararlan.',
      'color': '0xFFD32F2F', // Kırmızı
    },
    {
      'title': '7/24 Destek Hattı',
      'desc': 'Her zaman yanınızdayız.',
      'color': '0xFFD32F2F', // Kırmızı
    },
    {
      'title': 'Güvenli Sürücüler',
      'desc': 'Tüm sürücülerimiz onaylı ve puanlıdır.',
      'color': '0xFFD32F2F', // Kırmızı
    },
  ];

  List<Map<String, dynamic>> get filteredDrivers {
    if (searchQuery.isEmpty) return drivers;
    final query = searchQuery.toLowerCase();
    return drivers.where((driver) =>
      driver['name'].toLowerCase().contains(query) ||
      driver['car'].toLowerCase().contains(query) ||
      driver['experience'].toLowerCase().contains(query) ||
      driver['city'].toLowerCase().contains(query)
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
        // Arama Çubuğu
        TextField(
          decoration: InputDecoration(
            hintText: 'Sürücü, araç, şehir veya deneyim ara...',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                        ),
          onChanged: (val) => setState(() => searchQuery = val),
                  ),
        const SizedBox(height: 20),
        // Kaydırmalı Reklamlar
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
                      color: Colors.black.withOpacity(0.07),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                        ),
                      ],
                    ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                      banner['title']!,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                    const SizedBox(height: 8),
                              Text(
                      banner['desc']!,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        // Nokta Göstergeleri
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
        const SizedBox(height: 20),
                  // Recommended Drivers Section
                  Text(
                    'Önerilen Sürücüler',
                    style: TextStyle(
                      color: Color(AppConstants.textPrimaryColorValue),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
        if (filteredDrivers.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 32),
              child: Text(
                'Sonuç bulunamadı.',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
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
              child: _DriverCard(
                name: driver['name'],
                rating: driver['rating'],
                experience: driver['experience'],
                car: driver['car'],
                image: driver['image'],
                isOnline: driver['isOnline'],
                  ),
              ),
          )),
        ],
    );
  }
}

class _DriverCard extends StatelessWidget {
  final String name;
  final double rating;
  final String experience;
  final String car;
  final String image;
  final bool isOnline;

  const _DriverCard({
    required this.name,
    required this.rating,
    required this.experience,
    required this.car,
    required this.image,
    required this.isOnline,
  });

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
      child: Row(
        children: [
          Stack(
            children: [
              ClipOval(
                child: Container(
                  width: 60,
                  height: 60,
                  child: Image.network(
                    image,
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
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          shape: BoxShape.circle,
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
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: isOnline 
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
            ],
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
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
                      rating.toString(),
                      style: TextStyle(
                        color: Color(AppConstants.textSecondaryColorValue),
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '• $experience deneyim',
                      style: TextStyle(
                        color: Color(AppConstants.textSecondaryColorValue),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  car,
                  style: TextStyle(
                    color: Color(AppConstants.textTertiaryColorValue),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Color(AppConstants.primaryColorValue),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Seç',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;

  const _QuickActionCard({
    required this.icon,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(AppConstants.surfaceColorValue),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Color(AppConstants.borderColorValue),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(AppConstants.shadowLightColorValue).withOpacity(0.1),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              color: Color(AppConstants.textPrimaryColorValue),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
} 