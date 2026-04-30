class DashboardResponse {
  bool? success;
  String? message;
  DashboardData? data;

  DashboardResponse({this.success, this.message, this.data});

  DashboardResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'] == true;
    message = json['message']?.toString();
    data = json['data'] != null ? DashboardData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class DashboardData {
  DashUser? user;
  DashWallet? wallet;
  DashKeys? keys;
  DashCustomers? customers;
  DashVendorStats? vendorStats;

  List<dynamic>? banners; // empty array in your response
  DashAppUpdate? appUpdate;
  DashQr? homeQR;
  DashQr? qrCodeRecord;


  DashboardData({
    this.user,
    this.wallet,
    this.keys,
    this.customers,
    this.vendorStats,
    this.banners,
    this.appUpdate,
    this.homeQR,
    this.qrCodeRecord,
  });

  // DashboardData.fromJson(Map<String, dynamic> json) {
  //   print("🔥 vendorStats JSON: ${json['vendorStats']}");
  //
  //   user = json['user'] != null ? DashUser.fromJson(json['user']) : null;
  //   wallet = json['wallet'] != null ? DashWallet.fromJson(json['wallet']) : null;
  //   keys = json['keys'] != null ? DashKeys.fromJson(json['keys']) : null;
  //   customers =
  //   json['customers'] != null ? DashCustomers.fromJson(json['customers']) : null;
  //
  //   // vendorStats = json['vendorStats'] != null
  //   //     ? DashVendorStats.fromJson(json['vendorStats'])
  //   //     : null;
  //
  //   final vs = json['vendorStats'] ?? json['vendor_stats'];
  //
  //   if (vs != null && vs is Map<String, dynamic>) {
  //     vendorStats = DashVendorStats.fromJson(vs);
  //   } else {
  //     vendorStats = null;
  //   }
  //   banners = json['banners'] is List ? (json['banners'] as List) : [];
  //   appUpdate =
  //   json['appUpdate'] != null ? DashAppUpdate.fromJson(json['appUpdate']) : null;
  //
  //   homeQR = json['homeQR'] != null ? DashQr.fromJson(json['homeQR']) : null;
  //   qrCodeRecord =
  //   json['qrCodeRecord'] != null ? DashQr.fromJson(json['qrCodeRecord']) : null;
  // }
  //
  // Map<String, dynamic> toJson() => {
  //   "user": user?.toJson(),
  //   "wallet": wallet?.toJson(),
  //   "keys": keys?.toJson(),
  //   "customers": customers?.toJson(),
  //   "banners": banners ?? [],
  //   "appUpdate": appUpdate?.toJson(),
  //   "homeQR": homeQR?.toJson(),
  //   "qrCodeRecord": qrCodeRecord?.toJson(),
  //   "vendorStats": vendorStats != null ? {
  //     "summary": {
  //       "total": vendorStats?.summary?.total,
  //       "active": vendorStats?.summary?.active,
  //       "inactive": vendorStats?.summary?.inactive,
  //       "deleted": vendorStats?.summary?.deleted,
  //     }
  //   } : null,
  // };
  DashboardData.fromJson(Map<String, dynamic> json) {
    // 🔥 DEBUG (important)
    print("🔥 FULL JSON: $json");
    print("🔥 vendorStats JSON: ${json['vendorStats']}");

    user = json['user'] != null ? DashUser.fromJson(json['user']) : null;
    wallet = json['wallet'] != null ? DashWallet.fromJson(json['wallet']) : null;
    keys = json['keys'] != null ? DashKeys.fromJson(json['keys']) : null;

    // ✅ CUSTOMERS
    customers = json['customers'] != null
        ? DashCustomers.fromJson(json['customers'])
        : null;

    // ✅ VENDOR STATS (SAFE)
    final vs = json['vendorStats'] ?? json['vendor_stats'];

    if (vs is Map<String, dynamic>) {
      vendorStats = DashVendorStats.fromJson(vs);
    } else {
      vendorStats = null;
    }

    // ✅ BANNERS
    banners = json['banners'] is List ? (json['banners'] as List) : [];

    // ✅ APP UPDATE
    appUpdate = json['appUpdate'] != null
        ? DashAppUpdate.fromJson(json['appUpdate'])
        : null;

    // ✅ QR
    homeQR = json['homeQR'] != null
        ? DashQr.fromJson(json['homeQR'])
        : null;

    qrCodeRecord = json['qrCodeRecord'] != null
        ? DashQr.fromJson(json['qrCodeRecord'])
        : null;

    // 🔥 FINAL DEBUG
    print("✅ Parsed vendorStats: ${vendorStats?.summary?.total}");
  }
  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "wallet": wallet?.toJson(),
    "keys": keys?.toJson(),
    "customers": customers?.toJson(),
    "vendorStats": vendorStats != null
        ? {
      "summary": {
        "total": vendorStats?.summary?.total,
        "active": vendorStats?.summary?.active,
        "inactive": vendorStats?.summary?.inactive,
        "deleted": vendorStats?.summary?.deleted,
      }
    }
        : null,
    "banners": banners ?? [],
    "appUpdate": appUpdate?.toJson(),
    "homeQR": homeQR?.toJson(),
    "qrCodeRecord": qrCodeRecord?.toJson(),
  };
}

class DashUser {
  String? id;
  String? name;
  String? type;
  String? email;
  String? userType;
  String? role;
  String? company;
  String? phone;
  String? city;
  String? state;
  String? status;

  String? profileImage; // only URL store

  DashUser.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    name = json['name']?.toString();
    type = json['type']?.toString();
    email = json['email']?.toString();
    userType = json['userType']?.toString();
    role = json['role']?.toString();
    company = json['company']?.toString();
    phone = json['phone']?.toString();
    city = json['city']?.toString();
    state = json['state']?.toString();
    status = json['status']?.toString();

    // ✅ SAFE PARSE (important fix)
    final imageObj = json['profileImage'];
    if (imageObj is Map && imageObj['url'] != null) {
      profileImage = imageObj['url'].toString();
    } else {
      profileImage = null;
    }
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "type": type,
    "email": email,
    "userType": userType,
    "role": role,
    "company": company,
    "phone": phone,
    "city": city,
    "state": state,
    "status": status,

    // ❌ REMOVE THIS (गलत structure)
    // "profileImage": profileImage,
  };
}
class DashWallet {
  String? id;
  int? balance;
  String? currency;
  int? totalCredits;
  int? totalDebits;
  String? status;
  String? lastTransactionAt;

  DashWallet.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    balance = _toInt(json['balance']);
    currency = json['currency']?.toString();
    totalCredits = _toInt(json['totalCredits']);
    totalDebits = _toInt(json['totalDebits']);
    status = json['status']?.toString();
    lastTransactionAt = json['lastTransactionAt']?.toString();
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "balance": balance,
    "currency": currency,
    "totalCredits": totalCredits,
    "totalDebits": totalDebits,
    "status": status,
    "lastTransactionAt": lastTransactionAt,
  };
}

class DashKeys {
  int? totalKeys;
  int? activeKeys;
  int? usedKeys;
  int? expiredKeys;
  int? totalUsageLimit;
  int? totalUsed;
  int? totalBalance;
  int? usagePercentage;
  bool? canAddCustomer;

  DashKeys.fromJson(Map<String, dynamic> json) {
    totalKeys = _toInt(json['totalKeys']);
    activeKeys = _toInt(json['activeKeys']);
    usedKeys = _toInt(json['usedKeys']);
    expiredKeys = _toInt(json['expiredKeys']);
    totalUsageLimit = _toInt(json['totalUsageLimit']);
    totalUsed = _toInt(json['totalUsed']);
    totalBalance = _toInt(json['totalBalance']);
    usagePercentage = _toInt(json['usagePercentage']);
    canAddCustomer = json['canAddCustomer'] == true;
  }

  Map<String, dynamic> toJson() => {
    "totalKeys": totalKeys,
    "activeKeys": activeKeys,
    "usedKeys": usedKeys,
    "expiredKeys": expiredKeys,
    "totalUsageLimit": totalUsageLimit,
    "totalUsed": totalUsed,
    "totalBalance": totalBalance,
    "usagePercentage": usagePercentage,
    "canAddCustomer": canAddCustomer,
  };
}

// class DashCustomers {
//   int? total;
//   int? active;
//   int? inactive;
//   int? linked;
//   int? unlinked;
//   int? newToday;
//   int? newThisMonth;
//   DashKyc? kyc;
//   DashEmi? emi;
//
//   DashCustomers.fromJson(Map<String, dynamic> json) {
//     total = _toInt(json['total']);
//     active = _toInt(json['active']);
//     inactive = _toInt(json['inactive']);
//     linked = _toInt(json['linked']);
//     unlinked = _toInt(json['unlinked']);
//     newToday = _toInt(json['new_today']);
//     newThisMonth = _toInt(json['new_this_month']);
//     kyc = json['kyc'] != null ? DashKyc.fromJson(json['kyc']) : null;
//     emi = json['emi'] != null ? DashEmi.fromJson(json['emi']) : null;
//   }
//
//   Map<String, dynamic> toJson() => {
//     "total": total,
//     "active": active,
//     "inactive": inactive,
//     "linked": linked,
//     "unlinked": unlinked,
//     "new_today": newToday,
//     "new_this_month": newThisMonth,
//     "kyc": kyc?.toJson(),
//     "emi": emi?.toJson(),
//   };
// }

class DashCustomers {
  DashCustomerSelf? self;

  int? total;
  int? active;
  int? inactive;
  int? linked;
  int? unlinked;
  int? newToday;
  int? newThisMonth;
  DashKyc? kyc;
  DashEmi? emi;

  DashCustomers.fromJson(Map<String, dynamic> json) {
    self = json['self'] != null
        ? DashCustomerSelf.fromJson(json['self'])
        : null;

    total = _toInt(json['total']);
    active = _toInt(json['active']);
    inactive = _toInt(json['inactive']);
    linked = _toInt(json['linked']);
    unlinked = _toInt(json['unlinked']);
    newToday = _toInt(json['new_today']);
    newThisMonth = _toInt(json['new_this_month']);
    kyc = json['kyc'] != null ? DashKyc.fromJson(json['kyc']) : null;
    emi = json['emi'] != null ? DashEmi.fromJson(json['emi']) : null;
  }

  // ✅ ADD THIS (FIX)
  Map<String, dynamic> toJson() => {
    "self": self != null
        ? {
      "total": self?.total,
      "active": self?.active,
      "pending": self?.pending,
      "deleted": self?.deleted,
    }
        : null,
    "total": total,
    "active": active,
    "inactive": inactive,
    "linked": linked,
    "unlinked": unlinked,
    "new_today": newToday,
    "new_this_month": newThisMonth,
    "kyc": kyc?.toJson(),
    "emi": emi?.toJson(),
  };
}

class DashCustomerSelf {
  int? total;
  int? active;
  int? pending;
  int? deleted;
  int? lock;
  DashCustomerNewToday? newToday; // ✅ ADD THIS

  DashCustomerSelf.fromJson(Map<String, dynamic> json) {
    total = _toInt(json['total']);
    active = _toInt(json['active']);
    pending = _toInt(json['pending']);
    deleted = _toInt(json['deleted']);
    lock = _toInt(json['lock']);
    // ✅ FIX HERE
    newToday = json['new_today'] != null
        ? DashCustomerNewToday.fromJson(json['new_today'])
        : null;

  }
}

class DashCustomerNewToday {
  int? total;
  int? active;
  int? pending;
  int? lock;
  int? remove;

  DashCustomerNewToday.fromJson(Map<String, dynamic> json) {
    total = _toInt(json['total']);
    active = _toInt(json['active']);
    pending = _toInt(json['pending']);
    lock = _toInt(json['lock']);
    remove = _toInt(json['remove']);
  }
}
class DashKyc {
  int? pending;
  int? verified;
  int? rejected;

  DashKyc.fromJson(Map<String, dynamic> json) {
    pending = _toInt(json['pending']);
    verified = _toInt(json['verified']);
    rejected = _toInt(json['rejected']);
  }

  Map<String, dynamic> toJson() => {
    "pending": pending,
    "verified": verified,
    "rejected": rejected,
  };
}

class DashEmi {
  int? active;
  int? completed;
  int? defaulted;
  int? overdue;

  DashEmi.fromJson(Map<String, dynamic> json) {
    active = _toInt(json['active']);
    completed = _toInt(json['completed']);
    defaulted = _toInt(json['defaulted']);
    overdue = _toInt(json['overdue']);
  }

  Map<String, dynamic> toJson() => {
    "active": active,
    "completed": completed,
    "defaulted": defaulted,
    "overdue": overdue,
  };
}

class DashAppUpdate {
  String? versionCode;
  String? versionName;
  String? fileName;
  int? fileSize;
  String? downloadUrl;
  String? changelog;
  bool? forceUpdate;
  String? uploadDate;
  String? packageName;

  DashAppUpdate.fromJson(Map<String, dynamic> json) {
    versionCode = json['versionCode']?.toString();
    versionName = json['versionName']?.toString();
    fileName = json['fileName']?.toString();
    fileSize = _toInt(json['fileSize']);
    downloadUrl = json['downloadUrl']?.toString();
    changelog = json['changelog']?.toString();
    forceUpdate = json['forceUpdate'] == true;
    uploadDate = json['uploadDate']?.toString();
    packageName = json['packageName']?.toString();
  }

  Map<String, dynamic> toJson() => {
    "versionCode": versionCode,
    "versionName": versionName,
    "fileName": fileName,
    "fileSize": fileSize,
    "downloadUrl": downloadUrl,
    "changelog": changelog,
    "forceUpdate": forceUpdate,
    "uploadDate": uploadDate,
    "packageName": packageName,
  };
}

class DashVendorStats {
  DashVendorSummary? summary;
  DashVendorByType? byType; // ✅ NEW

  DashVendorStats.fromJson(Map<String, dynamic> json) {
    summary = json['summary'] != null
        ? DashVendorSummary.fromJson(json['summary'])
        : null;
    // ✅ SAFE PARSE (NO IMPACT)
    byType = json['by_type'] != null
        ? DashVendorByType.fromJson(json['by_type'])
        : null;
  }
}


class DashVendorByType {
  DashVendorType? distributor;
  DashVendorType? subDistributor;
  DashVendorType? vendor;
  DashVendorType? retailer;

  DashVendorByType.fromJson(Map<String, dynamic> json) {
    distributor = json['distributor'] != null
        ? DashVendorType.fromJson(json['distributor'])
        : null;

    subDistributor = json['sub_distributor'] != null
        ? DashVendorType.fromJson(json['sub_distributor'])
        : null;

    vendor = json['vendor'] != null
        ? DashVendorType.fromJson(json['vendor'])
        : null;

    retailer = json['retailer'] != null
        ? DashVendorType.fromJson(json['retailer'])
        : null;
  }
}
class DashVendorType {
  int? total;
  int? active;
  int? inactive;
  int? deleted;

  DashVendorType.fromJson(Map<String, dynamic> json) {
    total = _toInt(json['total']);
    active = _toInt(json['active']);
    inactive = _toInt(json['inactive']);
    deleted = _toInt(json['deleted']);
  }
}
class DashVendorSummary {
  int? total;
  int? active;
  int? inactive;
  int? deleted;

  DashVendorSummary.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    active = json['active'];
    inactive = json['inactive'];
    deleted = json['deleted'];
  }
}

class DashQr {
  String? id;
  String? token;
  String? companyName;
  String? qrLabel;
  String? description;
  String? qrImageUrl;
  String? enrollmentLink;
  String? status;
  String? expiresAt;
  String? createdAt;

  DashQr.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    token = json['token']?.toString();
    companyName = (json['company_name'] ?? json['companyName'])?.toString();
    qrLabel = (json['qr_label'] ?? json['qrLabel'])?.toString();
    description = json['description']?.toString();
    qrImageUrl = (json['qr_image_url'] ?? json['qrImageUrl'])?.toString();
    enrollmentLink = (json['enrollment_link'] ?? json['enrollmentLink'])?.toString();
    status = json['status']?.toString();
    expiresAt = (json['expires_at'] ?? json['expiresAt'])?.toString();
    createdAt = json['createdAt']?.toString();
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "token": token,
    "company_name": companyName,
    "qr_label": qrLabel,
    "description": description,
    "qr_image_url": qrImageUrl,
    "enrollment_link": enrollmentLink,
    "status": status,
    "expires_at": expiresAt,
    "createdAt": createdAt,
  };
}

/// safe int parser
int _toInt(dynamic v) {
  if (v == null) return 0;
  if (v is int) return v;
  if (v is double) return v.toInt();
  return int.tryParse(v.toString()) ?? 0;
}