import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class PerformanceAnalyticsScreen extends StatefulWidget {
  @override
  _PerformanceAnalyticsScreenState createState() => _PerformanceAnalyticsScreenState();
}

class _PerformanceAnalyticsScreenState extends State<PerformanceAnalyticsScreen> {
  String selectedPeriod = 'Bu Ay';
  
  final List<String> periods = ['Bu Hafta', 'Bu Ay', 'Bu Yıl'];
  
  final Map<String, Map<String, dynamic>> analyticsData = {
    'Bu Hafta': {
      'profil_goruntulenme': 89,
      'mesaj_gecmisi': 15,
      'yanit_orani': 98,
      'ortalama_yanit_suresi': '4 dakika',
      'musteri_memnuniyeti': 4.9,
      'aktif_sohbet': 8,
      'yeni_musteri': 12,
      'tekrar_eden_musteri': 6,
    },
    'Bu Ay': {
      'profil_goruntulenme': 1247,
      'mesaj_gecmisi': 78,
      'yanit_orani': 95,
      'ortalama_yanit_suresi': '5 dakika',
      'musteri_memnuniyeti': 4.8,
      'aktif_sohbet': 23,
      'yeni_musteri': 45,
      'tekrar_eden_musteri': 18,
    },
    'Bu Yıl': {
      'profil_goruntulenme': 8950,
      'mesaj_gecmisi': 542,
      'yanit_orani': 96,
      'ortalama_yanit_suresi': '5 dakika',
      'musteri_memnuniyeti': 4.8,
      'aktif_sohbet': 127,
      'yeni_musteri': 287,
      'tekrar_eden_musteri': 95,
    },
  };

  final List<Map<String, dynamic>> messageHistory = [
    {
      'customer': 'Ahmet Yılmaz',
      'message': 'Havalimanından alacak mısınız?',
      'time': '14:30',
      'status': 'Yanıtlandı',
      'response_time': '2 dk',
      'isRead': true,
    },
    {
      'customer': 'Fatma Özkan',
      'message': 'Çok teşekkür ederim!',
      'time': '12:15',
      'status': 'Yanıtlandı',
      'response_time': '1 dk',
      'isRead': true,
    },
    {
      'customer': 'Mehmet Kaya',
      'message': 'Platform Bildirimi: Yeni seyahat talebi',
      'time': '09:45',
      'status': 'Kabul Edildi',
      'response_time': '30 sn',
      'isRead': true,
      'isPlatformMessage': true,
    },
    {
      'customer': 'Ali Demir',
      'message': 'Sesli mesaj gönderdi',
      'time': 'Dün',
      'status': 'Yanıtlandı',
      'response_time': '3 dk',
      'isRead': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final currentData = analyticsData[selectedPeriod]!;
    
    return Scaffold(
      backgroundColor: Color(AppConstants.backgroundColorValue),
      appBar: AppBar(
        title: Text('Performans Analizi'),
        backgroundColor: Color(AppConstants.primaryColorValue),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dönem seçici
            _buildPeriodSelector(),
            SizedBox(height: 20),
            
            // Ana metrikler
            _buildMainMetrics(currentData),
            SizedBox(height: 20),
            
            // Profil görüntülenme istatistikleri
            _buildProfileViewStats(currentData),
            SizedBox(height: 20),
            
            // Mesaj performansı
            _buildMessagePerformance(currentData),
            SizedBox(height: 20),
            
            // Mesaj geçmişi
            _buildMessageHistory(),
            SizedBox(height: 20),
            
            // Platform bildirimleri yönetimi
            _buildNotificationManagement(),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: periods.map((period) {
          final isSelected = selectedPeriod == period;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => selectedPeriod = period),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? Color(AppConstants.primaryColorValue) : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  period,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Color(AppConstants.textPrimaryColorValue),
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMainMetrics(Map<String, dynamic> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ana Metrikler',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(AppConstants.textPrimaryColorValue),
          ),
        ),
        SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.2,
          children: [
            _buildMetricCard(
              'Profil Görüntülenme',
              '${data['profil_goruntulenme']}',
              Icons.visibility,
              Color(AppConstants.primaryColorValue),
            ),
            _buildMetricCard(
              'Mesaj Yanıt Oranı',
              '%${data['yanit_orani']}',
              Icons.reply,
              Colors.green,
            ),
            _buildMetricCard(
              'Müşteri Memnuniyeti',
              '${data['musteri_memnuniyeti']}/5.0',
              Icons.star,
              Color(AppConstants.warningColorValue),
            ),
            _buildMetricCard(
              'Aktif Sohbet',
              '${data['aktif_sohbet']}',
              Icons.chat,
              Colors.blue,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
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
        mainAxisAlignment: MainAxisAlignment.center,
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

  Widget _buildProfileViewStats(Map<String, dynamic> data) {
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
            'Profil Görüntülenme İstatistikleri',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(AppConstants.textPrimaryColorValue),
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem('Toplam Görüntülenme', '${data['profil_goruntulenme']}', Icons.visibility),
              _buildStatItem('Yeni Müşteri', '${data['yeni_musteri']}', Icons.person_add),
              _buildStatItem('Tekrar Eden', '${data['tekrar_eden_musteri']}', Icons.repeat),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
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
            fontSize: 11,
            color: Color(AppConstants.textSecondaryColorValue),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildMessagePerformance(Map<String, dynamic> data) {
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
            'Mesaj Performansı',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(AppConstants.textPrimaryColorValue),
            ),
          ),
          SizedBox(height: 16),
          _buildPerformanceRow('Toplam Mesaj', '${data['mesaj_gecmisi']}'),
          _buildPerformanceRow('Yanıt Oranı', '%${data['yanit_orani']}'),
          _buildPerformanceRow('Ortalama Yanıt Süresi', data['ortalama_yanit_suresi']),
          _buildPerformanceRow('Müşteri Memnuniyeti', '${data['musteri_memnuniyeti']}/5.0'),
        ],
      ),
    );
  }

  Widget _buildPerformanceRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Color(AppConstants.textSecondaryColorValue),
              fontSize: 14,
            ),
          ),
          Text(
            value,
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

  Widget _buildMessageHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mesaj Geçmişi',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(AppConstants.textPrimaryColorValue),
          ),
        ),
        SizedBox(height: 12),
        ...messageHistory.map((message) => Container(
          margin: EdgeInsets.only(bottom: 12),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: message['isRead'] 
                ? Colors.grey[200]! 
                : Color(AppConstants.primaryColorValue).withOpacity(0.3),
              width: 1,
            ),
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
                    message['customer'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(AppConstants.textPrimaryColorValue),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: _getStatusColor(message['status']).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      message['status'],
                      style: TextStyle(
                        fontSize: 10,
                        color: _getStatusColor(message['status']),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                message['message'],
                style: TextStyle(
                  fontSize: 13,
                  color: message['isPlatformMessage'] == true 
                    ? Color(AppConstants.primaryColorValue)
                    : Color(AppConstants.textPrimaryColorValue),
                  fontWeight: message['isPlatformMessage'] == true 
                    ? FontWeight.w600 
                    : FontWeight.normal,
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Yanıt Süresi: ${message['response_time']}',
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(AppConstants.textTertiaryColorValue),
                    ),
                  ),
                  Text(
                    message['time'],
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(AppConstants.textTertiaryColorValue),
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

  Widget _buildNotificationManagement() {
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
            'Platform Bildirimleri Yönetimi',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(AppConstants.textPrimaryColorValue),
            ),
          ),
          SizedBox(height: 16),
          _buildNotificationToggle('Yeni Seyahat Talepleri', true),
          _buildNotificationToggle('Mesaj Bildirimleri', true),
          _buildNotificationToggle('Platform Duyuruları', false),
          _buildNotificationToggle('Performans Raporları', true),
          _buildNotificationToggle('Ödeme Bildirimleri', true),
        ],
      ),
    );
  }

  Widget _buildNotificationToggle(String title, bool isEnabled) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Color(AppConstants.textPrimaryColorValue),
            ),
          ),
          Switch(
            value: isEnabled,
            onChanged: (value) {
              // TODO: Bildirim ayarlarını güncelle
            },
            activeColor: Color(AppConstants.primaryColorValue),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Yanıtlandı':
        return Colors.green;
      case 'Kabul Edildi':
        return Colors.blue;
      case 'Beklemede':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}
