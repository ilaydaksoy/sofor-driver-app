import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'constants/app_constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'Sürücü Bul',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.yellow,
          primaryColor: const Color(AppConstants.primaryColorValue),
          scaffoldBackgroundColor: const Color(AppConstants.backgroundColorValue),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(AppConstants.secondaryColorValue),
            foregroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          cardTheme: CardThemeData(
            color: const Color(AppConstants.cardColorValue),
            elevation: 2,
            shadowColor: const Color(AppConstants.shadowLightColorValue),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(AppConstants.primaryColorValue),
              foregroundColor: Colors.black,
              elevation: 2,
              shadowColor: const Color(AppConstants.shadowLightColorValue),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: const Color(AppConstants.primaryColorValue),
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: const Color(AppConstants.surfaceColorValue),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(AppConstants.borderColorValue),
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(AppConstants.borderColorValue),
                width: 1,
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
                width: 1,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            labelStyle: const TextStyle(
              color: Color(AppConstants.textSecondaryColorValue),
              fontSize: 16,
            ),
            hintStyle: const TextStyle(
              color: Color(AppConstants.textTertiaryColorValue),
              fontSize: 16,
            ),
          ),
          textTheme: const TextTheme(
            headlineLarge: TextStyle(
              color: Color(AppConstants.textPrimaryColorValue),
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
            headlineMedium: TextStyle(
              color: Color(AppConstants.textPrimaryColorValue),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            headlineSmall: TextStyle(
              color: Color(AppConstants.textPrimaryColorValue),
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            titleLarge: TextStyle(
              color: Color(AppConstants.textPrimaryColorValue),
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            titleMedium: TextStyle(
              color: Color(AppConstants.textPrimaryColorValue),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            titleSmall: TextStyle(
              color: Color(AppConstants.textPrimaryColorValue),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            bodyLarge: TextStyle(
              color: Color(AppConstants.textPrimaryColorValue),
              fontSize: 16,
            ),
            bodyMedium: TextStyle(
              color: Color(AppConstants.textPrimaryColorValue),
              fontSize: 14,
            ),
            bodySmall: TextStyle(
              color: Color(AppConstants.textSecondaryColorValue),
              fontSize: 12,
            ),
            labelLarge: TextStyle(
              color: Color(AppConstants.textPrimaryColorValue),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            labelMedium: TextStyle(
              color: Color(AppConstants.textSecondaryColorValue),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            labelSmall: TextStyle(
              color: Color(AppConstants.textTertiaryColorValue),
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
          colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: Color(AppConstants.primaryColorValue),
            onPrimary: Colors.black,
            secondary: Color(AppConstants.secondaryColorValue),
            onSecondary: Colors.white,
            tertiary: Color(AppConstants.accentColorValue),
            onTertiary: Colors.black,
            error: Color(AppConstants.errorColorValue),
            onError: Colors.white,
            background: Color(AppConstants.backgroundColorValue),
            onBackground: Color(AppConstants.textPrimaryColorValue),
            surface: Color(AppConstants.surfaceColorValue),
            onSurface: Color(AppConstants.textPrimaryColorValue),
            surfaceVariant: Color(AppConstants.cardColorValue),
            onSurfaceVariant: Color(AppConstants.textSecondaryColorValue),
            outline: Color(AppConstants.borderColorValue),
            outlineVariant: Color(AppConstants.borderLightColorValue),
            shadow: Color(AppConstants.shadowColorValue),
            scrim: Color(AppConstants.shadowLightColorValue),
            inverseSurface: Color(AppConstants.textPrimaryColorValue),
            onInverseSurface: Color(AppConstants.surfaceColorValue),
            inversePrimary: Color(AppConstants.secondaryColorValue),
            surfaceTint: Color(AppConstants.primaryColorValue),
          ),
        ),
        home: Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            return authProvider.isLoggedIn ? HomeScreen() : LoginScreen();
          },
        ),
      ),
    );
  }
}
