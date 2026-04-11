class KeyDetailsResponse {
  final int status;
  final KeyDetailsData? data;

  KeyDetailsResponse({required this.status, required this.data});

  factory KeyDetailsResponse.fromJson(Map<String, dynamic> json) {
    return KeyDetailsResponse(
      status: (json["status"] ?? 0) as int,
      data: json["data"] == null ? null : KeyDetailsData.fromJson(json["data"]),
    );
  }
}

class KeyDetailsData {
  final KeyInfo? keyInfo;
  final CustomerInfo? customer;
  final DeviceInfo? device;
  final DocumentsInfo? documents; // ✅ ADD
  final LoanInfo? loan;
  final EmiSection? emi;

  KeyDetailsData({
    this.keyInfo,
    this.customer,
    this.device,
    this.documents, // ✅ ADD
    this.loan,
    this.emi,
  });

  factory KeyDetailsData.fromJson(Map<String, dynamic> json) {
    return KeyDetailsData(
      keyInfo: json["keyInfo"] == null ? null : KeyInfo.fromJson(json["keyInfo"]),
      customer: json["customer"] == null ? null : CustomerInfo.fromJson(json["customer"]),
      device: json["device"] == null ? null : DeviceInfo.fromJson(json["device"]),
      documents: json["documents"] == null ? null : DocumentsInfo.fromJson(json["documents"]), // ✅ ADD
      loan: json["loan"] == null ? null : LoanInfo.fromJson(json["loan"]),
      emi: json["emi"] == null ? null : EmiSection.fromJson(json["emi"]),
    );
  }
}

// class KeyInfo {
//   final String id;            // 🔹 Mongo _id
//   final String keyId;
//   final String status; // RUNNING etc
//   final String paymentType; // EMI/ECS/E_MANDATE/WITHOUT_EMI
//   final String loanProvider;
//
//   KeyInfo({
//     required this.id,
//
//     required this.keyId,
//     required this.status,
//     required this.paymentType,
//     required this.loanProvider,
//   });
//
//   factory KeyInfo.fromJson(Map<String, dynamic> json) {
//     return KeyInfo(
//       id: (json["_id"] ?? "").toString(),          // ✅ handle _id safely
//       keyId: (json["keyId"] ?? "").toString(),
//       status: (json["status"] ?? "").toString(),
//       paymentType: (json["paymentType"] ?? "").toString(),
//       loanProvider: (json["loanProvider"] ?? "").toString(),
//     );
//   }
// }
class KeyInfo {
  final String id;            // ✅ Mongo _id
  final String keyId;
  final String status;
  final String paymentType;
  final String loanProvider;

  KeyInfo({
    this.id = "", // ✅ default safe
    required this.keyId,
    required this.status,
    required this.paymentType,
    required this.loanProvider,
  });

  factory KeyInfo.fromJson(Map<String, dynamic> json) {
    return KeyInfo(
      id: (json["_id"] ?? "").toString(),
      keyId: (json["keyId"] ?? "").toString(),
      status: (json["status"] ?? "").toString(),
      paymentType: (json["paymentType"] ?? "").toString(),
      loanProvider: (json["loanProvider"] ?? "").toString(),
    );
  }
}

class DocumentsInfo {
  /// current field
  final String purchaseAgreement;

  /// future-safe: any extra docs (pdf/doc/image/unknown keys)
  /// Example: {"purchaseAgreement": "...", "aadhaarPdf": "...", "panDoc": "..."}
  final Map<String, String> extra;

  DocumentsInfo({
    this.purchaseAgreement = "",
    this.extra = const {},
  });

  factory DocumentsInfo.fromJson(Map<String, dynamic> json) {
    // convert all values to string safely (ignore null)
    final map = <String, String>{};
    json.forEach((k, v) {
      if (v != null) map[k.toString()] = v.toString();
    });

    return DocumentsInfo(
      purchaseAgreement: (json["purchaseAgreement"] ?? "").toString(),
      extra: map, // ✅ keeps everything (pdf/doc/image etc)
    );
  }

  /// ✅ helper: by key get url
  String url(String key) => extra[key] ?? "";

  /// ✅ helper: get extension like pdf/doc/png
  String ext(String key) {
    final u = url(key).toLowerCase();
    final clean = u.split('?').first; // remove query
    final parts = clean.split('.');
    return parts.length > 1 ? parts.last : "";
  }

  bool isPdf(String key) => ext(key) == "pdf";
  bool isDoc(String key) => ext(key) == "doc" || ext(key) == "docx";
  bool isImage(String key) => ["png", "jpg", "jpeg", "webp"].contains(ext(key));
}

class CustomerInfo {
  final String id;
  final String fullName;
  final String phone;
  final String? image;
  final bool status;

  CustomerInfo({
    required this.id,
    required this.fullName,
    required this.phone,
    this.image,
    required this.status,
  });

  factory CustomerInfo.fromJson(Map<String, dynamic> json) {
    return CustomerInfo(
      id: (json["_id"] ?? "").toString(),
      fullName: (json["fullName"] ?? "").toString(),
      phone: (json["phone"] ?? "").toString(),
      image: json["image"]?.toString(),
      status: (json["status"] ?? false) as bool,
    );
  }
}

class DeviceInfo {
  final String brandModel;
  final String status;
  final String imei1;
  final List<String> productImage;
  final String signatureImage;

  DeviceInfo({
    required this.brandModel,
    required this.status,
    required this.imei1,
    required this.productImage,
    required this.signatureImage,
  });

  factory DeviceInfo.fromJson(Map<String, dynamic> json) {
    return DeviceInfo(
      brandModel: (json["brandModel"] ?? "").toString(),
      status: (json["status"] ?? "").toString(),
      imei1: (json["imei1"] ?? "").toString(),
      productImage: (json["productImage"] is List)
          ? (json["productImage"] as List).map((e) => e.toString()).toList()
          : <String>[],
      signatureImage: (json["signatureImage"] ?? "").toString(),
    );
  }
}

class LoanInfo {
  // ✅ existing fields (unchanged)
  final double productPrice;
  final double downPayment;
  final double balancePayment;
  final String emiType; // MONTHLY etc
  final int tenureMonths;
  final double interestRate;
  final double emiAmount;
  final double processingFee;
  final String loanStartDate; // ISO
  final String status; // ACTIVE

  // ✅ added missing fields (optional => no impact)
  final String id; // _id
  final String retailerId;
  final String userId;
  final String deviceId;
  final String createdAt;
  final String updatedAt;
  final int v; // __v

  LoanInfo({
    required this.productPrice,
    required this.downPayment,
    required this.balancePayment,
    required this.emiType,
    required this.tenureMonths,
    required this.interestRate,
    required this.emiAmount,
    required this.processingFee,
    required this.loanStartDate,
    required this.status,

    // ✅ new optional fields
    this.id = "",
    this.retailerId = "",
    this.userId = "",
    this.deviceId = "",
    this.createdAt = "",
    this.updatedAt = "",
    this.v = 0,
  });

  factory LoanInfo.fromJson(Map<String, dynamic> json) {
    double _d(v) => (v is num) ? v.toDouble() : double.tryParse(v.toString()) ?? 0.0;
    int _i(v) => (v is num) ? v.toInt() : int.tryParse(v.toString()) ?? 0;

    return LoanInfo(
      // ✅ existing mapping (unchanged)
      productPrice: _d(json["productPrice"]),
      downPayment: _d(json["downPayment"]),
      balancePayment: _d(json["balancePayment"]),
      emiType: (json["emiType"] ?? "").toString(),
      tenureMonths: _i(json["tenureMonths"]),
      interestRate: _d(json["interestRate"]),
      emiAmount: _d(json["emiAmount"]),
      processingFee: _d(json["processingFee"]),
      loanStartDate: (json["loanStartDate"] ?? "").toString(),
      status: (json["status"] ?? "").toString(),

      // ✅ new mapping
      id: (json["_id"] ?? "").toString(),
      retailerId: (json["retailerId"] ?? "").toString(),
      userId: (json["userId"] ?? "").toString(),
      deviceId: (json["deviceId"] ?? "").toString(),
      createdAt: (json["createdAt"] ?? "").toString(),
      updatedAt: (json["updatedAt"] ?? "").toString(),
      v: _i(json["__v"]),
    );
  }
}

class EmiSection {
  final List<EmiItem> list;
  final EmiProgress? progress;

  EmiSection({required this.list, this.progress});

  factory EmiSection.fromJson(Map<String, dynamic> json) {
    return EmiSection(
      list: (json["list"] is List)
          ? (json["list"] as List).map((e) => EmiItem.fromJson(e)).toList()
          : <EmiItem>[],
      progress: json["progress"] == null ? null : EmiProgress.fromJson(json["progress"]),
    );
  }
}

class EmiItem {
  // ✅ existing fields (unchanged)
  final String id;
  final String dueDate; // ISO
  final double amount;
  final double overdueAmount;
  final String status; // PENDING/PAID etc

  // ✅ added missing fields (optional => no impact)
  final String loanId;
  final String createdAt;
  final String updatedAt;
  final int v; // __v

  EmiItem({
    required this.id,
    required this.dueDate,
    required this.amount,
    required this.overdueAmount,
    required this.status,

    // ✅ new optional fields
    this.loanId = "",
    this.createdAt = "",
    this.updatedAt = "",
    this.v = 0,
  });

  factory EmiItem.fromJson(Map<String, dynamic> json) {
    double _d(v) => (v is num) ? v.toDouble() : double.tryParse(v.toString()) ?? 0.0;
    int _i(v) => (v is num) ? v.toInt() : int.tryParse(v.toString()) ?? 0;

    return EmiItem(
      // ✅ existing mapping (unchanged)
      id: (json["_id"] ?? "").toString(),
      dueDate: (json["dueDate"] ?? "").toString(),
      amount: _d(json["amount"]),
      overdueAmount: _d(json["overdueAmount"]),
      status: (json["status"] ?? "").toString(),

      // ✅ new mapping
      loanId: (json["loanId"] ?? "").toString(),
      createdAt: (json["createdAt"] ?? "").toString(),
      updatedAt: (json["updatedAt"] ?? "").toString(),
      v: _i(json["__v"]),
    );
  }
}

class EmiProgress {
  final int totalEmi;
  final int paidEmi;
  final double percentage;

  EmiProgress({required this.totalEmi, required this.paidEmi, required this.percentage});

  factory EmiProgress.fromJson(Map<String, dynamic> json) {
    int _i(v) => (v is num) ? v.toInt() : int.tryParse(v.toString()) ?? 0;
    double _d(v) => (v is num) ? v.toDouble() : double.tryParse(v.toString()) ?? 0.0;

    return EmiProgress(
      totalEmi: _i(json["totalEmi"]),
      paidEmi: _i(json["paidEmi"]),
      percentage: _d(json["percentage"]),
    );
  }
}
