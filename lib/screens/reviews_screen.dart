import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class ReviewsScreen extends StatefulWidget {
  @override
  _ReviewsScreenState createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  String selectedFilter = 'Tümü';
  
  final List<String> filters = ['Tümü', '5 Yıldız', '4 Yıldız', '3 Yıldız', '2 Yıldız', '1 Yıldız'];
  
  final List<Map<String, dynamic>> reviews = [
    {
      'id': '1',
      'customerName': 'Ahmet Yılmaz',
      'customerImage': 'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=150&h=150&fit=crop&crop=face',
      'rating': 5,
      'comment': 'Çok güvenli ve temiz bir sürüş deneyimi yaşadım. Ahmet bey çok nazik ve profesyoneldi. Zamanında geldi ve güvenli bir şekilde gideceğim yere ulaştı. Kesinlikle tavsiye ederim!',
      'date': '2024-03-15',
      'tripFrom': 'İstanbul Havalimanı',
      'tripTo': 'Taksim',
      'tripPrice': '150 TL',
      'isVerified': true,
    },
    {
      'id': '2',
      'customerName': 'Fatma Özkan',
      'customerImage': 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&h=150&fit=crop&crop=face',
      'rating': 5,
      'comment': 'Harika bir deneyimdi! Araç çok temiz ve konforluydu. Sürüş çok yumuşaktı ve kendimi güvende hissettim. Tekrar tercih edeceğim.',
      'date': '2024-03-12',
      'tripFrom': 'Kadıköy',
      'tripTo': 'Bostancı',
      'tripPrice': '85 TL',
      'isVerified': true,
    },
    {
      'id': '3',
      'customerName': 'Mehmet Kaya',
      'customerImage': 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=150&h=150&fit=crop&crop=face',
      'rating': 4,
      'comment': 'Genel olarak memnun kaldım. Sadece trafik yoğunluğu nedeniyle biraz gecikmeli vardı ama bu durumun sürücüyle alakası yoktu.',
      'date': '2024-03-10',
      'tripFrom': 'Şişli',
      'tripTo': 'Levent',
      'tripPrice': '65 TL',
      'isVerified': false,
    },
    {
      'id': '4',
      'customerName': 'Ali Demir',
      'customerImage': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
      'rating': 5,
      'comment': 'Mükemmel hizmet! Zamanında geldi, araç çok temizdi ve çok iyi muhabbet ettik. İngilizce de konuşabilmesi çok iyiydi.',
      'date': '2024-03-08',
      'tripFrom': 'Beşiktaş',
      'tripTo': 'Ortaköy',
      'tripPrice': '45 TL',
      'isVerified': true,
    },
    {
      'id': '5',
      'customerName': 'Zeynep Kaya',
      'customerImage': 'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=150&h=150&fit=crop&crop=face',
      'rating': 3,
      'comment': 'Ortalama bir deneyimdi. Araç eski modeldeydi ama temizdi. Sürücü nazikti ama biraz sessizdi.',
      'date': '2024-03-05',
      'tripFrom': 'Üsküdar',
      'tripTo': 'Kadıköy',
      'tripPrice': '40 TL',
      'isVerified': true,
    },
    {
      'id': '6',
      'customerName': 'Can Yıldız',
      'customerImage': 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face',
      'rating': 5,
      'comment': 'Harika bir sürücü! Çok kibar ve yardımsever. Bagajlarımı taşımaya yardım etti. Kesinlikle 5 yıldız hak ediyor.',
      'date': '2024-03-01',
      'tripFrom': 'Atatürk Havalimanı',
      'tripTo': 'Beyoğlu',
      'tripPrice': '120 TL',
      'isVerified': true,
    },
  ];

  // İstatistikler
  double get averageRating {
    if (reviews.isEmpty) return 0.0;
    return reviews.map((r) => r['rating'] as int).reduce((a, b) => a + b) / reviews.length;
  }

  Map<int, int> get ratingDistribution {
    Map<int, int> distribution = {5: 0, 4: 0, 3: 0, 2: 0, 1: 0};
    for (var review in reviews) {
      distribution[review['rating'] as int] = (distribution[review['rating'] as int] ?? 0) + 1;
    }
    return distribution;
  }

  List<Map<String, dynamic>> get filteredReviews {
    if (selectedFilter == 'Tümü') return reviews;
    
    int filterRating = int.parse(selectedFilter.split(' ')[0]);
    return reviews.where((review) => review['rating'] == filterRating).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(AppConstants.backgroundColorValue),
      appBar: AppBar(
        title: Text('Müşteri Yorumları'),
        backgroundColor: Color(AppConstants.primaryColorValue),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Genel istatistikler
            _buildStatsCard(),
            SizedBox(height: 20),
            
            // Puan dağılımı
            _buildRatingDistribution(),
            SizedBox(height: 20),
            
            // Filtre seçimi
            _buildFilterSelector(),
            SizedBox(height: 20),
            
            // Yorumlar başlığı
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Yorumlar (${filteredReviews.length})',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(AppConstants.textPrimaryColorValue),
                  ),
                ),
                Text(
                  'Toplam: ${reviews.length} yorum',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(AppConstants.textSecondaryColorValue),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            
            // Yorumlar listesi
            ...filteredReviews.map((review) => _buildReviewCard(review)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsCard() {
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
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  averageRating.toStringAsFixed(1),
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(AppConstants.primaryColorValue),
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) => Icon(
                    Icons.star,
                    color: index < averageRating.floor() 
                      ? Color(AppConstants.warningColorValue)
                      : Colors.grey[300],
                    size: 20,
                  )),
                ),
                SizedBox(height: 8),
                Text(
                  'Ortalama Puan',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(AppConstants.textSecondaryColorValue),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              children: [
                Text(
                  '${reviews.length}',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(AppConstants.primaryColorValue),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Toplam Yorum',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(AppConstants.textSecondaryColorValue),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '%${((reviews.where((r) => r['rating'] >= 4).length / reviews.length) * 100).toInt()} olumlu',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.green,
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

  Widget _buildRatingDistribution() {
    final distribution = ratingDistribution;
    final maxCount = distribution.values.reduce((a, b) => a > b ? a : b);
    
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
            'Puan Dağılımı',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(AppConstants.textPrimaryColorValue),
            ),
          ),
          SizedBox(height: 16),
          ...List.generate(5, (index) {
            int rating = 5 - index;
            int count = distribution[rating] ?? 0;
            double percentage = maxCount > 0 ? (count / maxCount) : 0;
            
            return Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Text(
                    '$rating',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(AppConstants.textPrimaryColorValue),
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.star, color: Color(AppConstants.warningColorValue), size: 16),
                  SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: percentage,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(AppConstants.primaryColorValue),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    '$count',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(AppConstants.textSecondaryColorValue),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildFilterSelector() {
    return Container(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = selectedFilter == filter;
          
          return Container(
            margin: EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(filter),
              selected: isSelected,
              onSelected: (selected) {
                setState(() => selectedFilter = filter);
              },
              backgroundColor: Colors.white,
              selectedColor: Color(AppConstants.primaryColorValue).withOpacity(0.1),
              labelStyle: TextStyle(
                color: isSelected ? Color(AppConstants.primaryColorValue) : Color(AppConstants.textPrimaryColorValue),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
              side: BorderSide(
                color: isSelected ? Color(AppConstants.primaryColorValue) : Colors.grey[300]!,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildReviewCard(Map<String, dynamic> review) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Müşteri bilgileri ve puan
          Row(
            children: [
              ClipOval(
                child: Container(
                  width: 48,
                  height: 48,
                  child: Image.network(
                    review['customerImage'],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Color(AppConstants.primaryColorValue).withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.person,
                          color: Color(AppConstants.primaryColorValue),
                          size: 24,
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          review['customerName'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Color(AppConstants.textPrimaryColorValue),
                          ),
                        ),
                        if (review['isVerified'])
                          Padding(
                            padding: EdgeInsets.only(left: 4),
                            child: Icon(
                              Icons.verified,
                              color: Colors.blue,
                              size: 16,
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        ...List.generate(5, (index) => Icon(
                          Icons.star,
                          color: index < review['rating'] 
                            ? Color(AppConstants.warningColorValue)
                            : Colors.grey[300],
                          size: 16,
                        )),
                        SizedBox(width: 8),
                        Text(
                          review['date'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(AppConstants.textSecondaryColorValue),
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
          
          // Yorum metni
          Text(
            review['comment'],
            style: TextStyle(
              fontSize: 14,
              color: Color(AppConstants.textPrimaryColorValue),
              height: 1.4,
            ),
          ),
          SizedBox(height: 12),
          
          // Seyahat bilgileri
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.route,
                  size: 16,
                  color: Color(AppConstants.primaryColorValue),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${review['tripFrom']} → ${review['tripTo']}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(AppConstants.textSecondaryColorValue),
                    ),
                  ),
                ),
                Text(
                  review['tripPrice'],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(AppConstants.primaryColorValue),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
