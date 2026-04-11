class AddKeyResponse {
  final int? status;
  final String? message;
  final AddKeyData? data;

  AddKeyResponse({this.status, this.message, this.data});

  factory AddKeyResponse.fromJson(Map<String, dynamic> json) {
    return AddKeyResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'] == null ? null : AddKeyData.fromJson(json['data']),
    );
  }
}

class AddKeyData {
  final String? id;     // ✅ "_id" mongo id (device id)
  final String? keyId;  // ✅ "keyId" string
  final String? status;

  AddKeyData({this.id, this.keyId, this.status});

  factory AddKeyData.fromJson(Map<String, dynamic> json) {
    return AddKeyData(
      id: (json['_id'] ?? '').toString(),
      keyId: (json['keyId'] ?? '').toString(),
      status: (json['status'] ?? '').toString(),
    );
  }
}
