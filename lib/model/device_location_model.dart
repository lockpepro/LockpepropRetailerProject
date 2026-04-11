class DeviceLocationModel {
  final double latitude;
  final double longitude;
  final double accuracy;
  final String timestamp;
  final String provider;

  DeviceLocationModel({
    required this.latitude,
    required this.longitude,
    required this.accuracy,
    required this.timestamp,
    required this.provider,
  });

  factory DeviceLocationModel.fromJson(Map<String, dynamic> json) {
    final loc = json['location'];

    return DeviceLocationModel(
      latitude: loc['latitude']?.toDouble() ?? 0,
      longitude: loc['longitude']?.toDouble() ?? 0,
      accuracy: loc['accuracy']?.toDouble() ?? 0,
      timestamp: loc['timestamp'] ?? "",
      provider: loc['provider'] ?? "",
    );
  }
}