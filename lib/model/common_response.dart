// class CommonApiResponse {
//   final bool success;
//   final String message;
//   final dynamic data;
//
//   CommonApiResponse({
//     required this.success,
//     required this.message,
//     this.data,
//   });
//
//   factory CommonApiResponse.fromJson(Map<String, dynamic> json) {
//     return CommonApiResponse(
//       success: (json["success"] == true) || (json["status"] == 200),
//       message: (json["message"] ?? "").toString(),
//       data: json["data"],
//     );
//   }
// }

class CommonResponse {
  final int status; // for backward compatibility
  final bool successFlag;
  final String message;
  final dynamic data;

  CommonResponse({
    required this.status,
    required this.successFlag,
    required this.message,
    this.data,
  });

  factory CommonResponse.fromJson(Map<String, dynamic> json) {
    final bool success = (json["success"] == true) || (json["status"] == 200);

    return CommonResponse(
      status: (json["status"] is int)
          ? (json["status"] as int)
          : (success ? 200 : 0),
      successFlag: success,
      message: (json["message"] ?? "Done").toString(),
      data: json["data"],
    );
  }

  bool get success => successFlag == true;
}