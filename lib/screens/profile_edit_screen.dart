import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class ProfileEditScreen extends StatefulWidget {
  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Kişisel bilgiler
  final _nameController = TextEditingController(text: 'Ahmet Yılmaz');
  final _phoneController = TextEditingController(text: '+90 555 123 4567');
  final _emailController = TextEditingController(text: 'ahmet.yilmaz@sofor.com');
  final _licenseController = TextEditingController(text: 'E-123456789');
  final _birthdateController = TextEditingController(text: '12.05.1985');
  final _experienceController = TextEditingController(text: '5');
  final _introductionController = TextEditingController(
    text: 'Merhaba! Ben Ahmet, 5 yıllık tecrübeli bir şöförüm. Güvenli ve konforlu seyahatler için bana ulaşabilirsiniz. İngilizce ve Almanca konuşabiliyorum.'
  );
  
  // Araç bilgileri
  final _vehicleBrandController = TextEditingController(text: 'Mercedes');
  final _vehicleModelController = TextEditingController(text: 'C200');
  final _vehicleYearController = TextEditingController(text: '2020');
  final _vehiclePlateController = TextEditingController(text: '34 ABC 123');
  final _vehicleColorController = TextEditingController(text: 'Siyah');
  String _selectedFuelType = 'Dizel';
  String _selectedSeatCount = '4+1';
  bool _hasAirConditioning = true;
  String _selectedBaggageCapacity = 'Büyük';
  
  // Dil bilgileri
  List<String> _selectedLanguages = ['Türkçe', 'İngilizce', 'Almanca'];
  final List<String> _availableLanguages = [
    'Türkçe', 'İngilizce', 'Almanca', 'Fransızca', 'İspanyolca', 'Rusça', 'Arapça', 'İtalyanca'
  ];
  
  // Şehir bilgisi
  String _selectedCity = 'İstanbul';
  final List<String> _cities = [
    'İstanbul', 'Ankara', 'İzmir', 'Antalya', 'Bursa', 'Adana', 'Konya', 'Gaziantep'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(AppConstants.backgroundColorValue),
      appBar: AppBar(
        title: Text('Profili Düzenle'),
        backgroundColor: Color(AppConstants.primaryColorValue),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _saveProfile,
            child: Text(
              'Kaydet',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profil fotoğrafı
              _buildProfilePhotoSection(),
              SizedBox(height: 24),
              
              // Kişisel bilgiler
              _buildPersonalInfoSection(),
              SizedBox(height: 24),
              
              // Araç bilgileri
              _buildVehicleInfoSection(),
              SizedBox(height: 24),
              
              // Dil yetkinlikleri
              _buildLanguageSection(),
              SizedBox(height: 24),
              
              // Kişisel tanıtım
              _buildIntroductionSection(),
              SizedBox(height: 24),
              
              // Kaydet butonu
              _buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfilePhotoSection() {
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
        children: [
          Text(
            'Profil Fotoğrafı',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(AppConstants.textPrimaryColorValue),
            ),
          ),
          SizedBox(height: 16),
          Stack(
            children: [
              ClipOval(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Color(AppConstants.primaryColorValue),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.person, size: 60, color: Colors.white),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: _selectProfilePhoto,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(AppConstants.primaryColorValue),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'Fotoğrafı değiştirmek için dokunun',
            style: TextStyle(
              fontSize: 12,
              color: Color(AppConstants.textSecondaryColorValue),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfoSection() {
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
            'Kişisel Bilgiler',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(AppConstants.textPrimaryColorValue),
            ),
          ),
          SizedBox(height: 16),
          _buildTextField('Ad Soyad', _nameController, Icons.person),
          SizedBox(height: 16),
          _buildTextField('Telefon', _phoneController, Icons.phone),
          SizedBox(height: 16),
          _buildTextField('E-posta', _emailController, Icons.email),
          SizedBox(height: 16),
          _buildTextField('Ehliyet No', _licenseController, Icons.credit_card),
          SizedBox(height: 16),
          _buildTextField('Doğum Tarihi', _birthdateController, Icons.calendar_today),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildTextField('Deneyim (Yıl)', _experienceController, Icons.work),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _buildDropdown('Şehir', _selectedCity, _cities, (value) {
                  setState(() => _selectedCity = value!);
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleInfoSection() {
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
            'Araç Bilgileri',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(AppConstants.textPrimaryColorValue),
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildTextField('Marka', _vehicleBrandController, Icons.directions_car),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _buildTextField('Model', _vehicleModelController, Icons.directions_car),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildTextField('Yıl', _vehicleYearController, Icons.calendar_today),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _buildTextField('Plaka', _vehiclePlateController, Icons.confirmation_number),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildTextField('Renk', _vehicleColorController, Icons.palette),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _buildDropdown('Yakıt Tipi', _selectedFuelType, ['Benzin', 'Dizel', 'LPG', 'Elektrik', 'Hibrit'], (value) {
                  setState(() => _selectedFuelType = value!);
                }),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildDropdown('Koltuk Sayısı', _selectedSeatCount, ['2+1', '4+1', '6+1', '8+1'], (value) {
                  setState(() => _selectedSeatCount = value!);
                }),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _buildDropdown('Bagaj Hacmi', _selectedBaggageCapacity, ['Küçük', 'Orta', 'Büyük'], (value) {
                  setState(() => _selectedBaggageCapacity = value!);
                }),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Klima',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(AppConstants.textPrimaryColorValue),
                ),
              ),
              Switch(
                value: _hasAirConditioning,
                onChanged: (value) => setState(() => _hasAirConditioning = value),
                activeColor: Color(AppConstants.primaryColorValue),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageSection() {
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
            'Dil Yetkinlikleri',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(AppConstants.textPrimaryColorValue),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Konuşabildiğiniz dilleri seçin',
            style: TextStyle(
              fontSize: 12,
              color: Color(AppConstants.textSecondaryColorValue),
            ),
          ),
          SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _availableLanguages.map((language) {
              final isSelected = _selectedLanguages.contains(language);
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      _selectedLanguages.remove(language);
                    } else {
                      _selectedLanguages.add(language);
                    }
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected 
                      ? Color(AppConstants.primaryColorValue) 
                      : Colors.grey[100],
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected 
                        ? Color(AppConstants.primaryColorValue) 
                        : Colors.grey[300]!,
                    ),
                  ),
                  child: Text(
                    language,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isSelected 
                        ? Colors.white 
                        : Color(AppConstants.textPrimaryColorValue),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildIntroductionSection() {
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
            'Kişisel Tanıtım',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(AppConstants.textPrimaryColorValue),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Kendinizi müşterilerinize tanıtın',
            style: TextStyle(
              fontSize: 12,
              color: Color(AppConstants.textSecondaryColorValue),
            ),
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _introductionController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Kendinizi tanıtın...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Color(AppConstants.primaryColorValue),
                  width: 2,
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Kişisel tanıtım boş bırakılamaz';
              }
              if (value.length < 50) {
                return 'En az 50 karakter girmelisiniz';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Color(AppConstants.primaryColorValue)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Color(AppConstants.primaryColorValue),
            width: 2,
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return '$label boş bırakılamaz';
        }
        return null;
      },
    );
  }

  Widget _buildDropdown(String label, String value, List<String> items, Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Color(AppConstants.primaryColorValue),
            width: 2,
          ),
        ),
      ),
      items: items.map((item) => DropdownMenuItem(
        value: item,
        child: Text(item),
      )).toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildSaveButton() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _saveProfile,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(AppConstants.primaryColorValue),
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        child: Text(
          'Değişiklikleri Kaydet',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _selectProfilePhoto() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Kamera'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Kameradan fotoğraf çek
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Galeri'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Galeriden fotoğraf seç
              },
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text('Fotoğrafı Kaldır'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Fotoğrafı kaldır
              },
            ),
          ],
        ),
      ),
    );
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      // TODO: Profil bilgilerini kaydet
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Profil başarıyla güncellendi'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _licenseController.dispose();
    _birthdateController.dispose();
    _experienceController.dispose();
    _introductionController.dispose();
    _vehicleBrandController.dispose();
    _vehicleModelController.dispose();
    _vehicleYearController.dispose();
    _vehiclePlateController.dispose();
    _vehicleColorController.dispose();
    super.dispose();
  }
}
