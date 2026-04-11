class DeviceListResponse {
  final int status;
  final DeviceListMeta? meta;
  final List<DeviceItem> data;

  DeviceListResponse({
    required this.status,
    required this.meta,
    required this.data,
  });

  factory DeviceListResponse.fromJson(Map<String, dynamic> json) {
    return DeviceListResponse(
      status: (json["status"] ?? 0) as int,
      meta: json["meta"] == null ? null : DeviceListMeta.fromJson(json["meta"]),
      data: (json["data"] as List? ?? [])
          .map((e) => DeviceItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class DeviceListMeta {
  final int total;
  final int page;
  final int limit;

  DeviceListMeta({
    required this.total,
    required this.page,
    required this.limit,
  });

  factory DeviceListMeta.fromJson(Map<String, dynamic> json) {
    return DeviceListMeta(
      total: (json["total"] ?? 0) as int,
      page: (json["page"] ?? 1) as int,
      limit: (json["limit"] ?? 10) as int,
    );
  }
}

// class DeviceItem {
//   final String keyId;
//   final String deviceId;
//   final String deviceType; // ANDROID/IPHONE/RUNNING
//   final String brandModel;
//   final String customerName;
//   final List<String> productImage;
//
//   // final String productImage;
//   final String mobile;
//   final String? image;
//   final String imei;
//   final String loanProvider;
//   final String emiStatus;
//   final String status; // PENDING etc
//   final DateTime? createdAt;
//   final String? imei2;          // ✅ NEW
//   final String? signatureImage; // ✅ NEW
//
//   DeviceItem({
//     required this.keyId,
//     required this.deviceId,
//     required this.deviceType,
//     required this.brandModel,
//     required this.productImage,
//     required this.customerName,
//     required this.mobile,
//     required this.image,
//     required this.imei,
//     required this.loanProvider,
//     required this.emiStatus,
//     required this.status,
//     required this.createdAt,
//     this.imei2, // ✅ OPTIONAL
//     this.signatureImage, // ✅ OPTIONAL
//
//   });
//
//   factory DeviceItem.fromJson(Map<String, dynamic> json) {
//     return DeviceItem(
//       keyId: (json["keyId"] ?? "").toString(),
//       deviceId: (json["deviceId"] ?? "").toString(),
//       deviceType: (json["deviceType"] ?? "").toString(),
//       brandModel: (json["brandModel"] ?? "").toString(),
//       // productImage: (json["productImage"] ?? "").toString(),
//       productImage: (json["productImage"] as List? ?? [])
//           .map((e) => e.toString())
//           .toList(),
//       customerName: (json["customerName"] ?? "").toString(),
//       mobile: (json["mobile"] ?? "").toString(),
//       image: json["image"]?.toString(),
//       imei: (json["imei"] ?? "").toString(),
//       loanProvider: (json["loanProvider"] ?? "").toString(),
//       emiStatus: (json["emiStatus"] ?? "").toString(),
//       status: (json["status"] ?? "").toString(),
//       createdAt: json["createdAt"] == null
//           ? null
//           : DateTime.tryParse(json["createdAt"].toString()),
//     );
//   }
// }

// class DeviceItem {
//   final String keyId;
//   final String deviceId;
//   final String deviceType;
//   final String brandModel;
//   final String customerName;
//   final List<String> productImage;
//
//   final String mobile;
//   final String? image;
//   final String imei;
//   final String loanProvider;
//   final String emiStatus;
//   final String status;
//   final DateTime? createdAt;
//
//   /// ✅ NEW
//   final String? imei2;
//   final String? signatureImage;
//
//   /// 🔥 EMI FIELDS (NEW)
//   final String? productPrice;
//   final String? downPayment;
//   final String? balancePayment;
//   final String? tenure;
//   final String? interest;
//   final String? emiAmount;
//
//   DeviceItem({
//     required this.keyId,
//     required this.deviceId,
//     required this.deviceType,
//     required this.brandModel,
//     required this.productImage,
//     required this.customerName,
//     required this.mobile,
//     required this.image,
//     required this.imei,
//     required this.loanProvider,
//     required this.emiStatus,
//     required this.status,
//     required this.createdAt,
//
//     this.imei2,
//     this.signatureImage,
//
//     /// ✅ EMI OPTIONAL (SAFE)
//     this.productPrice,
//     this.downPayment,
//     this.balancePayment,
//     this.tenure,
//     this.interest,
//     this.emiAmount,
//   });
//
//   factory DeviceItem.fromJson(Map<String, dynamic> json) {
//     final emi = json["emi"]; // ✅ SAFE EMI
//
//     return DeviceItem(
//       keyId: (json["keyId"] ?? "").toString(),
//       deviceId: (json["deviceId"] ?? "").toString(),
//       deviceType: (json["deviceType"] ?? "").toString(),
//       brandModel: (json["brandModel"] ?? "").toString(),
//
//       /// ✅ IMAGE LIST
//       productImage: (json["productImage"] as List? ?? [])
//           .map((e) => e.toString())
//           .toList(),
//
//       customerName: (json["customerName"] ?? "").toString(),
//       mobile: (json["mobile"] ?? "").toString(),
//
//       /// ✅ PROFILE IMAGE
//       image: json["image"]?.toString(),
//
//       /// ✅ IMEI FIX
//       imei: (json["imei"] ?? json["imei1"] ?? "").toString(),
//
//       /// 🔥 NEW
//       imei2: json["imei2"]?.toString(),
//
//       signatureImage: json["signature"]?.toString(),
//
//       loanProvider: (json["loanProvider"] ?? "").toString(),
//       emiStatus: (json["emiStatus"] ?? "").toString(),
//       status: (json["status"] ?? "").toString(),
//
//       createdAt: json["createdAt"] == null
//           ? null
//           : DateTime.tryParse(json["createdAt"].toString()),
//
//       /// 🔥 EMI MAPPING (MOST IMPORTANT)
//       productPrice: emi?["total_amount"]?.toString(),
//       downPayment: emi?["down_payment"]?.toString(),
//       balancePayment: emi?["loan_amount"]?.toString(),
//       tenure: emi?["tenure_months"]?.toString(),
//       interest: emi?["interest_rate"]?.toString(),
//       emiAmount: emi?["emi_amount"]?.toString(),
//     );
//   }
// }
class DeviceItem {
  final String keyId;
  final String deviceId;
  final String deviceType;
  final String brandModel;
  final String customerName;
  final List<String> productImage;

  final String mobile;
  final String? image;
  final String imei;
  final String loanProvider;
  final String emiStatus;
  final String status;
  final DateTime? createdAt;

  /// ✅ MATCHED WITH DETAIL API
  final String? imei2;
  final String? signatureImage;

  /// ✅ EMI (MATCHED)
  final String? productPrice;
  final String? downPayment;
  final String? balancePayment;
  final String? tenure;
  final String? interest;
  final String? emiAmount;

  DeviceItem({
    required this.keyId,
    required this.deviceId,
    required this.deviceType,
    required this.brandModel,
    required this.productImage,
    required this.customerName,
    required this.mobile,
    required this.image,
    required this.imei,
    required this.loanProvider,
    required this.emiStatus,
    required this.status,
    required this.createdAt,

    this.imei2,
    this.signatureImage,

    this.productPrice,
    this.downPayment,
    this.balancePayment,
    this.tenure,
    this.interest,
    this.emiAmount,
  });

  factory DeviceItem.fromJson(Map<String, dynamic> json) {
    final emi = json["emi"];

    return DeviceItem(
      /// ✅ ID FIX (IMPORTANT)
      keyId: (json["userId"] ?? json["keyId"] ?? "").toString(),
      deviceId: (json["_id"] ?? json["deviceId"] ?? "").toString(),

      deviceType: (json["deviceType"] ?? "").toString(),
      brandModel: (json["brandModel"] ?? "").toString(),

      /// ✅ IMAGE FIX (DETAIL MATCH)
      productImage: (json["productImage"] as List? ?? [])
          .map((e) => e.toString())
          .toList(),

      image: json["profileImage"]?.toString(),

      customerName: (json["name"] ?? json["customerName"] ?? "").toString(),
      mobile: (json["phone"] ?? json["mobile"] ?? "").toString(),

      /// ✅ IMEI FIX (MOST IMPORTANT)
      imei: (json["imei1"] ?? json["imei"] ?? "").toString(),
      imei2: json["imei2"]?.toString(),

      /// ✅ SIGNATURE FIX
      signatureImage: json["signature"]?.toString(),

      /// ✅ LOAN FIX
      loanProvider: (json["loanBy"] ?? json["loanProvider"] ?? "").toString(),

      emiStatus: (json["emiStatus"] ?? "").toString(),
      status: (json["status"] ?? "").toString(),

      createdAt: json["createdAt"] == null
          ? null
          : DateTime.tryParse(json["createdAt"].toString()),

      /// 🔥 EMI EXACT MATCH (NO MISMATCH)
      productPrice: emi?["total_amount"]?.toString(),
      downPayment: emi?["down_payment"]?.toString(),
      balancePayment: emi?["loan_amount"]?.toString(),
      tenure: emi?["tenure_months"]?.toString(),
      interest: emi?["interest_rate"]?.toString(),
      emiAmount: emi?["emi_amount"]?.toString(),
    );
  }
}