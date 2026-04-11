class UploadDocResponse {
  final int status;
  final String message;
  final String url;

  UploadDocResponse({
    required this.status,
    required this.message,
    required this.url,
  });

  factory UploadDocResponse.fromJson(Map<String, dynamic> json) {
    final data = json["data"];
    String url = "";

    if (data is List && data.isNotEmpty && data.first is Map) {
      url = (data.first["img"] ?? "").toString();
    }

    return UploadDocResponse(
      status: (json["status"] ?? 0) as int,
      message: (json["message"] ?? "").toString(),
      url: url,
    );
  }
}
