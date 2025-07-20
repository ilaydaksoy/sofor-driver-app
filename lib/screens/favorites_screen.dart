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
      'rating': 9.2,
      'totalRides': 1247,
      'experience': '8 yıl',
      'vehicle': 'Mercedes Vito',
      'vehicleYear': '2022',
      'plate': '34 ABC 123',
      'image': 'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=150&h=150&fit=crop&crop=face',
      'isOnline': true,
      'lastSeen': '2 dakika önce',
      'languages': ['Türkçe', 'İngilizce', 'Almanca'],
      'specialties': ['Havalimanı Transferi', 'Şehir Turu', 'İş Seyahati'],
      'reviews': [
        {'user': 'Mehmet K.', 'rating': 9.5, 'comment': 'Çok güvenilir ve temiz araç'},
        {'user': 'Ayşe D.', 'rating': 9.0, 'comment': 'Punctual ve profesyonel'},
      ],
    },
    {
      'name': 'Fatma Demir',
      'city': 'Antalya',
      'rating': 9.8,
      'totalRides': 892,
      'experience': '5 yıl',
      'vehicle': 'Volkswagen Caravelle',
      'vehicleYear': '2023',
      'plate': '07 XYZ 789',
      'image': 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&h=150&fit=crop&crop=face',
      'isOnline': false,
      'lastSeen': '1 saat önce',
      'languages': ['Türkçe', 'İngilizce', 'Rusça'],
      'specialties': ['Turistik Transfer', 'Grup Seyahati', 'VIP Hizmet'],
      'reviews': [
        {'user': 'Ali V.', 'rating': 10.0, 'comment': 'Mükemmel hizmet, çok memnun kaldım'},
        {'user': 'Zeynep K.', 'rating': 9.5, 'comment': 'Çok nazik ve yardımsever'},
      ],
    },
    {
      'name': 'Mehmet Özkan',
      'city': 'İzmir',
      'rating': 8.9,
      'totalRides': 567,
      'experience': '3 yıl',
      'vehicle': 'BMW 520d',
      'vehicleYear': '2021',
      'plate': '35 DEF 456',
      'image': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
      'isOnline': true,
      'lastSeen': 'Şimdi',
      'languages': ['Türkçe', 'İngilizce'],
      'specialties': ['İş Seyahati', 'Şehir İçi Transfer'],
      'reviews': [
        {'user': 'Can B.', 'rating': 8.5, 'comment': 'Güvenli sürüş, temiz araç'},
        {'user': 'Elif S.', 'rating': 9.0, 'comment': 'Çok düzenli ve zamanında'},
      ],
    },
  ];

  void _removeFromFavorites(int index) {
    setState(() {
      favoriteDrivers.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${favoriteDrivers[index]['name']} favorilerden çıkarıldı'),
        action: SnackBarAction(
          label: 'Geri Al',
          onPressed: () {
            setState(() {
              favoriteDrivers.insert(index, favoriteDrivers[index]);
            });
          },
        ),
      ),
    );
  }

  void _showDriverDetails(Map<String, dynamic> driver) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildDriverDetailSheet(driver),
    );
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.favorite_border,
                          size: 80,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Henüz favori sürücünüz yok',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Sürücüleri favorilere ekleyerek\nhızlıca ulaşabilirsiniz',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: favoriteDrivers.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final driver = favoriteDrivers[index];
                      return _buildDriverCard(driver, index);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildDriverCard(Map<String, dynamic> driver, int index) {
    return GestureDetector(
      onTap: () => _showDriverDetails(driver),
      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
        elevation: 4,
                        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  // Profil Fotoğrafı
                  Stack(
                    children: [
                      ClipOval(
                        child: Container(
                          width: 70,
                          height: 70,
                          child: Image.network(
                            driver['image'],
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: Color(AppConstants.primaryColorValue).withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.person,
                                  size: 35,
                                  color: Color(AppConstants.primaryColorValue),
                                ),
                              );
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                width: 70,
                                height: 70,
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
                      // Online durumu
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: driver['isOnline'] ? Colors.green : Colors.grey,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  // Sürücü Bilgileri
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
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Color(0xFF111111),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.favorite,
                                color: Colors.red[400],
                                size: 24,
                              ),
                              onPressed: () => _removeFromFavorites(index),
                            ),
                          ],
                        ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.location_on, size: 16, color: Color(AppConstants.primaryColorValue)),
                                  const SizedBox(width: 4),
                            Text(
                              driver['city'],
                              style: TextStyle(color: Color(0xFF444444), fontSize: 14),
                            ),
                            const SizedBox(width: 12),
                            Icon(Icons.circle, size: 8, color: Colors.grey),
                            const SizedBox(width: 12),
                            Text(
                              driver['isOnline'] ? 'Çevrimiçi' : driver['lastSeen'],
                              style: TextStyle(
                                color: driver['isOnline'] ? Colors.green : Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                                ],
                              ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.star, size: 16, color: Colors.amber),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                '${driver['rating']}/10',
                                style: TextStyle(
                                  color: Color(0xFF111111),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                '(${driver['totalRides']} seyahat)',
                                style: TextStyle(color: Color(0xFF666666), fontSize: 12),
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
              const SizedBox(height: 12),
              // Araç Bilgileri
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(AppConstants.primaryColorValue).withOpacity(0.05),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.directions_car, size: 16, color: Color(AppConstants.primaryColorValue)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '${driver['vehicle']} (${driver['vehicleYear']})',
                        style: TextStyle(
                          color: Color(0xFF111111),
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Color(AppConstants.primaryColorValue),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        driver['plate'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              // Aksiyon Butonları
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
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Sürücüyü seç
                      },
                      icon: Icon(Icons.directions_car, size: 16),
                      label: Text('Seç'),
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
        ),
      ),
    );
  }

  Widget _buildDriverDetailSheet(Map<String, dynamic> driver) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Sürücü Başlık
                  Row(
                    children: [
                      ClipOval(
                        child: Container(
                          width: 80,
                          height: 80,
                          child: Image.network(
                            driver['image'],
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Color(AppConstants.primaryColorValue).withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.person,
                                  size: 40,
                                  color: Color(AppConstants.primaryColorValue),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              driver['name'],
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF111111),
                              ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                Icon(Icons.location_on, size: 16, color: Color(AppConstants.primaryColorValue)),
                                const SizedBox(width: 4),
                                Text(
                                  driver['city'],
                                  style: TextStyle(color: Color(0xFF444444), fontSize: 16),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.star, size: 20, color: Colors.amber),
                                  const SizedBox(width: 4),
                                Text(
                                  '${driver['rating']}/10',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF111111),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '${driver['totalRides']} seyahat',
                                  style: TextStyle(color: Color(0xFF666666), fontSize: 14),
                                ),
                                ],
                              ),
                            ],
                          ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Araç Bilgileri
                  _buildDetailSection(
                    'Araç Bilgileri',
                    [
                      _buildDetailRow('Araç Modeli', driver['vehicle']),
                      _buildDetailRow('Model Yılı', driver['vehicleYear']),
                      _buildDetailRow('Plaka', driver['plate']),
                      _buildDetailRow('Deneyim', driver['experience']),
                    ],
                  ),
                  const SizedBox(height: 20),
                  
                  // Dil Bilgileri
                  _buildDetailSection(
                    'Konuştuğu Diller',
                    [
                      _buildDetailRow('Diller', driver['languages'].join(', ')),
                    ],
                  ),
                  const SizedBox(height: 20),
                  
                  // Uzmanlık Alanları
                  _buildDetailSection(
                    'Uzmanlık Alanları',
                    [
                      _buildDetailRow('Özel Hizmetler', driver['specialties'].join(', ')),
                    ],
                  ),
                  const SizedBox(height: 20),
                  
                  // Son Yorumlar
                  _buildDetailSection(
                    'Son Yorumlar',
                    driver['reviews'].map<Widget>((review) => 
                      _buildReviewItem(review)
                    ).toList(),
                  ),
                  const SizedBox(height: 24),
                  
                  // Aksiyon Butonları
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, '/chat');
                          },
                          icon: Icon(Icons.message, size: 20),
                          label: Text('Mesaj Gönder', style: TextStyle(fontSize: 16)),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Color(AppConstants.primaryColorValue),
                            side: BorderSide(color: Color(AppConstants.primaryColorValue)),
                            padding: EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                            // Sürücüyü seç
                          },
                          icon: Icon(Icons.directions_car, size: 20),
                          label: Text('Sürücüyü Seç', style: TextStyle(fontSize: 16)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(AppConstants.primaryColorValue),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF111111),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                color: Color(0xFF666666),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: Color(0xFF111111),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewItem(Map<String, dynamic> review) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: Color(AppConstants.primaryColorValue),
                child: Text(
                  review['user'][0],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  review['user'],
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111111),
                  ),
                ),
              ),
              Row(
                children: [
                  Icon(Icons.star, size: 16, color: Colors.amber),
                  const SizedBox(width: 4),
                  Text(
                    '${review['rating']}/10',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF111111),
                          ),
                        ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            review['comment'],
            style: TextStyle(
              color: Color(0xFF666666),
              fontSize: 14,
                  ),
          ),
        ],
      ),
    );
  }
} 