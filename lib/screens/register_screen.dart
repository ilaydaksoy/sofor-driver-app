import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_constants.dart';
import '../providers/auth_provider.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _emailCodeController = TextEditingController();
  final _phoneCodeController = TextEditingController();
  final _companyNameController = TextEditingController();
  final _taxNumberController = TextEditingController();
  final _licenseNumberController = TextEditingController();

  bool _showEmailCode = false;
  String _driverType = 'Bireysel'; // Bireysel veya Kurumsal
  bool _showPhoneCode = false;
  bool _emailVerified = false;
  bool _phoneVerified = false;
  bool _kvkkAccepted = false;
  bool _aydinlatmaAccepted = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailCodeController.dispose();
    _phoneCodeController.dispose();
    _companyNameController.dispose();
    _taxNumberController.dispose();
    _licenseNumberController.dispose();
    super.dispose();
  }

  void _sendEmailVerification() {
    setState(() {
      _showEmailCode = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Doğrulama kodu e-posta adresinize gönderildi'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _sendPhoneVerification() {
    setState(() {
      _showPhoneCode = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Doğrulama kodu telefonunuza gönderildi'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _verifyEmail() {
    if (_emailCodeController.text == '123456') {
      setState(() {
        _emailVerified = true;
        _showEmailCode = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('E-posta doğrulandı'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Yanlış kod!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _verifyPhone() {
    if (_phoneCodeController.text == '123456') {
      setState(() {
        _phoneVerified = true;
        _showPhoneCode = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Telefon doğrulandı'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Yanlış kod!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      Provider.of<AuthProvider>(context, listen: false).register(
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        password: _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(AppConstants.backgroundColorValue),
      appBar: AppBar(
        backgroundColor: Color(AppConstants.primaryColorValue),
        foregroundColor: Colors.white,
        title: const Text('Kayıt Ol'),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Başlık
                Column(
                  children: [
                    Icon(
                      Icons.local_taxi,
                      size: 45,
                      color: Color(AppConstants.primaryColorValue),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Şöför Hesabı Oluştur',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(AppConstants.primaryColorValue),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Profesyonel şöför olarak platformumuza katılın',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(AppConstants.textSecondaryColorValue),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Şöför Tipi Seçimi
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildSectionTitle('Şöför Tipi'),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: RadioListTile<String>(
                                title: Text('Bireysel'),
                                value: 'Bireysel',
                                groupValue: _driverType,
                                onChanged: (value) {
                                  setState(() {
                                    _driverType = value!;
                                  });
                                },
                                activeColor: Color(AppConstants.primaryColorValue),
                              ),
                            ),
                            Expanded(
                              child: RadioListTile<String>(
                                title: Text('Kurumsal'),
                                value: 'Kurumsal',
                                groupValue: _driverType,
                                onChanged: (value) {
                                  setState(() {
                                    _driverType = value!;
                                  });
                                },
                                activeColor: Color(AppConstants.primaryColorValue),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // Kişisel Bilgiler Kartı
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildSectionTitle('Kişisel Bilgiler'),
                        const SizedBox(height: 12),
                CustomTextField(
                  controller: _nameController,
                          hintText: 'Ad Soyad',
                  prefixIcon: Icons.person,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                              return 'Ad soyad gereklidir';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // Ehliyet Numarası
                CustomTextField(
                  controller: _licenseNumberController,
                  hintText: 'Ehliyet Numarası',
                  prefixIcon: Icons.credit_card,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ehliyet numarası gereklidir';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                        // E-posta alanı
                        if (!_showEmailCode) ...[
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                  controller: _emailController,
                                  hintText: 'E-posta Adresi',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                                      return 'E-posta gereklidir';
                    }
                    if (!Provider.of<AuthProvider>(context, listen: false)
                        .validateEmail(value)) {
                                      return 'Geçersiz e-posta adresi';
                    }
                    return null;
                  },
                ),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () {
                                  if (_emailController.text.isNotEmpty) {
                                    _sendEmailVerification();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Lütfen önce e-posta adresinizi girin'),
                                        backgroundColor: Colors.orange,
                                      ),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(AppConstants.primaryColorValue),
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                  minimumSize: const Size(0, 44),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                                child: const Text('Doğrula', style: TextStyle(color: Colors.white, fontSize: 13)),
                              ),
                            ],
                          ),
                        ] else ...[
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  controller: _emailCodeController,
                                  hintText: 'Doğrulama Kodu',
                                  keyboardType: TextInputType.number,
                                  prefixIcon: Icons.security,
                                ),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () {
                                  if (_emailCodeController.text.isNotEmpty) {
                                    _verifyEmail();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Lütfen doğrulama kodunu girin'),
                                        backgroundColor: Colors.orange,
                                      ),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                  minimumSize: const Size(0, 44),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                                child: const Text('Doğrula', style: TextStyle(color: Colors.white, fontSize: 13)),
                              ),
                            ],
                          ),
                        ],
                        if (_emailVerified) ...[
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.green),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.check_circle, color: Colors.green, size: 16),
                                const SizedBox(width: 8),
                                Text('E-posta doğrulandı', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ],
                const SizedBox(height: 16),
                        // Telefon alanı
                        if (!_showPhoneCode) ...[
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                  controller: _phoneController,
                                  hintText: 'Telefon Numarası',
                  keyboardType: TextInputType.phone,
                  prefixIcon: Icons.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                                      return 'Telefon numarası gereklidir';
                    }
                    if (!Provider.of<AuthProvider>(context, listen: false)
                        .validatePhone(value)) {
                      return 'Geçersiz telefon numarası';
                    }
                    return null;
                  },
                ),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () {
                                  if (_phoneController.text.isNotEmpty) {
                                    _sendPhoneVerification();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Lütfen önce telefon numaranızı girin'),
                                        backgroundColor: Colors.orange,
                                      ),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(AppConstants.primaryColorValue),
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                  minimumSize: const Size(0, 44),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                                child: const Text('Doğrula', style: TextStyle(color: Colors.white, fontSize: 13)),
                              ),
                            ],
                          ),
                        ] else ...[
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  controller: _phoneCodeController,
                                  hintText: 'Doğrulama Kodu',
                                  keyboardType: TextInputType.number,
                                  prefixIcon: Icons.security,
                                ),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                    onPressed: () {
                                  if (_phoneCodeController.text.isNotEmpty) {
                                    _verifyPhone();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Lütfen doğrulama kodunu girin'),
                                        backgroundColor: Colors.orange,
                                      ),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                  minimumSize: const Size(0, 44),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                                child: const Text('Doğrula', style: TextStyle(color: Colors.white, fontSize: 13)),
                              ),
                            ],
                          ),
                        ],
                        if (_phoneVerified) ...[
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.green),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.check_circle, color: Colors.green, size: 16),
                                const SizedBox(width: 8),
                                Text('Telefon doğrulandı', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ],
                        const SizedBox(height: 16),
                        // Kurumsal bilgiler (sadece kurumsal seçilirse göster)
                        if (_driverType == 'Kurumsal') ...[
                          _buildSectionTitle('Kurumsal Bilgiler'),
                          const SizedBox(height: 12),
                          CustomTextField(
                            controller: _companyNameController,
                            hintText: 'Firma Adı',
                            prefixIcon: Icons.business,
                            validator: (value) {
                              if (_driverType == 'Kurumsal' && (value == null || value.isEmpty)) {
                                return 'Firma adı gereklidir';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            controller: _taxNumberController,
                            hintText: 'Vergi Numarası',
                            prefixIcon: Icons.receipt_long,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (_driverType == 'Kurumsal' && (value == null || value.isEmpty)) {
                                return 'Vergi numarası gereklidir';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                        ],
                        _buildSectionTitle('Güvenlik Bilgileri'),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: false,
                          keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                              return 'Şifre gereklidir';
                    }
                    if (value.length < 6) {
                              return 'Şifre en az 6 karakter olmalıdır';
                    }
                    return null;
                  },
                          style: const TextStyle(
                            color: Color(0xFF111111),
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Şifre',
                            hintStyle: TextStyle(
                              color: const Color(0xFF888888),
                              fontSize: 16,
                            ),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Icon(Icons.lock, color: Color(AppConstants.primaryColorValue)),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: const Color(AppConstants.primaryColorValue),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: const Color(AppConstants.primaryColorValue),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Color(AppConstants.primaryColorValue),
                                width: 2,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Color(AppConstants.errorColorValue),
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Color(AppConstants.errorColorValue),
                                width: 2,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                          ),
                ),
                const SizedBox(height: 16),
                        TextFormField(
                  controller: _confirmPasswordController,
                          obscureText: false,
                          keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                              return 'Şifre onayı gereklidir';
                    }
                    if (value != _passwordController.text) {
                      return 'Şifreler eşleşmiyor';
                    }
                    return null;
                  },
                          style: const TextStyle(
                            color: Color(0xFF111111),
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Şifreyi Onayla',
                            hintStyle: TextStyle(
                              color: const Color(0xFF888888),
                              fontSize: 16,
                            ),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Icon(Icons.lock, color: Color(AppConstants.primaryColorValue)),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: const Color(AppConstants.primaryColorValue),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: const Color(AppConstants.primaryColorValue),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Color(AppConstants.primaryColorValue),
                                width: 2,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Color(AppConstants.errorColorValue),
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Color(AppConstants.errorColorValue),
                                width: 2,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Güvenlik ve Gizlilik Bilgi Kartı
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.amber.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.amber.withOpacity(0.2),
                      width: 0.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.amber,
                            width: 1.5,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'i',
                            style: TextStyle(
                              color: Colors.amber,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Güvenlik ve Gizlilik',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color(AppConstants.textColorValue),
                              ),
                            ),
                            const SizedBox(height: 1),
                            Text(
                              'Bilgileriniz güvenle saklanır ve üçüncü taraflarla paylaşılmaz.',
                              style: TextStyle(
                                fontSize: 11,
                                color: Color(AppConstants.textSecondaryColorValue),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // KVKK ve Aydınlatma Checkbox'ları
                Container(
                  margin: const EdgeInsets.only(bottom: 20, left: 8, right: 8),
                  child: Column(
                    children: [
                      // KVKK Checkbox
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: Checkbox(
                              value: _kvkkAccepted,
                              onChanged: (value) {
                                setState(() {
                                  _kvkkAccepted = value!;
                                });
                              },
                              activeColor: Color(AppConstants.primaryColorValue),
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Color(AppConstants.textSecondaryColorValue),
                                      height: 1.3,
                                    ),
                                    children: [
                                      TextSpan(text: 'KVKK metni '),
                                      WidgetSpan(
                                        alignment: PlaceholderAlignment.middle,
                                        child: GestureDetector(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: Text('KVKK Aydınlatma Metni'),
                                                content: SingleChildScrollView(
                                                  child: Text(
                                                    'Kişisel Verilerin Korunması Kanunu kapsamında, kişisel verileriniz işlenirken aşağıdaki haklara sahipsiniz:\n\n'
                                                    '• Kişisel verilerinizin işlenip işlenmediğini öğrenme\n'
                                                    '• Kişisel verileriniz işlenmişse buna ilişkin bilgi talep etme\n'
                                                    '• Kişisel verilerinizin işlenme amacını ve bunların amacına uygun kullanılıp kullanılmadığını öğrenme\n'
                                                    '• Yurt içinde veya yurt dışında kişisel verilerinizin aktarıldığı üçüncü kişileri bilme\n'
                                                    '• Kişisel verilerinizin eksik veya yanlış işlenmiş olması hâlinde bunların düzeltilmesini isteme\n'
                                                    '• Kişisel verilerinizin silinmesini veya yok edilmesini isteme\n'
                                                    '• Kişisel verilerinizin aktarıldığı üçüncü kişilere yukarıda sayılan taleplerin bildirilmesini isteme\n'
                                                    '• İşlenen verilerinizin münhasıran otomatik sistemler vasıtasıyla analiz edilmesi suretiyle kişiliğiniz aleyhine bir sonucun ortaya çıkmasına itiraz etme\n'
                                                    '• Kişisel verilerinizin kanuna aykırı olarak işlenmesi sebebiyle zarara uğramanız hâlinde zararın giderilmesini talep etme',
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: Text('Kapat'),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          child: Text(
                                            'okudum ve kabul ediyorum',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Color(AppConstants.primaryColorValue),
                                              fontWeight: FontWeight.bold,
                                              decoration: TextDecoration.underline,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Aydınlatma Checkbox
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: Checkbox(
                              value: _aydinlatmaAccepted,
                              onChanged: (value) {
                                setState(() {
                                  _aydinlatmaAccepted = value!;
                                });
                              },
                              activeColor: Color(AppConstants.primaryColorValue),
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Color(AppConstants.textSecondaryColorValue),
                                      height: 1.3,
                                    ),
                                    children: [
                                      TextSpan(text: 'Aydınlatma metni '),
                                      WidgetSpan(
                                        alignment: PlaceholderAlignment.middle,
                                        child: GestureDetector(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: Text('Aydınlatma Metni'),
                                                content: SingleChildScrollView(
                                                  child: Text(
                                                    'Bu aydınlatma metni, 6698 sayılı Kişisel Verilerin Korunması Kanunu ("KVKK") uyarınca, veri sorumlusu sıfatıyla Şöför Uygulaması tarafından hazırlanmıştır.\n\n'
                                                    'Şöför olarak kişisel verileriniz, aşağıda belirtilen amaçlar kapsamında, hukuka ve dürüstlük kurallarına uygun olarak işlenecektir:\n\n'
                                                    '• Şöför hizmetinin sunulması\n'
                                                    '• Güvenli ulaşım hizmetinin sağlanması\n'
                                                    '• Yasal yükümlülüklerin yerine getirilmesi\n'
                                                    '• Platform güvenliğinin sağlanması\n'
                                                    '• Müşteri-şöför eşleştirmesi\n'
                                                    '• Ödeme ve fatura işlemlerinin yürütülmesi\n\n'
                                                    'Kişisel verileriniz, yukarıda belirtilen amaçların gerçekleştirilmesi doğrultusunda, müşteriler, ödeme kuruluşları, iş ortaklarımız ve yetkili kamu kurum ve kuruluşları ile paylaşılabilecektir.',
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: Text('Kapat'),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          child: Text(
                                            'okudum ve kabul ediyorum',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Color(AppConstants.primaryColorValue),
                                              fontWeight: FontWeight.bold,
                                              decoration: TextDecoration.underline,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Kayıt Butonu
                Consumer<AuthProvider>(
                  builder: (context, authProvider, child) {
                    return CustomButton(
                      text: 'Şöför Hesabı Oluştur',
                      icon: Icons.local_taxi,
                      onPressed: (authProvider.isLoading || !_emailVerified || !_phoneVerified || !_kvkkAccepted || !_aydinlatmaAccepted) ? null : _register,
                      isLoading: authProvider.isLoading,
                    );
                  },
                ),
                const SizedBox(height: 16),
                // Hata Mesajı
                Consumer<AuthProvider>(
                  builder: (context, authProvider, child) {
                    if (authProvider.error != null) {
                      return Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(AppConstants.errorColorValue).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: const Color(AppConstants.errorColorValue),
                          ),
                        ),
                        child: Text(
                          authProvider.error!,
                          style: const TextStyle(
                            color: Color(AppConstants.errorColorValue),
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                const SizedBox(height: 24),
                // Girişe yönlendirme
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Zaten hesabın var mı? '),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: Text(
                        'Giriş Yap',
                        style: TextStyle(
                          color: Color(AppConstants.primaryColorValue),
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Color(AppConstants.textColorValue),
      ),
    );
  }
} 