class UpdateProfileResponse {

  final bool success;
  final String message;
  final dynamic data;

  UpdateProfileResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) {

    return UpdateProfileResponse(
      success: json["success"] == true,
      message: (json["message"] ?? "Done").toString(),
      data: json["data"],
    );
  }
}