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
      final response = await http.post(
        Uri.parse(AppConstants.loginUrl),
        headers: _headers,
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );
      return await _handleResponse(response);
    } catch (e) {
      throw Exception('Giriş yapılırken hata oluştu: $e');
    }
  }

  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    String? licenseNumber,
    String? vehicleModel,
    String? vehiclePlate,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(AppConstants.registerUrl),
        headers: _headers,
        body: json.encode({
          'name': name,
          'email': email,
          'password': password,
          'phone': phone,
          'license_number': licenseNumber,
          'vehicle_model': vehicleModel,
          'vehicle_plate': vehiclePlate,
        }),
      );
      return await _handleResponse(response);
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
    String? licenseNumber,
    String? vehicleModel,
    String? vehiclePlate,
  }) async {
    try {
      final response = await http.put(
        Uri.parse(AppConstants.profileUrl),
        headers: _headers,
        body: json.encode({
          if (name != null) 'name': name,
          if (phone != null) 'phone': phone,
          if (licenseNumber != null) 'license_number': licenseNumber,
          if (vehicleModel != null) 'vehicle_model': vehicleModel,
          if (vehiclePlate != null) 'vehicle_plate': vehiclePlate,
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
      final queryParams = <String, String>{};
      if (status != null) {
        queryParams['status'] = status;
      }

      final uri = Uri.parse(AppConstants.tripsUrl).replace(queryParameters: queryParams);
      final response = await http.get(uri, headers: _headers);
      final data = await _handleResponse(response);
      
      final List<Trip> trips = (data['trips'] as List)
          .map((tripJson) => Trip.fromJson(tripJson))
          .toList();
      return trips;
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