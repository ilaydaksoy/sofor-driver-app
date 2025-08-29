import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class HelpCenterScreen extends StatefulWidget {
  @override
  _HelpCenterScreenState createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  final List<Map<String, dynamic>> faqItems = [
    {
      'question': 'Nasıl seyahat kabul ederim?',
      'answer': 'Ana sayfada gelen seyahat isteklerini "Kabul Et" butonuna basarak kabul edebilirsiniz. Otomatik kabul özelliğini de ayarlardan açabilirsiniz.',
    },
    {
      'question': 'Kazancımı nasıl takip ederim?',
      'answer': 'Ana sayfada günlük kazancınızı, performans sekmesinden haftalık ve aylık kazançlarınızı detaylı olarak görüntüleyebilirsiniz.',
    },
    {
      'question': 'Müşteri ile iletişim nasıl kurarım?',
      'answer': 'Seyahat kabul ettikten sonra müşteri bilgileri ekranında arama ve mesaj gönderme seçenekleri görünür.',
    },
    {
      'question': 'Araç bilgilerimi nasıl güncellerim?',
      'answer': 'Profil → Araç Bilgileri bölümünden marka, model, plaka ve fotoğraf bilgilerinizi güncelleyebilirsiniz.',
    },
    {
      'question': 'Çevrimdışı modda çalışabilir miyim?',
      'answer': 'Hayır, uygulama internet bağlantısı gerektirir. Seyahat istekleri ve navigasyon için sürekli bağlantı şarttır.',
    },

    {
      'question': 'Seyahati nasıl iptal ederim?',
      'answer': 'Kabul ettiğiniz seyahati acil durumlar dışında iptal etmemeye özen gösterin. İptal etmeniz gerekirse "Seyahati İptal Et" butonunu kullanın.',
    },
    {
      'question': 'Hesabımı nasıl silebilirim?',
      'answer': 'Ayarlar → Hesap Ayarları → Hesabı Sil seçeneğini kullanabilirsiniz. Bu işlem geri alınamaz.',
    },
    {
      'question': 'Uygulama sorunları nasıl çözülür?',
      'answer': 'Önce uygulamayı kapatıp tekrar açmayı deneyin. Sorun devam ederse cihazınızı yeniden başlatın veya bizimle iletişime geçin.',
    },
    {
      'question': 'Çalışma saatlerimi nasıl belirlerim?',
      'answer': 'Ana sayfadaki "Müsait/Meşgul" düğmesi ile çevrimiçi durumunuzu kontrol edebilirsiniz. Otomatik seyahat kabul ayarını da kullanabilirsiniz.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(AppConstants.backgroundColorValue),
      appBar: AppBar(
        title: Text('Yardım Merkezi'),
        backgroundColor: Color(AppConstants.primaryColorValue),
        foregroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              icon: Icon(Icons.quiz),
              text: 'SSS',
            ),
            Tab(
              icon: Icon(Icons.contact_support),
              text: 'İletişim',
            ),
          ],
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildFAQTab(),
          _buildContactTab(),
        ],
      ),
    );
  }

  Widget _buildFAQTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sık Sorulan Sorular',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(AppConstants.textPrimaryColorValue),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'En çok merak edilen konulara cevaplar',
            style: TextStyle(
              fontSize: 16,
              color: Color(AppConstants.textSecondaryColorValue),
            ),
          ),
          SizedBox(height: 24),
          
          ...faqItems.map((item) => _buildFAQItem(
            item['question']!,
            item['answer']!,
          )).toList(),
          
          SizedBox(height: 32),
          
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color(AppConstants.primaryColorValue).withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Color(AppConstants.primaryColorValue).withOpacity(0.2),
              ),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.help_outline,
                  size: 48,
                  color: Color(AppConstants.primaryColorValue),
                ),
                SizedBox(height: 16),
                Text(
                  'Sorunuz burada yok mu?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(AppConstants.textPrimaryColorValue),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Bizimle iletişime geçin, size yardımcı olmaktan memnuniyet duyarız.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(AppConstants.textSecondaryColorValue),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    _tabController.animateTo(1); // İletişim tabına geç
                  },
                  icon: Icon(Icons.contact_support),
                  label: Text('İletişime Geç'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(AppConstants.primaryColorValue),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bizimle İletişime Geçin',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(AppConstants.textPrimaryColorValue),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Size nasıl yardımcı olabiliriz?',
            style: TextStyle(
              fontSize: 16,
              color: Color(AppConstants.textSecondaryColorValue),
            ),
          ),
          SizedBox(height: 32),
          
          _buildContactCard(
            'Telefon Desteği',
            'Demo telefon numarası (çalışmaz)',
            Icons.phone,
            '+90 555 000 0000',
            'Demo: 7/24 Açık',
          ),
          
          _buildContactCard(
            'E-posta Desteği',
            'Demo e-posta adresi (çalışmaz)',
            Icons.email,
            'demo@example.com',
            'Demo: Hızlı yanıt',
          ),
          
          _buildContactCard(
            'WhatsApp Desteği',
            'Demo WhatsApp numarası (çalışmaz)',
            Icons.chat,
            '+90 555 111 1111',
            'Demo: Anlık destek',
          ),
          
          _buildContactCard(
            'Canlı Destek',
            'Demo canlı destek sistemi',
            Icons.support_agent,
            'Demo Chat Sistemi',
            'Demo: Online destek',
          ),
          
          SizedBox(height: 32),
          
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(AppConstants.primaryColorValue).withOpacity(0.1),
                  Color(AppConstants.primaryColorValue).withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Color(AppConstants.primaryColorValue).withOpacity(0.2),
              ),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.location_on,
                  size: 48,
                  color: Color(AppConstants.primaryColorValue),
                ),
                SizedBox(height: 16),
                Text(
                  'Demo Ofis Adresi',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(AppConstants.textPrimaryColorValue),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Demo Mahallesi\nDemo Caddesi No: 123\nDemo İlçesi / Demo Şehri',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(AppConstants.textSecondaryColorValue),
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Demo Çalışma Saatleri: 7/24 Açık',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(AppConstants.textSecondaryColorValue),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        backgroundColor: Colors.white,
        collapsedBackgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: Color(AppConstants.primaryColorValue).withOpacity(0.1),
          ),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: Color(AppConstants.primaryColorValue).withOpacity(0.1),
          ),
        ),
        title: Text(
          question,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(AppConstants.textPrimaryColorValue),
            fontSize: 16,
          ),
        ),
        iconColor: Color(AppConstants.primaryColorValue),
        collapsedIconColor: Color(AppConstants.primaryColorValue),
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              answer,
              style: TextStyle(
                color: Color(AppConstants.textSecondaryColorValue),
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard(
    String title,
    String description,
    IconData icon,
    String contact,
    String availability,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
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
        border: Border.all(
          color: Color(AppConstants.primaryColorValue).withOpacity(0.1),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(AppConstants.primaryColorValue).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: Color(AppConstants.primaryColorValue),
              size: 24,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(AppConstants.textPrimaryColorValue),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(AppConstants.textSecondaryColorValue),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  contact,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(AppConstants.primaryColorValue),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  availability,
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(AppConstants.textSecondaryColorValue),
                    fontStyle: FontStyle.italic,
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


