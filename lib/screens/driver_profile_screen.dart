import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class DriverProfileScreen extends StatelessWidget {
  final Map<String, dynamic> driver;
  const DriverProfileScreen({required this.driver, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> carImages = [
      'https://images.unsplash.com/photo-1503376780353-7e6692767b70?auto=format&fit=crop&w=400&q=80',
      'https://images.unsplash.com/photo-1465101178521-c1a9136a3b99?auto=format&fit=crop&w=400&q=80',
      'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?auto=format&fit=crop&w=400&q=80',
    ];
    final List<Map<String, dynamic>> reviews = [
      {'user': 'Ali', 'comment': 'Çok iyi bir yolculuktu!', 'rating': 5},
      {'user': 'Zeynep', 'comment': 'Şoför çok kibar ve dakikti.', 'rating': 4.8},
      {'user': 'John', 'comment': 'Great experience, highly recommended!', 'rating': 5},
    ];
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        title: const Text(
          'Sürücü Detayı',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(AppConstants.primaryColorValue),
        foregroundColor: Colors.white,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Profil üst kısmı
            Container(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              decoration: BoxDecoration(
                color: Color(0xFFE53E3E),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Column(
                children: [
                  ClipOval(
                    child: Container(
                      width: 96,
                      height: 96,
                      child: Image.network(
                        driver['image'] ?? driver['avatar'] ?? '',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 96,
                            height: 96,
                            decoration: BoxDecoration(
                              color: Color(AppConstants.primaryColorValue).withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.person,
                              size: 48,
                              color: Color(AppConstants.primaryColorValue),
                            ),
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            width: 96,
                            height: 96,
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
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    driver['name'] ?? '',
                    style: TextStyle(
                      color: Color(0xFF111111),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on, color: Color(0xFF111111), size: 18),
                      const SizedBox(width: 4),
                      Text(
                        driver['city'] ?? '',
                        style: TextStyle(color: Color(0xFF444444), fontSize: 15),
                      ),
                      const SizedBox(width: 16),
                      Icon(Icons.circle, color: (driver['isOnline'] ?? false) ? Color(AppConstants.primaryColorValue) : Color(0xFF888888), size: 12),
                      const SizedBox(width: 4),
                      Text(
                        (driver['isOnline'] ?? false) ? 'Çevrimiçi' : 'Çevrimdışı',
                        style: TextStyle(color: Color(0xFF444444), fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star, color: Color(AppConstants.primaryColorValue), size: 20),
                      const SizedBox(width: 4),
                      Text(
                        '${driver['rating'] ?? 0}/10',
                        style: TextStyle(color: Color(0xFF111111), fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(width: 16),
                      Icon(Icons.directions_car, color: Color(0xFF888888), size: 20),
                      const SizedBox(width: 4),
                      Text(
                        driver['car'] ?? '',
                        style: TextStyle(color: Color(0xFF444444), fontSize: 15),
                      ),
                      const SizedBox(width: 16),
                      Icon(Icons.timer, color: Color(0xFF888888), size: 20),
                      const SizedBox(width: 4),
                      Text(
                        driver['experience'] ?? '',
                        style: TextStyle(color: Color(0xFF444444), fontSize: 15),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Araç görselleri carousel
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Araç Görselleri', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF111111))),
                  const SizedBox(height: 12),
            SizedBox(
                    height: 110,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: carImages.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) => ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    carImages[index],
                    width: 180,
                    height: 110,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 180,
                        height: 110,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.directions_car,
                          size: 40,
                          color: Colors.grey[400],
                        ),
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        width: 180,
                        height: 110,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
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
                ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // İletişim ve aksiyon butonları
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.phone),
                    label: Text('Ara'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(AppConstants.primaryColorValue),
                      foregroundColor: Color(0xFF111111),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
            ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.message),
                    label: Text('Mesaj'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF111111),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                IconButton(
                    icon: Icon(Icons.favorite, color: Color(0xFF111111), size: 32),
                    tooltip: 'Favorilere ekle/çıkar',
                  onPressed: () {},
                ),
              ],
              ),
            ),
            const SizedBox(height: 24),
            // Yorumlar ve değerlendirmeler
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Yorumlar', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF111111))),
                  const SizedBox(height: 12),
            ...reviews.map((review) => Card(
              margin: const EdgeInsets.only(bottom: 8),
                    color: Color(0xFFF5F5F5),
              child: ListTile(
                      leading: CircleAvatar(child: Text(review['user'][0], style: TextStyle(color: Color(0xFF111111)))),
                      title: Text(review['user'], style: TextStyle(color: Color(0xFF111111))),
                      subtitle: Text(review['comment'], style: TextStyle(color: Color(0xFF444444))),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                          Icon(Icons.star, color: Color(AppConstants.primaryColorValue), size: 18),
                          Text(review['rating'].toString(), style: TextStyle(color: Color(0xFF111111))),
                  ],
                ),
              ),
            )),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Ekstra bilgiler
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Sürücü Hakkında', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF111111))),
                  const SizedBox(height: 8),
                  Text(
                    'Kısa biyografi veya açıklama buraya eklenebilir. Sürücünün deneyimi, ilgi alanları veya yolculara mesajı gibi bilgiler burada yer alabilir.',
                    style: TextStyle(fontSize: 15, color: Color(0xFF444444)),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.verified, color: Color(AppConstants.primaryColorValue), size: 20),
                      const SizedBox(width: 6),
                      Text('Onaylı Sürücü', style: TextStyle(color: Color(AppConstants.primaryColorValue), fontWeight: FontWeight.w600)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
} 