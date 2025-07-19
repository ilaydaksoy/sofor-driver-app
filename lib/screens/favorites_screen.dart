import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Map<String, dynamic>> favoriteDrivers = [
    {
      'name': 'Ahmet Yılmaz',
      'city': 'İstanbul',
      'rating': 4.9,
      'vehicle': 'Mercedes Vito',
      'image': 'https://randomuser.me/api/portraits/men/32.jpg',
    },
    {
      'name': 'Fatma Demir',
      'city': 'Antalya',
      'rating': 4.8,
      'vehicle': 'Volkswagen Caravelle',
      'image': 'https://randomuser.me/api/portraits/women/44.jpg',
    },
  ];

  void _removeFromFavorites(int index) {
    setState(() {
      favoriteDrivers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Column(
        children: [
          // Sarı-siyah başlık kutusu
          Container(
            width: double.infinity,
            height: 160,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: Color(AppConstants.primaryColorValue),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 16),
                Text(
                  'Favori Sürücüler',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  '${favoriteDrivers.length} favori sürücü',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Expanded(
            child: favoriteDrivers.isEmpty
                ? Center(
                    child: Text(
                      'Henüz favori sürücünüz yok.',
                      style: TextStyle(fontSize: 16, color: Color(0xFF888888)),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: favoriteDrivers.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final driver = favoriteDrivers[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 2,
                        color: Colors.white,
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          leading: ClipOval(
                            child: Container(
                              width: 56,
                              height: 56,
                              child: Image.network(
                                driver['image'],
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 56,
                                    height: 56,
                                    decoration: BoxDecoration(
                                      color: Color(AppConstants.primaryColorValue).withOpacity(0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.person,
                                      size: 28,
                                      color: Color(AppConstants.primaryColorValue),
                                    ),
                                  );
                                },
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Container(
                                    width: 56,
                                    height: 56,
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
                          title: Text(
                            driver['name'],
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF111111)),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.location_on, size: 16, color: Color(AppConstants.primaryColorValue)),
                                  const SizedBox(width: 4),
                                  Text(driver['city'], style: TextStyle(color: Color(0xFF444444))),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.star, size: 16, color: Color(AppConstants.primaryColorValue)),
                                  const SizedBox(width: 4),
                                  Text(driver['rating'].toString(), style: TextStyle(color: Color(0xFF444444))),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.directions_car, size: 16, color: Color(0xFF888888)),
                                  const SizedBox(width: 4),
                                  Text(driver['vehicle'], style: TextStyle(color: Color(0xFF444444))),
                                ],
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.favorite, color: Color(0xFF111111)), // Siyah kalp
                            tooltip: 'Favorilerden çıkar',
                            onPressed: () => _removeFromFavorites(index),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
} 