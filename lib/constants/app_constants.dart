class AppConstants {
  // API URLs
  static const String baseUrl = 'https://api.turistdriver.com';
  static const String loginUrl = '$baseUrl/auth/login';
  static const String registerUrl = '$baseUrl/auth/register';
  static const String tripsUrl = '$baseUrl/trips';
  static const String profileUrl = '$baseUrl/profile';
  
  // Shared Preferences Keys
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
  static const String isLoggedInKey = 'is_logged_in';
  
  // App Colors
  static const int primaryColorValue = 0xFF2196F3;
  static const int secondaryColorValue = 0xFF1976D2;
  static const int accentColorValue = 0xFF03A9F4;
  static const int backgroundColorValue = 0xFFF5F5F5;
  static const int textColorValue = 0xFF212121;
  static const int errorColorValue = 0xFFD32F2F;
  static const int successColorValue = 0xFF388E3C;
  
  // App Text
  static const String appName = 'Turist Sürücü';
  static const String welcomeMessage = 'Hoş Geldiniz';
  static const String loginTitle = 'Giriş Yap';
  static const String registerTitle = 'Kayıt Ol';
  static const String emailHint = 'E-posta';
  static const String passwordHint = 'Şifre';
  static const String confirmPasswordHint = 'Şifre Tekrar';
  static const String nameHint = 'Ad Soyad';
  static const String phoneHint = 'Telefon';
  static const String loginButton = 'Giriş Yap';
  static const String registerButton = 'Kayıt Ol';
  static const String forgotPassword = 'Şifremi Unuttum';
  static const String noAccount = 'Hesabınız yok mu?';
  static const String hasAccount = 'Zaten hesabınız var mı?';
  
  // Trip Status
  static const String tripStatusPending = 'Beklemede';
  static const String tripStatusActive = 'Aktif';
  static const String tripStatusCompleted = 'Tamamlandı';
  static const String tripStatusCancelled = 'İptal Edildi';
  
  // Error Messages
  static const String networkError = 'İnternet bağlantısı hatası';
  static const String serverError = 'Sunucu hatası';
  static const String invalidCredentials = 'Geçersiz e-posta veya şifre';
  static const String emailAlreadyExists = 'Bu e-posta adresi zaten kullanılıyor';
  static const String weakPassword = 'Şifre çok zayıf';
  static const String invalidEmail = 'Geçersiz e-posta adresi';
  static const String fieldRequired = 'Bu alan zorunludur';
  
  // Success Messages
  static const String loginSuccess = 'Başarıyla giriş yapıldı';
  static const String registerSuccess = 'Kayıt başarıyla tamamlandı';
  static const String profileUpdated = 'Profil güncellendi';
  static const String tripAccepted = 'Sefer kabul edildi';
  static const String tripCompleted = 'Sefer tamamlandı';
  
  // Map Constants
  static const double defaultLatitude = 39.9334; // Ankara
  static const double defaultLongitude = 32.8597;
  static const double defaultZoom = 12.0;
  
  // Timeouts
  static const int connectionTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds
} 