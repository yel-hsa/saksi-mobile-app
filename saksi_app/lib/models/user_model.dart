enum UserRole { resident, official }

class UserModel {
  final String uid;
  final UserRole role;
  final String? hardwareId;
  final double? homeZoneLat;
  final double? homeZoneLng;

  UserModel({
    required this.uid,
    required this.role,
    this.hardwareId,
    this.homeZoneLat,
    this.homeZoneLng,
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String id) {
    return UserModel(
      uid: id,
      role: map['role'] == 'official' ? UserRole.official : UserRole.resident,
      hardwareId: map['hardware_id'],
      homeZoneLat: map['home_zone_lat']?.toDouble(),
      homeZoneLng: map['home_zone_lng']?.toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'role': role.name,
      'hardware_id': hardwareId,
      'home_zone_lat': homeZoneLat,
      'home_zone_lng': homeZoneLng,
    };
  }
}
