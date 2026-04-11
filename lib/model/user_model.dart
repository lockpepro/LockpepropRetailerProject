
// ---------------- MODEL ----------------

// enum UserStatus {active, locked, removed,pending }

enum UserStatus { active, locked, removed, pending }

UserStatus userStatusFromApi(String? status) {
  switch (status?.toUpperCase()) {
    case "ACTIVE":
      return UserStatus.active;
    case "LOCK":
      return UserStatus.locked;
    case "REMOVE":
      return UserStatus.removed;
    case "PENDING":
    default:
      return UserStatus.pending;
  }
}

// class UserModel {
//   final String keyId;
//   final String deviceId;     // ✅ add
//   final String deviceType;   // ✅ add (ANDROID/IPHONE/RUNNING) optional for filters
//
//   // final String productImage;
//   final List<String> productImage; // ✅ FIXED
//
//   final String name;
//   final String mobile;
//   final String imei;
//   final String createdDate;
//
//   final String loanBy;
//   final String brand;
//   final String emi;
//   final String time;
//   final UserStatus status;
//   String? signatureImage; // ✅ ADD THIS
//   String? imei2;          // ✅ ADD THIS ALSO (future safe)
//
//   UserModel({
//     required this.keyId,
//     required this.productImage,
//
//     required this.name,
//     required this.deviceId,
//     required this.deviceType,
//
//     required this.mobile,
//     required this.imei,
//     required this.createdDate,
//
//     required this.loanBy,
//     required this.brand,
//     required this.emi,
//     required this.time,
//     required this.status,
//     required this.signatureImage,
//     required this.imei2,
//   });
//   factory UserModel.fromApi(Map<String, dynamic> json) {
//     return UserModel(
//       keyId: json["keyId"] ?? "",
//       deviceId: json["deviceId"] ?? "",
//       deviceType: json["deviceType"] ?? "",
//       name: json["customerName"] ?? "",
//       // productImage: json["productImage"] ?? "",
//       productImage: (json["productImage"] as List? ?? [])
//           .map((e) => e.toString())
//           .toList(),
//       mobile: json["mobile"] ?? "",
//       imei: json["imei"] ?? "",
//       imei2: json["imei2"] ?? "", // ✅ CORRECT
//
//       createdDate: json["createdAt"] ?? "",
//
//       loanBy: json["loanProvider"] ?? "",
//       brand: json["brandModel"] ?? "",
//       emi: json["emiStatus"] ?? "0/0",
//       time: json["createdAt"] ?? "",
//       signatureImage: json["signature"] ?? "",
//       status: userStatusFromApi(json["status"]),
//     );
//   }
// }
class UserModel {
  final String keyId;
  final String deviceId;
  final String deviceType;

  final List<String> productImage;

  final String name;
  final String mobile;
  final String imei;
  final String createdDate;

  final String loanBy;
  final String brand;
  final String emi;
  final String time;
  final UserStatus status;

  /// ✅ NEW FIELDS
  String? signatureImage;
  String? imei2;

  /// ✅ EMI / FINANCE (NEW)
  String? productPrice;
  String? downPayment;
  String? balancePayment;
  String? tenure;
  String? interest;
  String? emiAmount;

  UserModel({
    required this.keyId,
    required this.productImage,
    required this.name,
    required this.deviceId,
    required this.deviceType,
    required this.mobile,
    required this.imei,
    required this.createdDate,
    required this.loanBy,
    required this.brand,
    required this.emi,
    required this.time,
    required this.status,

    /// ✅ OPTIONAL (NO BREAK)
    this.signatureImage,
    this.imei2,

    /// ✅ NEW OPTIONAL
    this.productPrice,
    this.downPayment,
    this.balancePayment,
    this.tenure,
    this.interest,
    this.emiAmount,
  });

  factory UserModel.fromApi(Map<String, dynamic> json) {
    final emiData = json["emi"] ?? {}; // ✅ SAFE

    return UserModel(
      keyId: json["keyId"] ?? "",
      deviceId: json["deviceId"] ?? "",
      deviceType: json["deviceType"] ?? "",

      name: json["customerName"] ?? "",

      productImage: (json["productImage"] as List? ?? [])
          .map((e) => e.toString())
          .toList(),

      mobile: json["mobile"] ?? "",

      /// ✅ IMEI FIX
      imei: json["imei"] ?? json["imei1"] ?? "",
      imei2: json["imei2"] ?? "",

      createdDate: json["createdAt"] ?? "",

      loanBy: json["loanProvider"] ?? "",
      brand: json["brandModel"] ?? "",
      emi: json["emiStatus"] ?? "EMI",
      time: json["createdAt"] ?? "",

      /// ✅ SIGNATURE
      signatureImage: json["signature"] ?? "",

      status: userStatusFromApi(json["status"]),

      /// 🔥 EMI DATA MAPPING (MOST IMPORTANT)
      productPrice: emiData["total_amount"]?.toString(),
      downPayment: emiData["down_payment"]?.toString(),
      balancePayment: emiData["loan_amount"]?.toString(),
      tenure: emiData["tenure_months"]?.toString(),
      interest: emiData["interest_rate"]?.toString(),
      emiAmount: emiData["emi_amount"]?.toString(),
    );
  }
}