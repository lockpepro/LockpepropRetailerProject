// class UpdateRetailerRequest {
//   final String retailerName;
//   final String ownerName;
//   final String phone;
//   final String email;
//   final String membershipPlan;
//   final String state;
//   final String address;
//   final String gstNumber;
//
//   /// optional (agar empty -> send nahi karenge)
//   final String? password;
//   final String? confirmPassword;
//
//   UpdateRetailerRequest({
//     required this.retailerName,
//     required this.ownerName,
//     required this.phone,
//     required this.email,
//     required this.membershipPlan,
//     required this.state,
//     required this.address,
//     required this.gstNumber,
//     this.password,
//     this.confirmPassword,
//   });
// }

class UpdateRetailerResponse {
  final int? status;
  final String? message;
  final dynamic data;

  UpdateRetailerResponse({this.status, this.message, this.data});

  factory UpdateRetailerResponse.fromJson(Map<String, dynamic> json) {
    return UpdateRetailerResponse(
      status: json["status"],
      message: json["message"]?.toString(),
      data: json["data"],
    );
  }
}

class UpdateRetailerRequest {
  final String retailerName;
  final String ownerName;
  final String phone;
  final String email;
  final String membershipPlan;
  final String state;
  final String address;
  final String gstNumber;

  final String? password;         // optional
  final String? confirmPassword;  // optional

  UpdateRetailerRequest({
    required this.retailerName,
    required this.ownerName,
    required this.phone,
    required this.email,
    required this.membershipPlan,
    required this.state,
    required this.address,
    required this.gstNumber,
    this.password,
    this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      "retailerName": retailerName,
      "ownerName": ownerName,
      "phone": phone,
      "email": email,
      "membershipPlan": membershipPlan,
      "state": state,
      "address": address,
      "gstNumber": gstNumber,
    };

    // ✅ only send if provided
    if (password != null && password!.isNotEmpty) {
      map["password"] = password;
    }
    if (confirmPassword != null && confirmPassword!.isNotEmpty) {
      map["confirmPassword"] = confirmPassword;
    }

    return map;
  }
}
