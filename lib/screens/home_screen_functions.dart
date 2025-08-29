import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

// Quick Actions Functions
void showEarningsReport(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 4,
            margin: EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.analytics, color: Colors.green, size: 24),
                ),
                SizedBox(width: 12),
                Text(
                  'Kazanç Raporu',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildEarningsCard('Bugün', '450 TL', '+12%', Colors.green),
                  SizedBox(height: 12),
                  _buildEarningsCard('Bu Hafta', '2,450 TL', '+8%', Colors.blue),
                  SizedBox(height: 12),
                  _buildEarningsCard('Bu Ay', '8,650 TL', '+15%', Colors.purple),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

void showTripHistory(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 4,
            margin: EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(Icons.history, color: Color(AppConstants.primaryColorValue), size: 24),
                SizedBox(width: 12),
                Text(
                  'Seyahat Geçmişi',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemCount: 15,
              itemBuilder: (context, index) {
                final trips = [
                  {'from': 'Taksim', 'to': 'Havalimanı', 'time': '14:30'},
                  {'from': 'Kadıköy', 'to': 'Bostancı', 'time': '12:15'},
                  {'from': 'Şişli', 'to': 'Levent', 'time': '09:45'},
                ];
                final trip = trips[index % trips.length];
                
                return Container(
                  margin: EdgeInsets.only(bottom: 12),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.green, size: 20),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                                                Text('${trip['from'] as String} → ${trip['to'] as String}', 
                         style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('${trip['time'] as String}', style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ),
                      Icon(Icons.check_circle, color: Colors.green, size: 16),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}

void showCustomerReviews(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 4,
            margin: EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(Icons.star_rate, color: Colors.amber, size: 24),
                SizedBox(width: 12),
                Text(
                  'Müşteri Yorumları',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.amber.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      SizedBox(width: 4),
                      Text('4.8', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemCount: 10,
              itemBuilder: (context, index) {
                final reviews = [
                  {'name': 'Mehmet K.', 'comment': 'Çok güvenli sürüş, teşekkürler!', 'rating': 5},
                  {'name': 'Ayşe D.', 'comment': 'Zamanında geldi, araç temizdi.', 'rating': 5},
                  {'name': 'Ali R.', 'comment': 'İyi bir deneyimdi.', 'rating': 4},
                ];
                final review = reviews[index % reviews.length];
                
                return Container(
                  margin: EdgeInsets.only(bottom: 12),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(AppConstants.primaryColorValue),
                        child: Text((review['name'] as String)[0], style: TextStyle(color: Colors.white)),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(review['name'] as String, style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 4),
                            Text(review['comment'] as String),
                            SizedBox(height: 4),
                            Row(
                              children: List.generate(5, (i) => Icon(
                                Icons.star,
                                size: 14,
                                color: i < (review['rating'] as int) ? Colors.amber : Colors.grey[300],
                              )),
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
      ),
    ),
  );
}

void openSettings(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text('Ayarlar'),
          backgroundColor: Color(AppConstants.primaryColorValue),
          foregroundColor: Colors.white,
        ),
        body: ListView(
          padding: EdgeInsets.all(16),
          children: [
            ListTile(
              leading: Icon(Icons.notifications, color: Color(AppConstants.primaryColorValue)),
              title: Text('Bildirimler'),
              trailing: Icon(Icons.chevron_right, color: Colors.grey),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.location_on, color: Color(AppConstants.primaryColorValue)),
              title: Text('Konum Paylaşımı'),
              trailing: Icon(Icons.chevron_right, color: Colors.grey),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.privacy_tip, color: Color(AppConstants.primaryColorValue)),
              title: Text('Gizlilik'),
              trailing: Icon(Icons.chevron_right, color: Colors.grey),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.language, color: Color(AppConstants.primaryColorValue)),
              title: Text('Dil Ayarları'),
              trailing: Icon(Icons.chevron_right, color: Colors.grey),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.help, color: Color(AppConstants.primaryColorValue)),
              title: Text('Yardım & Destek'),
              trailing: Icon(Icons.chevron_right, color: Colors.grey),
              onTap: () {},
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildEarningsCard(String period, String amount, String change, Color color) {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withOpacity(0.2)),
      boxShadow: [
        BoxShadow(
          color: color.withOpacity(0.1),
          blurRadius: 8,
          offset: Offset(0, 4),
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
          child: Icon(Icons.trending_up, color: color, size: 20),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(period, style: TextStyle(fontSize: 14, color: Colors.grey)),
              Text(amount, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            change,
            style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    ),
  );
}
