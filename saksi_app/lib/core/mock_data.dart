class MockUser {
  final String fullName;
  final String householdAddress;
  final String hardwareId;
  final double homeZoneLat;
  final double homeZoneLng;

  const MockUser({
    required this.fullName,
    required this.householdAddress,
    required this.hardwareId,
    required this.homeZoneLat,
    required this.homeZoneLng,
  });
}

class MockNoiseIncident {
  final String id;
  final String date;
  final String time;
  final int peakDb;
  final String duration;
  final String status;

  const MockNoiseIncident({
    required this.id,
    required this.date,
    required this.time,
    required this.peakDb,
    required this.duration,
    required this.status,
  });
}

class MockCaseFile {
  final String id;
  final String date;
  final String parties;
  final String status;
  final String location;
  final int peakDb;
  final String duration;
  final String hardwareId;

  const MockCaseFile({
    required this.id,
    required this.date,
    required this.parties,
    required this.status,
    required this.location,
    required this.peakDb,
    required this.duration,
    required this.hardwareId,
  });
}

class MockZoneHotspot {
  final String zoneLabel;
  final String locationLabel;
  final int peakDb;
  final double markerX;
  final double markerY;

  const MockZoneHotspot({
    required this.zoneLabel,
    required this.locationLabel,
    required this.peakDb,
    required this.markerX,
    required this.markerY,
  });
}

class MockData {
  static const int violationThresholdDb = 85;

  static const MockUser resident = MockUser(
    fullName: 'Juan Dela Cruz',
    householdAddress: '144 Mabini St, Brgy. San Juan',
    hardwareId: 'SAKSI-ESP32-94A2',
    homeZoneLat: 14.5995,
    homeZoneLng: 120.9842,
  );

  static const List<MockNoiseIncident> incidents = [
    MockNoiseIncident(
      id: 'LOG-001',
      date: 'Oct 12, 2023',
      time: '11:45 PM',
      peakDb: 88,
      duration: '15 mins',
      status: 'Resolved',
    ),
    MockNoiseIncident(
      id: 'LOG-002',
      date: 'Oct 05, 2023',
      time: '02:10 AM',
      peakDb: 104,
      duration: '45 mins',
      status: 'Pending Review',
    ),
    MockNoiseIncident(
      id: 'LOG-003',
      date: 'Sep 28, 2023',
      time: '09:30 PM',
      peakDb: 92,
      duration: '30 mins',
      status: 'Resolved',
    ),
  ];

  static const List<MockCaseFile> caseFiles = [
    MockCaseFile(
      id: '1042-A',
      date: 'Oct 12, 2023',
      parties: 'Household 104 vs. Brgy',
      status: 'Pending Review',
      location: 'Mabini St. Block 2',
      peakDb: 88,
      duration: '15 minutes',
      hardwareId: 'SAKSI-ESP32-94A2',
    ),
    MockCaseFile(
      id: '1041-B',
      date: 'Oct 10, 2023',
      parties: 'Zone 2 Complainant',
      status: 'Resolved',
      location: 'Rizal Ave.',
      peakDb: 92,
      duration: '30 minutes',
      hardwareId: 'SAKSI-ESP32-52B1',
    ),
  ];

  static const List<MockZoneHotspot> hotspots = [
    MockZoneHotspot(
      zoneLabel: 'Zone 4',
      locationLabel: 'Mabini St. Block 2',
      peakDb: 88,
      markerX: 0.55,
      markerY: 0.45,
    ),
    MockZoneHotspot(
      zoneLabel: 'Zone 2',
      locationLabel: 'Rizal Ave.',
      peakDb: 75,
      markerX: 0.30,
      markerY: 0.25,
    ),
    MockZoneHotspot(
      zoneLabel: 'Zone 7',
      locationLabel: 'San Juan Proper',
      peakDb: 65,
      markerX: 0.20,
      markerY: 0.70,
    ),
  ];
}

