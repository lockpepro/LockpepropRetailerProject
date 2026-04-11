
class ChangePasswordResponse {

  final bool success;
  final String message;

  ChangePasswordResponse({
    required this.success,
    required this.message,
  });

  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) {

    return ChangePasswordResponse(
      success: json["success"] == true,
      message: (json["message"] ?? "").toString(),
    );
  }
}

class CommonResponse {
  final int status;
  final String message;
  final dynamic data;

  CommonResponse({required this.status, required this.message,this.data});

  factory CommonResponse.fromJson(Map<String, dynamic> json) {
    return CommonResponse(
      status: (json["status"] is int) ? json["status"] : 0,
      message: (json["message"] ?? "Done").toString(),
      data: json["data"],

    );
  }

  bool get success => status == 200;
}


