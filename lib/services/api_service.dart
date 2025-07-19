import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/app_constants.dart';
import '../models/user.dart';
import '../models/trip.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  String? _token;

  void setToken(String token) {
    _token = token;
  }

  Map<String, String> get _headers {
    final headers = {
      'Content-Type': 'application/json',
    };
    if (_token != null) {
      headers['Authorization'] = 'Bearer $_token';
    }
    return headers;
  }

  Future<Map<String, dynamic>> _handleResponse(http.Response response) async {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(response.body);
    } else {
      final error = json.decode(response.body);
      throw Exception(error['message'] ?? 'Bir hata oluştu');
    }
  }

  // Auth Services
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      // Test API için demo kullanıcı bilgileri
      if (email == 'demo@turist.com' && password == '123456') {
        return {
          'token': 'demo_token_123456',
                  'user': {
          'id': '1',
          'name': 'Demo Sürücü',
          'email': 'demo@turist.com',
          'phone': '+90 555 123 4567',
          'profile_image': 'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=150&h=150&fit=crop&crop=face',
          'license_number': 'ABC123456',
          'vehicle_model': 'Mercedes Vito',
          'vehicle_plate': '34 ABC 123',
          'is_online': true,
          'rating': 4.8,
          'total_trips': 156,
        }
        };
      }
      
      final response = await http.post(
        Uri.parse(AppConstants.loginUrl),
        headers: _headers,
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );
      
      final data = await _handleResponse(response);
      
      // Reqres.in API response formatını uyarlama
      if (data.containsKey('token')) {
        return {
          'token': data['token'],
                  'user': {
          'id': '1',
          'name': 'Test Sürücü',
          'email': email,
          'phone': '+90 555 000 0000',
          'profile_image': 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=150&h=150&fit=crop&crop=face',
          'license_number': 'TEST123456',
          'vehicle_model': 'Test Araç',
          'vehicle_plate': '34 TEST 000',
          'is_online': true,
          'rating': 4.5,
          'total_trips': 50,
        }
        };
      }
      
      throw Exception('Geçersiz e-posta veya şifre');
    } catch (e) {
      throw Exception('Giriş yapılırken hata oluştu: $e');
    }
  }

  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    try {
      // Test API için demo kayıt
      return {
        'token': 'demo_register_token_${DateTime.now().millisecondsSinceEpoch}',
        'user': {
          'id': DateTime.now().millisecondsSinceEpoch.toString(),
          'name': name,
          'email': email,
          'phone': phone,
          'profile_image': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
          'is_online': true,
          'rating': 0.0,
          'total_trips': 0,
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        }
      };
    } catch (e) {
      throw Exception('Kayıt olurken hata oluştu: $e');
    }
  }

  // User Services
  Future<User> getProfile() async {
    try {
      final response = await http.get(
        Uri.parse(AppConstants.profileUrl),
        headers: _headers,
      );
      final data = await _handleResponse(response);
      return User.fromJson(data['user']);
    } catch (e) {
      throw Exception('Profil bilgileri alınırken hata oluştu: $e');
    }
  }

  Future<User> updateProfile({
    String? name,
    String? phone,
  }) async {
    try {
      final response = await http.put(
        Uri.parse(AppConstants.profileUrl),
        headers: _headers,
        body: json.encode({
          if (name != null) 'name': name,
          if (phone != null) 'phone': phone,
        }),
      );
      final data = await _handleResponse(response);
      return User.fromJson(data['user']);
    } catch (e) {
      throw Exception('Profil güncellenirken hata oluştu: $e');
    }
  }

  // Trip Services
  Future<List<Trip>> getTrips({String? status}) async {
    try {
      // Demo seferler
      final List<Trip> demoTrips = [
        Trip(
          id: '1',
          driverId: 'driver_1',
          passengerId: 'passenger_1',
          passengerName: 'Ahmet Yılmaz',
          passengerPhone: '+90 555 111 1111',
          pickupLocation: 'Kızılay, Ankara',
          dropoffLocation: 'Ulus, Ankara',
          pickupLatitude: 39.9208,
          pickupLongitude: 32.8541,
          dropoffLatitude: 39.9426,
          dropoffLongitude: 32.8597,
          status: 'pending',
          fare: 45.0,
          distance: 3.2,
          scheduledTime: DateTime.now().add(const Duration(minutes: 15)),
          createdAt: DateTime.now().subtract(const Duration(minutes: 10)),
          updatedAt: DateTime.now().subtract(const Duration(minutes: 10)),
        ),
        Trip(
          id: '2',
          driverId: 'driver_1',
          passengerId: 'passenger_2',
          passengerName: 'Fatma Demir',
          passengerPhone: '+90 555 222 2222',
          pickupLocation: 'Çankaya, Ankara',
          dropoffLocation: 'Keçiören, Ankara',
          pickupLatitude: 39.9334,
          pickupLongitude: 32.8597,
          dropoffLatitude: 39.9833,
          dropoffLongitude: 32.8667,
          status: 'active',
          fare: 35.0,
          distance: 2.8,
          scheduledTime: DateTime.now().add(const Duration(minutes: 5)),
          startTime: DateTime.now().subtract(const Duration(minutes: 5)),
          createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
          updatedAt: DateTime.now().subtract(const Duration(minutes: 5)),
        ),
        Trip(
          id: '3',
          driverId: 'driver_1',
          passengerId: 'passenger_3',
          passengerName: 'Mehmet Kaya',
          passengerPhone: '+90 555 333 3333',
          pickupLocation: 'Mamak, Ankara',
          dropoffLocation: 'Sincan, Ankara',
          pickupLatitude: 39.9500,
          pickupLongitude: 32.9000,
          dropoffLatitude: 39.9667,
          dropoffLongitude: 32.5833,
          status: 'completed',
          fare: 60.0,
          distance: 8.5,
          scheduledTime: DateTime.now().subtract(const Duration(hours: 2)),
          startTime: DateTime.now().subtract(const Duration(hours: 2, minutes: 10)),
          endTime: DateTime.now().subtract(const Duration(hours: 1, minutes: 45)),
          rating: 4.8,
          review: 'Çok güzel bir yolculuktu, teşekkürler!',
          createdAt: DateTime.now().subtract(const Duration(hours: 2)),
          updatedAt: DateTime.now().subtract(const Duration(hours: 1, minutes: 45)),
        ),
      ];
      
      if (status != null) {
        return demoTrips.where((trip) => trip.status == status).toList();
      }
      
      return demoTrips;
    } catch (e) {
      throw Exception('Seferler alınırken hata oluştu: $e');
    }
  }

  Future<Trip> getTrip(String tripId) async {
    try {
      final response = await http.get(
        Uri.parse('${AppConstants.tripsUrl}/$tripId'),
        headers: _headers,
      );
      final data = await _handleResponse(response);
      return Trip.fromJson(data['trip']);
    } catch (e) {
      throw Exception('Sefer detayları alınırken hata oluştu: $e');
    }
  }

  Future<Trip> acceptTrip(String tripId) async {
    try {
      final response = await http.post(
        Uri.parse('${AppConstants.tripsUrl}/$tripId/accept'),
        headers: _headers,
      );
      final data = await _handleResponse(response);
      return Trip.fromJson(data['trip']);
    } catch (e) {
      throw Exception('Sefer kabul edilirken hata oluştu: $e');
    }
  }

  Future<Trip> startTrip(String tripId) async {
    try {
      final response = await http.post(
        Uri.parse('${AppConstants.tripsUrl}/$tripId/start'),
        headers: _headers,
      );
      final data = await _handleResponse(response);
      return Trip.fromJson(data['trip']);
    } catch (e) {
      throw Exception('Sefer başlatılırken hata oluştu: $e');
    }
  }

  Future<Trip> completeTrip(String tripId) async {
    try {
      final response = await http.post(
        Uri.parse('${AppConstants.tripsUrl}/$tripId/complete'),
        headers: _headers,
      );
      final data = await _handleResponse(response);
      return Trip.fromJson(data['trip']);
    } catch (e) {
      throw Exception('Sefer tamamlanırken hata oluştu: $e');
    }
  }

  Future<Trip> cancelTrip(String tripId, String reason) async {
    try {
      final response = await http.post(
        Uri.parse('${AppConstants.tripsUrl}/$tripId/cancel'),
        headers: _headers,
        body: json.encode({'reason': reason}),
      );
      final data = await _handleResponse(response);
      return Trip.fromJson(data['trip']);
    } catch (e) {
      throw Exception('Sefer iptal edilirken hata oluştu: $e');
    }
  }

  // Location Services
  Future<void> updateLocation(double latitude, double longitude) async {
    try {
      await http.post(
        Uri.parse('${AppConstants.baseUrl}/location'),
        headers: _headers,
        body: json.encode({
          'latitude': latitude,
          'longitude': longitude,
        }),
      );
    } catch (e) {
      throw Exception('Konum güncellenirken hata oluştu: $e');
    }
  }

  Future<void> updateOnlineStatus(bool isOnline) async {
    try {
      await http.post(
        Uri.parse('${AppConstants.baseUrl}/status'),
        headers: _headers,
        body: json.encode({
          'is_online': isOnline,
        }),
      );
    } catch (e) {
      throw Exception('Durum güncellenirken hata oluştu: $e');
    }
  }
} 