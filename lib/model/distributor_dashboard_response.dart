class DistributorDashboardResponse {
  final int status;
  final DistributorDashboardData? data;

  DistributorDashboardResponse({
    required this.status,
    this.data,
  });

  factory DistributorDashboardResponse.fromJson(Map<String, dynamic> json) {
    return DistributorDashboardResponse(
      status: (json["status"] ?? 0) is int ? json["status"] : int.tryParse("${json["status"]}") ?? 0,
      data: json["data"] == null ? null : DistributorDashboardData.fromJson(json["data"]),
    );
  }
}

class DistributorDashboardData {
  final int keyBalance;
  final int usedKey;
  final int totalRetailers;
  final int activeRetailers;
  final int activeActivations;
  final int todaysRetailers;

  DistributorDashboardData({
    required this.keyBalance,
    required this.usedKey,
    required this.totalRetailers,
    required this.activeRetailers,
    required this.activeActivations,
    required this.todaysRetailers,
  });

  factory DistributorDashboardData.fromJson(Map<String, dynamic> json) {
    int _toInt(dynamic v) => v == null ? 0 : (v is int ? v : int.tryParse("$v") ?? 0);

    return DistributorDashboardData(
      keyBalance: _toInt(json["keyBalance"]),
      usedKey: _toInt(json["usedKey"]),
      totalRetailers: _toInt(json["totalRetailers"]),
      activeRetailers: _toInt(json["activeRetailers"]),
      activeActivations: _toInt(json["activeActivations"]),
      todaysRetailers: _toInt(json["todaysRetailers"]),
    );
  }
}
