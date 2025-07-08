import 'package:flutter/material.dart';
import '../models/trip.dart';
import '../services/api_service.dart';

class TripProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  
  List<Trip> _trips = [];
  Trip? _currentTrip;
  bool _isLoading = false;
  String? _error;

  List<Trip> get trips => _trips;
  Trip? get currentTrip => _currentTrip;
  bool get isLoading => _isLoading;
  String? get error => _error;

  List<Trip> get pendingTrips => _trips.where((trip) => trip.status == 'pending').toList();
  List<Trip> get activeTrips => _trips.where((trip) => trip.status == 'active').toList();
  List<Trip> get completedTrips => _trips.where((trip) => trip.status == 'completed').toList();

  Future<void> loadTrips({String? status}) async {
    _setLoading(true);
    _clearError();
    
    try {
      final trips = await _apiService.getTrips(status: status);
      _trips = trips;
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> loadTrip(String tripId) async {
    _setLoading(true);
    _clearError();
    
    try {
      final trip = await _apiService.getTrip(tripId);
      _currentTrip = trip;
      
      // Update trip in the list
      final index = _trips.indexWhere((t) => t.id == tripId);
      if (index != -1) {
        _trips[index] = trip;
      }
      
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> acceptTrip(String tripId) async {
    _setLoading(true);
    _clearError();
    
    try {
      final trip = await _apiService.acceptTrip(tripId);
      _currentTrip = trip;
      
      // Update trip in the list
      final index = _trips.indexWhere((t) => t.id == tripId);
      if (index != -1) {
        _trips[index] = trip;
      }
      
      notifyListeners();
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> startTrip(String tripId) async {
    _setLoading(true);
    _clearError();
    
    try {
      final trip = await _apiService.startTrip(tripId);
      _currentTrip = trip;
      
      // Update trip in the list
      final index = _trips.indexWhere((t) => t.id == tripId);
      if (index != -1) {
        _trips[index] = trip;
      }
      
      notifyListeners();
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> completeTrip(String tripId) async {
    _setLoading(true);
    _clearError();
    
    try {
      final trip = await _apiService.completeTrip(tripId);
      _currentTrip = trip;
      
      // Update trip in the list
      final index = _trips.indexWhere((t) => t.id == tripId);
      if (index != -1) {
        _trips[index] = trip;
      }
      
      notifyListeners();
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> cancelTrip(String tripId, String reason) async {
    _setLoading(true);
    _clearError();
    
    try {
      final trip = await _apiService.cancelTrip(tripId, reason);
      _currentTrip = trip;
      
      // Update trip in the list
      final index = _trips.indexWhere((t) => t.id == tripId);
      if (index != -1) {
        _trips[index] = trip;
      }
      
      notifyListeners();
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  void setCurrentTrip(Trip? trip) {
    _currentTrip = trip;
    notifyListeners();
  }

  void clearCurrentTrip() {
    _currentTrip = null;
    notifyListeners();
  }

  void addTrip(Trip trip) {
    _trips.add(trip);
    notifyListeners();
  }

  void updateTrip(Trip trip) {
    final index = _trips.indexWhere((t) => t.id == trip.id);
    if (index != -1) {
      _trips[index] = trip;
      notifyListeners();
    }
  }

  void removeTrip(String tripId) {
    _trips.removeWhere((trip) => trip.id == tripId);
    notifyListeners();
  }

  void clearTrips() {
    _trips.clear();
    notifyListeners();
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