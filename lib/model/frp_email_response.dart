class FrpEmailResponse {
  final bool success;
  final String message;
  final FrpEmailData? data;

  FrpEmailResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory FrpEmailResponse.fromJson(Map<String, dynamic> json) {
    return FrpEmailResponse(
      success: json["success"] ?? false,
      message: json["message"] ?? "",
      data: json["data"] != null
          ? FrpEmailData.fromJson(json["data"])
          : null,
    );
  }
}

class FrpEmailData {
  final String id;
  final String oldEmail;
  final String newEmail;
  final int historyCount;

  FrpEmailData({
    required this.id,
    required this.oldEmail,
    required this.newEmail,
    required this.historyCount,
  });

  factory FrpEmailData.fromJson(Map<String, dynamic> json) {
    return FrpEmailData(
      id: json["id"] ?? "",
      oldEmail: json["old_email"] ?? "",
      newEmail: json["new_email"] ?? "",
      historyCount: json["history_count"] ?? 0,
    );
  }
}