class Trip {
  final String id;
  final String driverId;
  final String passengerId;
  final String passengerName;
  final String passengerPhone;
  final String pickupLocation;
  final String dropoffLocation;
  final double pickupLatitude;
  final double pickupLongitude;
  final double dropoffLatitude;
  final double dropoffLongitude;
  final double distance;
  final double fare;
  final String status;
  final DateTime scheduledTime;
  final DateTime? startTime;
  final DateTime? endTime;
  final String? notes;
  final double? rating;
  final String? review;
  final DateTime createdAt;
  final DateTime updatedAt;

  Trip({
    required this.id,
    required this.driverId,
    required this.passengerId,
    required this.passengerName,
    required this.passengerPhone,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.pickupLatitude,
    required this.pickupLongitude,
    required this.dropoffLatitude,
    required this.dropoffLongitude,
    required this.distance,
    required this.fare,
    required this.status,
    required this.scheduledTime,
    this.startTime,
    this.endTime,
    this.notes,
    this.rating,
    this.review,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      id: json['id'] ?? '',
      driverId: json['driver_id'] ?? '',
      passengerId: json['passenger_id'] ?? '',
      passengerName: json['passenger_name'] ?? '',
      passengerPhone: json['passenger_phone'] ?? '',
      pickupLocation: json['pickup_location'] ?? '',
      dropoffLocation: json['dropoff_location'] ?? '',
      pickupLatitude: (json['pickup_latitude'] ?? 0.0).toDouble(),
      pickupLongitude: (json['pickup_longitude'] ?? 0.0).toDouble(),
      dropoffLatitude: (json['dropoff_latitude'] ?? 0.0).toDouble(),
      dropoffLongitude: (json['dropoff_longitude'] ?? 0.0).toDouble(),
      distance: (json['distance'] ?? 0.0).toDouble(),
      fare: (json['fare'] ?? 0.0).toDouble(),
      status: json['status'] ?? '',
      scheduledTime: DateTime.parse(json['scheduled_time'] ?? DateTime.now().toIso8601String()),
      startTime: json['start_time'] != null ? DateTime.parse(json['start_time']) : null,
      endTime: json['end_time'] != null ? DateTime.parse(json['end_time']) : null,
      notes: json['notes'],
      rating: json['rating'] != null ? (json['rating'] as num).toDouble() : null,
      review: json['review'],
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'driver_id': driverId,
      'passenger_id': passengerId,
      'passenger_name': passengerName,
      'passenger_phone': passengerPhone,
      'pickup_location': pickupLocation,
      'dropoff_location': dropoffLocation,
      'pickup_latitude': pickupLatitude,
      'pickup_longitude': pickupLongitude,
      'dropoff_latitude': dropoffLatitude,
      'dropoff_longitude': dropoffLongitude,
      'distance': distance,
      'fare': fare,
      'status': status,
      'scheduled_time': scheduledTime.toIso8601String(),
      'start_time': startTime?.toIso8601String(),
      'end_time': endTime?.toIso8601String(),
      'notes': notes,
      'rating': rating,
      'review': review,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  Trip copyWith({
    String? id,
    String? driverId,
    String? passengerId,
    String? passengerName,
    String? passengerPhone,
    String? pickupLocation,
    String? dropoffLocation,
    double? pickupLatitude,
    double? pickupLongitude,
    double? dropoffLatitude,
    double? dropoffLongitude,
    double? distance,
    double? fare,
    String? status,
    DateTime? scheduledTime,
    DateTime? startTime,
    DateTime? endTime,
    String? notes,
    double? rating,
    String? review,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Trip(
      id: id ?? this.id,
      driverId: driverId ?? this.driverId,
      passengerId: passengerId ?? this.passengerId,
      passengerName: passengerName ?? this.passengerName,
      passengerPhone: passengerPhone ?? this.passengerPhone,
      pickupLocation: pickupLocation ?? this.pickupLocation,
      dropoffLocation: dropoffLocation ?? this.dropoffLocation,
      pickupLatitude: pickupLatitude ?? this.pickupLatitude,
      pickupLongitude: pickupLongitude ?? this.pickupLongitude,
      dropoffLatitude: dropoffLatitude ?? this.dropoffLatitude,
      dropoffLongitude: dropoffLongitude ?? this.dropoffLongitude,
      distance: distance ?? this.distance,
      fare: fare ?? this.fare,
      status: status ?? this.status,
      scheduledTime: scheduledTime ?? this.scheduledTime,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      notes: notes ?? this.notes,
      rating: rating ?? this.rating,
      review: review ?? this.review,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
} 