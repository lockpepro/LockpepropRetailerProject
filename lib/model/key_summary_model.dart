class KeySummaryResponse {
  final int status;
  final KeySummaryData? data;

  KeySummaryResponse({required this.status, this.data});

  factory KeySummaryResponse.fromJson(Map<String, dynamic> json) {
    return KeySummaryResponse(
      status: (json["status"] is int) ? json["status"] : 0,
      data: json["data"] is Map<String, dynamic>
          ? KeySummaryData.fromJson(json["data"])
          : null,
    );
  }
}

// class KeySummaryData {
//   final int totalKey;
//   final int newKey;
//   final KeyStats total;
//   final int runningKey;
//   final KeyStats running;
//   final int androidAvailable;
//   final int iphoneAvailable;
//   final KeyStats iphone;
//   final int loanZoneKey;
//   final int eMandate;
//
//   KeySummaryData({
//     required this.totalKey,
//     required this.newKey,
//     required this.total,
//     required this.runningKey,
//     required this.running,
//     required this.androidAvailable,
//     required this.iphoneAvailable,
//     required this.iphone,
//     required this.loanZoneKey,
//     required this.eMandate,
//   });
//
//   factory KeySummaryData.fromJson(Map<String, dynamic> json) {
//     int _toInt(dynamic v) {
//       if (v == null) return 0;
//       if (v is int) return v;
//       if (v is double) return v.toInt();
//       return int.tryParse(v.toString()) ?? 0;
//     }
//
//     return KeySummaryData(
//       totalKey: _toInt(json["totalKey"]),
//       newKey: _toInt(json["newKey"]),
//       total: json["total"] is Map<String, dynamic>
//           ? KeyStats.fromJson(json["total"])
//           : KeyStats.empty(),
//       runningKey: _toInt(json["runningKey"]),
//       running: json["running"] is Map<String, dynamic>
//           ? KeyStats.fromJson(json["running"])
//           : KeyStats.empty(),
//       androidAvailable: _toInt(json["androidAvailable"]),
//       iphoneAvailable: _toInt(json["iphoneAvailable"]),
//       iphone: json["iphone"] is Map<String, dynamic>
//           ? KeyStats.fromJson(json["iphone"])
//           : KeyStats.empty(),
//       loanZoneKey: _toInt(json["loanZoneKey"]),
//       eMandate: _toInt(json["eMandate"]),
//     );
//   }
// }
class KeySummaryData {
  final int totalKey;
  final int newKey;
  final KeyStats total;
  final int runningKey;
  final KeyStats running;
  final int androidAvailable;
  final int iphoneAvailable;
  final KeyStats iphone;
  final int loanZoneKey;
  final int eMandate;

  // ✅ NEW
  final KeyUsageSummary keySummary;

  KeySummaryData({
    required this.totalKey,
    required this.newKey,
    required this.total,
    required this.runningKey,
    required this.running,
    required this.androidAvailable,
    required this.iphoneAvailable,
    required this.iphone,
    required this.loanZoneKey,
    required this.eMandate,
    required this.keySummary, // ✅ NEW
  });

  factory KeySummaryData.fromJson(Map<String, dynamic> json) {
    int _toInt(dynamic v) {
      if (v == null) return 0;
      if (v is int) return v;
      if (v is double) return v.toInt();
      return int.tryParse(v.toString()) ?? 0;
    }

    return KeySummaryData(
      totalKey: _toInt(json["totalKey"]),
      newKey: _toInt(json["newKey"]),
      total: json["total"] is Map<String, dynamic>
          ? KeyStats.fromJson(json["total"])
          : KeyStats.empty(),
      runningKey: _toInt(json["runningKey"]),
      running: json["running"] is Map<String, dynamic>
          ? KeyStats.fromJson(json["running"])
          : KeyStats.empty(),
      androidAvailable: _toInt(json["androidAvailable"]),
      iphoneAvailable: _toInt(json["iphoneAvailable"]),
      iphone: json["iphone"] is Map<String, dynamic>
          ? KeyStats.fromJson(json["iphone"])
          : KeyStats.empty(),
      loanZoneKey: _toInt(json["loanZoneKey"]),
      eMandate: _toInt(json["eMandate"]),

      // ✅ NEW SAFE PARSE
      keySummary: json["keySummary"] is Map<String, dynamic>
          ? KeyUsageSummary.fromJson(json["keySummary"])
          : KeyUsageSummary.empty(),
    );
  }
}

class KeyUsageSummary {
  final int totalKeys;
  final int usedKeys;
  final int availableKeys;
  final int totalUsageLimit;
  final int totalUsed;
  final int totalBalance;
  final int usagePercentage;

  KeyUsageSummary({
    required this.totalKeys,
    required this.usedKeys,
    required this.availableKeys,
    required this.totalUsageLimit,
    required this.totalUsed,
    required this.totalBalance,
    required this.usagePercentage,
  });

  factory KeyUsageSummary.fromJson(Map<String, dynamic> json) {
    int _toInt(dynamic v) {
      if (v == null) return 0;
      return int.tryParse(v.toString()) ?? 0;
    }

    return KeyUsageSummary(
      totalKeys: _toInt(json["totalKeys"]),
      usedKeys: _toInt(json["usedKeys"]),
      availableKeys: _toInt(json["availableKeys"]),
      totalUsageLimit: _toInt(json["totalUsageLimit"]),
      totalUsed: _toInt(json["totalUsed"]),
      totalBalance: _toInt(json["totalBalance"]),
      usagePercentage: _toInt(json["usagePercentage"]),
    );
  }

  factory KeyUsageSummary.empty() => KeyUsageSummary(
    totalKeys: 0,
    usedKeys: 0,
    availableKeys: 0,
    totalUsageLimit: 0,
    totalUsed: 0,
    totalBalance: 0,
    usagePercentage: 0,
  );
}
// class KeyStats {
//   final int active;
//   final int lock;
//   final int remove;
//
//   KeyStats({required this.active, required this.lock, required this.remove});
//
//   factory KeyStats.fromJson(Map<String, dynamic> json) {
//     int _toInt(dynamic v) {
//       if (v == null) return 0;
//       if (v is int) return v;
//       if (v is double) return v.toInt();
//       return int.tryParse(v.toString()) ?? 0;
//     }
//
//     return KeyStats(
//       active: _toInt(json["active"]),
//       lock: _toInt(json["lock"]),
//       remove: _toInt(json["remove"]),
//     );
//   }
//
//   factory KeyStats.empty() => KeyStats(active: 0, lock: 0, remove: 0);
// }

class KeyStats {
  final int active;
  final int lock;
  final int remove;
  final int pending; // ✅ NEW

  KeyStats({
    required this.active,
    required this.lock,
    required this.remove,
    required this.pending,
  });

  factory KeyStats.fromJson(Map<String, dynamic> json) {
    int _toInt(dynamic v) {
      if (v == null) return 0;
      if (v is int) return v;
      if (v is double) return v.toInt();
      return int.tryParse(v.toString()) ?? 0;
    }

    return KeyStats(
      active: _toInt(json["active"]),
      lock: _toInt(json["lock"]),
      remove: _toInt(json["remove"]),
      pending: _toInt(json["pending"]), // ✅ NEW
    );
  }

  factory KeyStats.empty() =>
      KeyStats(active: 0, lock: 0, remove: 0, pending: 0);
}