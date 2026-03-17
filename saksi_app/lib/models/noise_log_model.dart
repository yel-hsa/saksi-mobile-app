import 'package:cloud_firestore/cloud_firestore.dart';

class NoiseLogModel {
  final String id;
  final String hardwareId;
  final String userId;
  final double peakDb;
  final int durationSeconds;
  final DateTime timestamp;
  final double? locationLat;
  final double? locationLng;
  final String status; // 'active', 'resolved'

  NoiseLogModel({
    required this.id,
    required this.hardwareId,
    required this.userId,
    required this.peakDb,
    required this.durationSeconds,
    required this.timestamp,
    this.locationLat,
    this.locationLng,
    required this.status,
  });

  factory NoiseLogModel.fromMap(Map<String, dynamic> map, String id) {
    return NoiseLogModel(
      id: id,
      hardwareId: map['hardware_id'] ?? '',
      userId: map['user_id'] ?? '',
      peakDb: (map['peak_db'] ?? 0).toDouble(),
      durationSeconds: map['duration_seconds'] ?? 0,
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      locationLat: map['location_lat']?.toDouble(),
      locationLng: map['location_lng']?.toDouble(),
      status: map['status'] ?? 'active',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'hardware_id': hardwareId,
      'user_id': userId,
      'peak_db': peakDb,
      'duration_seconds': durationSeconds,
      'timestamp': Timestamp.fromDate(timestamp),
      'location_lat': locationLat,
      'location_lng': locationLng,
      'status': status,
    };
  }
}
