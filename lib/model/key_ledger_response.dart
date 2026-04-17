class KeyLedgerResponse {
  final bool success;
  final KeySummary summary;
  final List<KeyLedgerItem> ledger;
  final KeyPagination pagination;

  KeyLedgerResponse({
    required this.success,
    required this.summary,
    required this.ledger,
    required this.pagination,
  });

  factory KeyLedgerResponse.fromJson(Map<String, dynamic> json) {
    return KeyLedgerResponse(
      success: json["success"] ?? false,
      summary: KeySummary.fromJson(json["summary"] ?? {}),
      ledger: (json["ledger"] as List? ?? [])
          .map((e) => KeyLedgerItem.fromJson(e))
          .toList(),
      pagination: KeyPagination.fromJson(json["pagination"] ?? {}),
    );
  }
}

// ---------------- SUMMARY ----------------
class KeySummary {
  final int totalAvailable;
  final int totalUsed;
  final int netBalance;

  KeySummary({
    required this.totalAvailable,
    required this.totalUsed,
    required this.netBalance,
  });

  factory KeySummary.fromJson(Map<String, dynamic> json) {
    return KeySummary(
      totalAvailable: json["totalCredited"] ?? 0,
      totalUsed: json["totalUsed"] ?? 0,
      netBalance: json["netBalance"] ?? 0,
    );
  }
}

// ---------------- PAGINATION ----------------
class KeyPagination {
  final int total;
  final int page;
  final int limit;
  final int pages;

  KeyPagination({
    required this.total,
    required this.page,
    required this.limit,
    required this.pages,
  });

  factory KeyPagination.fromJson(Map<String, dynamic> json) {
    return KeyPagination(
      total: json["total"] ?? 0,
      page: json["page"] ?? 1,
      limit: json["limit"] ?? 10,
      pages: json["pages"] ?? 1,
    );
  }
}

// ---------------- LEDGER ITEM ----------------
class KeyLedgerItem {
  final String type; // credit / debit
  final String description;
  final String createdAt;
  final int totalUnits;
  final String counterpartyName;
  final String? source; // ✅ ADD THIS


  KeyLedgerItem({
    required this.type,
    required this.description,
    required this.createdAt,
    required this.totalUnits,
    required this.counterpartyName,
    this.source, // ✅ ADD

  });

  factory KeyLedgerItem.fromJson(Map<String, dynamic> json) {
    return KeyLedgerItem(
      type: json["type"] ?? "",
      description: json["description"] ?? "",
      createdAt: json["createdAt"] ?? "",
      totalUnits: json["totalUnits"] ?? 0,
      counterpartyName:
      json["counterparty"]?["name"]?.toString() ?? "-",
      source: json['source'], // ✅ MAP HERE

    );
  }
}