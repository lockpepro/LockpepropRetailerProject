class RetailerDashboardResponse {
  int? status;
  RetailerDashboardData? data;

  RetailerDashboardResponse({this.status, this.data});

  RetailerDashboardResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? RetailerDashboardData.fromJson(json['data']) : null;
  }
}

class RetailerDashboardData {
  int totalUsers;
  int activeUsers;
  int keyBalance;
  int upcomingEmi;
  int todayActivation; // optional (agar backend de)

  RetailerDashboardData({
    this.totalUsers = 0,
    this.activeUsers = 0,
    this.keyBalance = 0,
    this.upcomingEmi = 0,
    this.todayActivation = 0,
  });

  RetailerDashboardData.fromJson(Map<String, dynamic> json)
      : totalUsers = _toInt(json['totalUsers']),
        activeUsers = _toInt(json['activeUsers']),
        keyBalance = _toInt(json['keyBalance']),
        upcomingEmi = _toInt(json['upcomingEmi']),
        todayActivation = _toInt(json['todayActivatedKey']); // may not exist -> 0

  static int _toInt(dynamic v) {
    if (v == null) return 0;
    if (v is int) return v;
    return int.tryParse(v.toString()) ?? 0;
  }
}
