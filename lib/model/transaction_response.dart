class TxMeta {
  final int total;
  final int page;
  final int limit;

  TxMeta({required this.total, required this.page, required this.limit});

  factory TxMeta.fromJson(Map<String, dynamic> json) {
    return TxMeta(
      total: (json["total"] ?? 0) as int,
      page: (json["page"] ?? 1) as int,
      limit: (json["limit"] ?? 10) as int,
    );
  }
}

class TransactionResponse {
  final int status;
  final TxMeta? meta;

  // ✅ keep raw list here (we will map in controller)
  final List<dynamic> data;

  TransactionResponse({
    required this.status,
    required this.meta,
    required this.data,
  });

  factory TransactionResponse.fromJson(Map<String, dynamic> json) {
    return TransactionResponse(
      status: (json["status"] ?? 0) as int,
      meta: json["meta"] == null ? null : TxMeta.fromJson(json["meta"]),
      data: (json["data"] as List?) ?? <dynamic>[],
    );
  }
}
