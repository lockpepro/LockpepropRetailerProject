class DistributorRetailersResponse {
  final int status;
  final RetailerMeta? meta;
  final List<DistributorRetailerItem> data;

  DistributorRetailersResponse({
    required this.status,
    this.meta,
    required this.data,
  });

  factory DistributorRetailersResponse.fromJson(Map<String, dynamic> json) {
    return DistributorRetailersResponse(
      status: _toInt(json["status"]),
      meta: json["meta"] == null ? null : RetailerMeta.fromJson(_asMap(json["meta"])),
      data: (json["data"] is List)
          ? (json["data"] as List)
          .map((e) => DistributorRetailerItem.fromJson(_asMap(e)))
          .toList()
          : <DistributorRetailerItem>[],
    );
  }
}

class RetailerMeta {
  final int total;
  final int page;
  final int limit;

  RetailerMeta({
    required this.total,
    required this.page,
    required this.limit,
  });

  factory RetailerMeta.fromJson(Map<String, dynamic> json) {
    return RetailerMeta(
      total: _toInt(json["total"]),
      page: _toInt(json["page"]),
      limit: _toInt(json["limit"]),
    );
  }
}

class DistributorRetailerItem {
  final String retailerId;
  final String customId;
  final String retailerCode;
  final String retailerName;
  final String? image;
  final String mobile;
  final String email;
  final String state;
  final num balance;
  final bool status;
  final String createdAt;
  final KeyBalance keyBalance;

  DistributorRetailerItem({
    required this.retailerId,
    required this.customId,
    required this.retailerCode,
    required this.retailerName,
    required this.image,
    required this.mobile,
    required this.email,
    required this.state,
    required this.balance,
    required this.status,
    required this.createdAt,
    required this.keyBalance,
  });

  // factory DistributorRetailerItem.fromJson(Map<String, dynamic> json) {
  //   return DistributorRetailerItem(
  //     retailerId: (json["retailerId"] ?? "").toString(),
  //     retailerCode: (json["retailerCode"] ?? "").toString(),
  //     retailerName: (json["retailerName"] ?? "").toString(),
  //     image: json["image"]?.toString(),
  //     mobile: (json["mobile"] ?? "").toString(),
  //     email: (json["email"] ?? "").toString(),
  //     state: (json["state"] ?? "").toString(),
  //     balance: _toNum(json["balance"]),
  //     status: _toBool(json["status"]),
  //     createdAt: json["createdAt"]?.toString(),
  //
  //   );
  // }
  factory DistributorRetailerItem.fromJson(Map<String, dynamic> json) {
    return DistributorRetailerItem(
      retailerId: (json["_id"] ?? "").toString(), // ✅ FIXED
      customId: (json["customId"] ?? "").toString(), // ✅ FIXED
      retailerCode: (json["_id"] ?? "").toString(), // fallback (no code in API)
      retailerName: (json["name"] ?? "").toString(), // ✅ FIXED
      image: json["profileImage"]?["url"]?.toString(), // ✅ FIXED
      mobile: (json["phone"] ?? "").toString(), // ✅ FIXED
      email: (json["email"] ?? "").toString(),
      state: (json["state"] ?? "").toString(),
      balance: 0, // ❌ not available in this API
      status: _toBool(json["isActive"]), // ✅ FIXED
      createdAt: (json["createdAt"] ??"").toString(),
      keyBalance: KeyBalance.fromJson(json['key_balance'] ?? {}),
    );
  }
}
class KeyBalance {
  final int totalAvailable;

  KeyBalance({required this.totalAvailable});

  factory KeyBalance.fromJson(Map<String, dynamic> json) {
    return KeyBalance(
      totalAvailable: json['total_available'] ?? 0,
    );
  }
}

/* -------- helpers -------- */
int _toInt(dynamic v) => v == null ? 0 : (v is int ? v : int.tryParse("$v") ?? 0);

num _toNum(dynamic v) {
  if (v == null) return 0;
  if (v is num) return v;
  return num.tryParse("$v") ?? 0;
}

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
