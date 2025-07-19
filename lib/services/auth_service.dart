import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';
import '../models/user.dart';
import 'api_service.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final ApiService _apiService = ApiService();
  User? _currentUser;
  String? _token;

  User? get currentUser => _currentUser;
  String? get token => _token;
  bool get isLoggedIn => _token != null && _currentUser != null;

  Future<void> initialize() async {
    await _loadStoredData();
  }

  Future<void> _loadStoredData() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString(AppConstants.tokenKey);
    
    if (_token != null) {
      _apiService.setToken(_token!);
      final userJson = prefs.getString(AppConstants.userKey);
      if (userJson != null) {
        _currentUser = User.fromJson(json.decode(userJson));
      }
    }
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    if (_token != null) {
      await prefs.setString(AppConstants.tokenKey, _token!);
      await prefs.setBool(AppConstants.isLoggedInKey, true);
    }
    if (_currentUser != null) {
      await prefs.setString(AppConstants.userKey, json.encode(_currentUser!.toJson()));
    }
  }

  Future<void> _clearData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstants.tokenKey);
    await prefs.remove(AppConstants.userKey);
    await prefs.remove(AppConstants.isLoggedInKey);
  }

  Future<bool> login(String email, String password) async {
    try {
      final response = await _apiService.login(email, password);
      
      _token = response['token'];
      _currentUser = User.fromJson(response['user']);
      
      _apiService.setToken(_token!);
      await _saveData();
      
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> register({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    try {
      final response = await _apiService.register(
        name: name,
        email: email,
        password: password,
        phone: phone,
      );
      
      _token = response['token'];
      _currentUser = User.fromJson(response['user']);
      
      _apiService.setToken(_token!);
      await _saveData();
      
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    _token = null;
    _currentUser = null;
    _apiService.setToken('');
    await _clearData();
  }

  Future<User> updateProfile({
    String? name,
    String? phone,
  }) async {
    try {
      final updatedUser = await _apiService.updateProfile(
        name: name,
        phone: phone,
      );
      
      _currentUser = updatedUser;
      await _saveData();
      
      return updatedUser;
    } catch (e) {
      rethrow;
    }
  }

  Future<User> refreshProfile() async {
    try {
      final user = await _apiService.getProfile();
      _currentUser = user;
      await _saveData();
      return user;
    } catch (e) {
      rethrow;
    }
  }

  bool validateEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  bool validatePassword(String password) {
    return password.length >= 6;
  }

  bool validatePhone(String phone) {
    final phoneRegex = RegExp(r'^[0-9]{10,11}$');
    return phoneRegex.hasMatch(phone.replaceAll(RegExp(r'[^\d]'), ''));
  }
} 