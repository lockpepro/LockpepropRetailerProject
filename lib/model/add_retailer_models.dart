// ✅ model/add_retailer_models.dart
// class AddRetailerResponse {
//   final int status;
//   final String? message;
//   final RetailerData? data;
//
//   AddRetailerResponse({
//     required this.status,
//     this.message,
//     this.data,
//   });
//
//   factory AddRetailerResponse.fromJson(Map<String, dynamic> json) {
//     return AddRetailerResponse(
//       status: _toInt(json["status"]),
//       message: (json["message"] ?? "").toString(),
//       data: json["data"] == null ? null : RetailerData.fromJson(_asMap(json["data"])),
//     );
//   }
// }
//
// class RetailerData {
//   final String userId;
//   final String fullName;
//   final String phone;
//   final String? image;
//   final String email;
//
//   final bool accountVerification;
//   final bool completeProfile;
//
//   final String streetAddress;
//   final String state;
//
//   final String userType;
//   final int wallet;
//   final bool isVerified;
//   final bool status;
//
//   final String documentVerification;
//   final bool isPinSet;
//
//   final String distributorId;
//   final String ownerName;
//   final String gstNumber;
//   final String membershipPlan;
//
//   final String id; // _id
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//
//   RetailerData({
//     required this.userId,
//     required this.fullName,
//     required this.phone,
//     required this.image,
//     required this.email,
//     required this.accountVerification,
//     required this.completeProfile,
//     required this.streetAddress,
//     required this.state,
//     required this.userType,
//     required this.wallet,
//     required this.isVerified,
//     required this.status,
//     required this.documentVerification,
//     required this.isPinSet,
//     required this.distributorId,
//     required this.ownerName,
//     required this.gstNumber,
//     required this.membershipPlan,
//     required this.id,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   factory RetailerData.fromJson(Map<String, dynamic> json) {
//     return RetailerData(
//       userId: (json["userId"] ?? "").toString(),
//       fullName: (json["fullName"] ?? "").toString(),
//       phone: (json["phone"] ?? "").toString(),
//       image: json["image"]?.toString(),
//       email: (json["email"] ?? "").toString(),
//       accountVerification: _toBool(json["accountVerification"]),
//       completeProfile: _toBool(json["completeProfile"]),
//       streetAddress: (json["streetAddress"] ?? "").toString(),
//       state: (json["state"] ?? "").toString(),
//       userType: (json["userType"] ?? "").toString(),
//       wallet: _toInt(json["wallet"]),
//       isVerified: _toBool(json["isVerified"]),
//       status: _toBool(json["status"]),
//       documentVerification: (json["documentVerification"] ?? "").toString(),
//       isPinSet: _toBool(json["isPinSet"]),
//       distributorId: (json["distributorId"] ?? "").toString(),
//       ownerName: (json["ownerName"] ?? "").toString(),
//       gstNumber: (json["gstNumber"] ?? "").toString(),
//       membershipPlan: (json["membershipPlan"] ?? "").toString(),
//       id: (json["_id"] ?? "").toString(),
//       createdAt: _toDate(json["createdAt"]),
//       updatedAt: _toDate(json["updatedAt"]),
//     );
//   }
// }

class AddRetailerResponse {
  final bool success;
  final String message;
  final String? token;
  final UserData? user;

  AddRetailerResponse({
    required this.success,
    required this.message,
    this.token,
    this.user,
  });

  factory AddRetailerResponse.fromJson(Map<String, dynamic> json) {
    return AddRetailerResponse(
      success: json["success"] ?? false,
      message: json["message"] ?? "",
      token: json["token"],
      user: json["user"] != null ? UserData.fromJson(json["user"]) : null,
    );
  }
}

class UserData {
  final String id;
  final String email;
  final String name;
  final String type;
  final String company;

  UserData({
    required this.id,
    required this.email,
    required this.name,
    required this.type,
    required this.company,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json["_id"] ?? "",
      email: json["email"] ?? "",
      name: json["name"] ?? "",
      type: json["type"] ?? "",
      company: json["company"] ?? "",
    );
  }
}
// class AddRetailerRequest {
//   final String retailerName;      // form-data: retailerName
//   final String ownerName;         // ownerName
//   final String phone;             // phone
//   final String email;             // email
//   final String membershipPlan;    // membershipPlan
//   final String state;             // state
//   final String address;           // address
//   final String gstNumber;         // gstNumber
//   final String password;          // password
//   final String confirmPassword;   // confirmPassword
//
//   AddRetailerRequest({
//     required this.retailerName,
//     required this.ownerName,
//     required this.phone,
//     required this.email,
//     required this.membershipPlan,
//     required this.state,
//     required this.address,
//     required this.gstNumber,
//     required this.password,
//     required this.confirmPassword,
//   });
//
//   Map<String, dynamic> toJson() => {
//     "retailerName": retailerName,
//     "ownerName": ownerName,
//     "phone": phone,
//     "email": email,
//     "membershipPlan": membershipPlan,
//     "state": state,
//     "address": address,
//     "gstNumber": gstNumber,
//     "password": password,
//     "confirmPassword": confirmPassword,
//   };
// }

class AddRetailerRequest {
  final String email;
  final String password;
  final String name;
  final String phone;
  final String company;
  final String city;
  final String state;
  final String address;
  final String gst;
  final String parent;
  final String type;

  AddRetailerRequest({
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
    required this.company,
    required this.city,
    required this.state,
    required this.address,
    required this.gst,
    required this.parent,
    this.type = "vendor",
  });

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
    "name": name,
    "phone": phone,
    "company": company,
    "city": city,
    "state": state,
    "address": address,
    "gst": gst,
    "parent": parent,
    "type": type,
  };
}
/* ------------ helpers ------------ */
int _toInt(dynamic v) => v == null ? 0 : (v is int ? v : int.tryParse("$v") ?? 0);

bool _toBool(dynamic v) {
  if (v is bool) return v;
  final s = (v ?? "").toString().toLowerCase();
  return s == "true" || s == "1" || s == "yes";
}

Map<String, dynamic> _asMap(dynamic v) {
  if (v is Map<String, dynamic>) return v;
  if (v is Map) return Map<String, dynamic>.from(v);
  return <String, dynamic>{};
}

DateTime? _toDate(dynamic v) {
  final s = (v ?? "").toString();
  if (s.isEmpty) return null;
  return DateTime.tryParse(s);
}
