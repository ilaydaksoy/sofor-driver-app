import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  
  User? get currentUser => _authService.currentUser;
  bool get isLoggedIn => _authService.isLoggedIn;
  bool get isLoading => _isLoading;
  
  bool _isLoading = false;
  String? _error;

  String? get error => _error;

  Future<void> initialize() async {
    await _authService.initialize();
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    _setLoading(true);
    _clearError();
    
    try {
      final success = await _authService.login(email, password);
      if (success) {
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> register({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    _setLoading(true);
    _clearError();
    
    try {
      final success = await _authService.register(
        name: name,
        email: email,
        password: password,
        phone: phone,
      );
      
      if (success) {
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> logout() async {
    _setLoading(true);
    
    try {
      await _authService.logout();
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<User?> updateProfile({
    String? name,
    String? phone,
  }) async {
    _setLoading(true);
    _clearError();
    
    try {
      final updatedUser = await _authService.updateProfile(
        name: name,
        phone: phone,
      );
      
      notifyListeners();
      return updatedUser;
    } catch (e) {
      _setError(e.toString());
      return null;
    } finally {
      _setLoading(false);
    }
  }

  Future<User?> refreshProfile() async {
    _setLoading(true);
    _clearError();
    
    try {
      final user = await _authService.refreshProfile();
      notifyListeners();
      return user;
    } catch (e) {
      _setError(e.toString());
      return null;
    } finally {
      _setLoading(false);
    }
  }

  bool validateEmail(String email) {
    return _authService.validateEmail(email);
  }

  bool validatePassword(String password) {
    return _authService.validatePassword(password);
  }

  bool validatePhone(String phone) {
    return _authService.validatePhone(phone);
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
    notifyListeners();
  }

  void clearError() {
    _clearError();
  }
} 