import 'package:flutter/material.dart';

class AppConstants {
  // API URLs
  static const String baseUrl = 'https://reqres.in/api';
  static const String loginUrl = '/login';
  static const String registerUrl = '/register';
  static const String usersUrl = '/users';
  static const String profileUrl = '/users/1'; // Demo profile
  static const String tripsUrl = '/users'; // Using users endpoint for demo trips

  // Demo credentials
  static const String demoEmail = 'demo@turist.com';
  static const String demoPassword = 'demo123';

  // Colors - Kırmızı ve Siyah Paleti
  static const int primaryColorValue = 0xFFD32F2F; // Kırmızı
  static const int secondaryColorValue = 0xFF111111; // Siyah
  static const int accentColorValue = 0xFFFF5252; // Açık Kırmızı
  static const int backgroundColorValue = 0xFFFFFFFF; // Beyaz
  static const int surfaceColorValue = 0xFFFFFFFF; // Beyaz
  static const int cardColorValue = 0xFFF5F5F5; // Açık gri
  static const int textPrimaryColorValue = 0xFF111111; // Siyah
  static const int textSecondaryColorValue = 0xFF444444; // Koyu gri
  static const int textTertiaryColorValue = 0xFF888888; // Açık gri
  static const int errorColorValue = 0xFFD32F2F; // Kırmızı
  static const int successColorValue = 0xFF388E3C; // Yeşil
  static const int warningColorValue = 0xFFFFA000; // Turuncu
  static const int infoColorValue = 0xFF616161; // Gri

  // Bordo renk (Burgundy)
  static const Color burgundy = Color(0xFF800020); // Bordo
  static const int textColorValue = 0xFF111111; // Varsayılan siyah

  // Border Colors
  static const int borderColorValue = 0xFFEEEEEE; // Açık gri border
  static const int borderLightColorValue = 0xFFF5F5F5; // Çok açık gri border

  // Shadow Colors
  static const int shadowColorValue = 0xFF111111; // Siyah gölge
  static const int shadowLightColorValue = 0xFF888888; // Açık gri gölge

  // Status Colors
  static const int onlineColorValue = 0xFF388E3C; // Yeşil (online)
  static const int offlineColorValue = 0xFF888888; // Gri (offline)
  static const int busyColorValue = 0xFFFFA000; // Turuncu (meşgul)

  // Shared Preferences Keys
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
  static const String isLoggedInKey = 'is_logged_in';

  // App Info
  static const String appName = 'Sürücü Bul';
  static const String appVersion = '1.0.0';
  static const String welcomeMessage = 'Güvenli ve konforlu yolculuklar için doğru yerdesiniz.';

  // Form Labels
  static const String emailHint = 'E-posta adresiniz';
  static const String passwordHint = 'Şifreniz';
  static const String loginButton = 'Giriş Yap';
  static const String registerButton = 'Kayıt Ol';
  static const String noAccount = 'Hesabınız yok mu?';
  static const String registerTitle = 'Kayıt Ol';
  static const String fieldRequired = 'Bu alan zorunludur';
  static const String invalidEmail = 'Geçerli bir e-posta girin';
  static const String weakPassword = 'Şifre en az 6 karakter olmalı';

  // Form Labels (Eksik olanlar)
  static const String nameHint = 'Adınız Soyadınız';
  static const String phoneHint = 'Telefon Numaranız';
  static const String confirmPasswordHint = 'Şifreyi Onayla';
} 