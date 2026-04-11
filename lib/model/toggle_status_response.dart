// class ToggleStatusResponse {
//   final int status;
//   final bool? data;
//
//   ToggleStatusResponse({required this.status, required this.data});
//
//   factory ToggleStatusResponse.fromJson(Map<String, dynamic> json) {
//     return ToggleStatusResponse(
//       status: (json["status"] ?? 0) as int,
//       data: json["data"] == null ? null : (json["data"] == true),
//     );
//   }
// }

class ToggleStatusResponse {
  final bool success;
  final String message;
  final bool isActive;

  ToggleStatusResponse({
    required this.success,
    required this.message,
    required this.isActive,
  });

  factory ToggleStatusResponse.fromJson(Map<String, dynamic> json) {
    return ToggleStatusResponse(
      success: json["success"] ?? false,
      message: json["message"] ?? "",
      isActive: json["data"]?["isActive"] ?? false,
    );
  }
}