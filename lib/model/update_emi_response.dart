class UpdateEmiResponse {
  final int status;
  final String message;
  final UpdateEmiData? data;

  UpdateEmiResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory UpdateEmiResponse.fromJson(Map<String, dynamic> json) {
    return UpdateEmiResponse(
      status: (json["status"] ?? 0) as int,
      message: (json["message"] ?? "").toString(),
      data: json["data"] == null ? null : UpdateEmiData.fromJson(json["data"]),
    );
  }
}

class UpdateEmiData {
  final String emiId;
  final String status;
  final String paymentMode;
  final String paidAt;
  final double overdueAmount;

  UpdateEmiData({
    required this.emiId,
    required this.status,
    required this.paymentMode,
    required this.paidAt,
    required this.overdueAmount,
  });

  factory UpdateEmiData.fromJson(Map<String, dynamic> json) {
    double _d(v) => (v is num) ? v.toDouble() : double.tryParse(v.toString()) ?? 0.0;

    return UpdateEmiData(
      emiId: (json["emiId"] ?? "").toString(),
      status: (json["status"] ?? "").toString(),
      paymentMode: (json["paymentMode"] ?? "").toString(),
      paidAt: (json["paidAt"] ?? "").toString(),
      overdueAmount: _d(json["overdueAmount"]),
    );
  }
}
