class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String? profileImage;
  final String? licenseNumber;
  final String? vehicleModel;
  final String? vehiclePlate;
  final double rating;
  final int totalTrips;
  final bool isOnline;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.profileImage,
    this.licenseNumber,
    this.vehicleModel,
    this.vehiclePlate,
    this.rating = 0.0,
    this.totalTrips = 0,
    this.isOnline = false,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      profileImage: json['profile_image'],
      licenseNumber: json['license_number'],
      vehicleModel: json['vehicle_model'],
      vehiclePlate: json['vehicle_plate'],
      rating: (json['rating'] ?? 0.0).toDouble(),
      totalTrips: json['total_trips'] ?? 0,
      isOnline: json['is_online'] ?? false,
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'profile_image': profileImage,
      'license_number': licenseNumber,
      'vehicle_model': vehicleModel,
      'vehicle_plate': vehiclePlate,
      'rating': rating,
      'total_trips': totalTrips,
      'is_online': isOnline,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? profileImage,
    String? licenseNumber,
    String? vehicleModel,
    String? vehiclePlate,
    double? rating,
    int? totalTrips,
    bool? isOnline,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profileImage: profileImage ?? this.profileImage,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      vehicleModel: vehicleModel ?? this.vehicleModel,
      vehiclePlate: vehiclePlate ?? this.vehiclePlate,
      rating: rating ?? this.rating,
      totalTrips: totalTrips ?? this.totalTrips,
      isOnline: isOnline ?? this.isOnline,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
} 