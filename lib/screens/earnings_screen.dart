import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class EarningsScreen extends StatefulWidget {
  @override
  _EarningsScreenState createState() => _EarningsScreenState();
}

class _EarningsScreenState extends State<EarningsScreen> {
  String selectedPeriod = 'Bu Hafta';
  
  final List<String> periods = ['Bu Hafta', 'Bu Ay', 'Bu Yıl'];
  
  final Map<String, Map<String, dynamic>> earningsData = {
    'Bu Hafta': {
      'toplam': 2450.0,
      'seyahat': 15,
      'ortalama': 163.3,
      'gunluk': [350.0, 420.0, 280.0, 390.0, 510.0, 330.0, 170.0],
      'gunler': ['Pzt', 'Sal', 'Çar', 'Per', 'Cum', 'Cmt', 'Paz'],
    },
    'Bu Ay': {
      'toplam': 12800.0,
      'seyahat': 78,
      'ortalama': 164.1,
      'gunluk': [],
      'gunler': [],
    },
    'Bu Yıl': {
      'toplam': 89500.0,
      'seyahat': 542,
      'ortalama': 165.1,
      'gunluk': [],
      'gunler': [],
    },
  };

  @override
  Widget build(BuildContext context) {
    final currentData = earningsData[selectedPeriod]!;
    
    return Scaffold(
      backgroundColor: Color(AppConstants.backgroundColorValue),
      appBar: AppBar(
        title: Text('Kazançlarım'),
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
            
            // Ana kazanç kartları
            _buildEarningsCards(currentData),
            SizedBox(height: 20),
            
            // Haftalık grafik (sadece bu hafta için)
            if (selectedPeriod == 'Bu Hafta') ...[
              _buildWeeklyChart(currentData),
              SizedBox(height: 20),
            ],
            
            // Detaylar
            _buildDetailsSection(currentData),
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

  Widget _buildEarningsCards(Map<String, dynamic> data) {
    return Row(
      children: [
        Expanded(
          child: _buildEarningsCard(
            'Toplam Kazanç',
            '${data['toplam'].toStringAsFixed(0)} TL',
            Icons.account_balance_wallet,
            Color(AppConstants.primaryColorValue),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _buildEarningsCard(
            'Seyahat Sayısı',
            '${data['seyahat']}',
            Icons.directions_car,
            Colors.blue,
          ),
        ),
      ],
    );
  }

  Widget _buildEarningsCard(String title, String value, IconData icon, Color color) {
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
              fontSize: 20,
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

  Widget _buildWeeklyChart(Map<String, dynamic> data) {
    final gunlukKazanc = data['gunluk'] as List<double>;
    final gunler = data['gunler'] as List<String>;
    final maxKazanc = gunlukKazanc.reduce((a, b) => a > b ? a : b);
    
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Haftalık Kazanç Grafiği',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(AppConstants.textPrimaryColorValue),
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 150,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(gunlukKazanc.length, (index) {
                final kazanc = gunlukKazanc[index];
                final yukseklik = (kazanc / maxKazanc) * 120;
                
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '${kazanc.toInt()}',
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(AppConstants.textSecondaryColorValue),
                      ),
                    ),
                    SizedBox(height: 4),
                    Container(
                      width: 24,
                      height: yukseklik,
                      decoration: BoxDecoration(
                        color: Color(AppConstants.primaryColorValue),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      gunler[index],
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(AppConstants.textPrimaryColorValue),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsSection(Map<String, dynamic> data) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Detaylar',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(AppConstants.textPrimaryColorValue),
            ),
          ),
          SizedBox(height: 16),
          _buildDetailRow('Ortalama Kazanç', '${data['ortalama'].toStringAsFixed(1)} TL'),
          _buildDetailRow('Toplam Seyahat', '${data['seyahat']} adet'),
          _buildDetailRow('En Yüksek Günlük', selectedPeriod == 'Bu Hafta' 
            ? '${(data['gunluk'] as List<double>).reduce((a, b) => a > b ? a : b).toInt()} TL'
            : 'N/A'),
          _buildDetailRow('Komisyon Oranı', '%15'),
          _buildDetailRow('Net Kazanç', '${(data['toplam'] * 0.85).toStringAsFixed(0)} TL'),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
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
}
