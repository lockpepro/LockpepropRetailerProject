class QrResponse {
  final int? status;
  final QrData? data;

  QrResponse({this.status, this.data});

  factory QrResponse.fromJson(Map<String, dynamic> json) {
    return QrResponse(
      status: json["status"] is int ? json["status"] : 0,
      data: json["data"] == null ? null : QrData.fromJson(json["data"]),
    );
  }
}

class QrData {
  final String? deviceId;
  final String? qrCode;
  final String? expiresIn;

  QrData({this.deviceId, this.qrCode, this.expiresIn});

  factory QrData.fromJson(Map<String, dynamic> json) {
    return QrData(
      deviceId: (json["deviceId"] ?? "").toString(),
      qrCode: (json["qrCode"] ?? "").toString(),
      expiresIn: (json["expiresIn"] ?? "").toString(),
    );
  }
}
