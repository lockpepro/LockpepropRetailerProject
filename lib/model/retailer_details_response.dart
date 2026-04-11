class RetailerDetailsResponse {
  final int status;
  final String? message; // ✅ ADD (for update response)
  final RetailerDetailsData? data;

  RetailerDetailsResponse({
    required this.status,
    this.message,
    required this.data,
  });

  factory RetailerDetailsResponse.fromJson(Map<String, dynamic> json) {
    return RetailerDetailsResponse(
      status: (json["status"] ?? 0) as int,
      message: json["message"]?.toString(), // ✅ SAFE
      data: json["data"] == null
          ? null
          : RetailerDetailsData.fromJson(json["data"] as Map<String, dynamic>),
    );
  }
}

// class RetailerDetailsData {
//   final String retailerId;
//   final String customId;
//   final String retailerCode;
//   final String retailerName;
//   final String ownerName;
//   final String? image;
//   final String mobile;
//   final String email;
//   final String state;
//   final bool status;
//   final double balance;
//   final String createdAt;
//
//   // ✅ extra optional fields
//   final String? address;
//   final String? gstNumber;
//   final String? membershipPlan;
//
//   RetailerDetailsData({
//     required this.retailerId,
//     required this.customId,
//     required this.retailerCode,
//     required this.retailerName,
//     required this.ownerName,
//     required this.image,
//     required this.mobile,
//     required this.email,
//     required this.state,
//     required this.status,
//     required this.balance,
//     required this.createdAt,
//     this.address,
//     this.gstNumber,
//     this.membershipPlan,
//   });
//
//   factory RetailerDetailsData.fromJson(Map<String, dynamic> json) {
//     // ✅ helper safe string reader
//     String s(dynamic v) => (v ?? "").toString();
//
//     return RetailerDetailsData(
//       // ✅ update response me _id hota hai, details me retailerId
//       retailerId: s(json["retailerId"]).isNotEmpty
//           ? s(json["retailerId"])
//           : s(json["_id"]),
//       customId: s(json["customId"]).isNotEmpty
//           ? s(json["customId"])
//           : s(json["customId"]),
//
//       retailerCode: s(json["retailerCode"]),
//
//       // ✅ update response me fullName, details me retailerName
//       retailerName: s(json["retailerName"]).isNotEmpty
//           ? s(json["retailerName"])
//           : s(json["fullName"]),
//
//       ownerName: s(json["ownerName"]),
//
//       image: json["image"]?.toString(),
//
//       // ✅ update response me phone, details me mobile
//       mobile: s(json["mobile"]).isNotEmpty
//           ? s(json["mobile"])
//           : s(json["phone"]),
//
//       email: s(json["email"]),
//       state: s(json["state"]),
//
//       status: (json["status"] ?? false) == true,
//
//       balance: (json["balance"] is num)
//           ? (json["balance"] as num).toDouble()
//           : double.tryParse(s(json["balance"]).isEmpty ? "0" : s(json["balance"])) ?? 0.0,
//
//       createdAt: s(json["createdAt"]),
//
//       // ✅ update response compatible
//       address: s(json["streetAddress"]).isNotEmpty
//           ? s(json["streetAddress"])
//           : s(json["address"]),
//
//       gstNumber: s(json["gstNumber"]),
//       membershipPlan: s(json["membershipPlan"]),
//     );
//   }
// }

class RetailerDetailsData {
  final String retailerId;
  final String customId;
  final String retailerCode;
  final String retailerName;
  final String ownerName;
  final String? image;
  final String mobile;
  final String email;
  final String state;
  final bool status;
  final double balance;
  final String createdAt;

  /// ✅ NEW FIELDS (NO BREAK)
  final String? companyName;
  final String? city;
  final String? address;
  final String? gstNumber;
  final String? membershipPlan;

  RetailerDetailsData({
    required this.retailerId,
    required this.customId,
    required this.retailerCode,
    required this.retailerName,
    required this.ownerName,
    required this.image,
    required this.mobile,
    required this.email,
    required this.state,
    required this.status,
    required this.balance,
    required this.createdAt,
    this.companyName,
    this.city,
    this.address,
    this.gstNumber,
    this.membershipPlan,
  });

  factory RetailerDetailsData.fromJson(Map<String, dynamic> json) {
    String s(dynamic v) => (v ?? "").toString();

    return RetailerDetailsData(
      /// ✅ ID SAFE
      retailerId: s(json["retailerId"]).isNotEmpty
          ? s(json["retailerId"])
          : s(json["_id"]),

      customId: s(json["customId"]),
      retailerCode: s(json["retailerCode"]),

      /// ✅ NAME SAFE
      retailerName: s(json["retailerName"]).isNotEmpty
          ? s(json["retailerName"])
          : s(json["fullName"]),

      ownerName: s(json["ownerName"]),

      image: json["image"]?.toString(),

      /// ✅ PHONE SAFE
      mobile: s(json["mobile"]).isNotEmpty
          ? s(json["mobile"])
          : s(json["phone"]),

      email: s(json["email"]),
      state: s(json["state"]),

      status: (json["status"] ?? false) == true,

      balance: (json["balance"] is num)
          ? (json["balance"] as num).toDouble()
          : double.tryParse(s(json["balance"]).isEmpty ? "0" : s(json["balance"])) ?? 0.0,

      createdAt: s(json["createdAt"]),

      /// ✅ NEW SAFE MAPPINGS 🔥

      /// company can come in multiple keys
      companyName: s(json["company"]).isNotEmpty
          ? s(json["company"])
          : s(json["companyName"]),

      /// city
      city: s(json["city"]),

      /// address (multiple keys possible)
      address: s(json["streetAddress"]).isNotEmpty
          ? s(json["streetAddress"])
          : s(json["address"]),

      /// gst
      gstNumber: s(json["gstNumber"]).isNotEmpty
          ? s(json["gstNumber"])
          : s(json["gst"]),

      membershipPlan: s(json["membershipPlan"]),
    );
  }
}