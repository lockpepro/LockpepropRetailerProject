// import 'package:get/get.dart';
//
// class UpcomingController extends GetxController {
//   final upcomingList = [
//     UpcomingModel(
//       keyId: '158567',
//       name: 'Faruk K.',
//       dueDate: '20/Nov/2025',
//       amount: '₹ 5,000.00',
//     ),
//     UpcomingModel(
//       keyId: '158568',
//       name: 'Ramesh SK.',
//       dueDate: '25/Nov/2025',
//       amount: '₹ 5,000.00',
//     ),
//   ].obs;
// }
//
// class UpcomingModel {
//   final String keyId;
//   final String name;
//   final String dueDate;
//   final String amount;
//
//   UpcomingModel({
//     required this.keyId,
//     required this.name,
//     required this.dueDate,
//     required this.amount,
//   });
// }

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zlock_smart_finance/app/services/upcoming_emis_service.dart';

class UpcomingController extends GetxController {
  final upcomingList = <UpcomingModel>[].obs;

  final isLoading = false.obs;
  final page = 1.obs;
  final limit = 10.obs;
  final total = 0.obs;

  final _service = UpcomingService();

  @override
  void onInit() {
    super.onInit();
    fetchUpcoming(reset: true);
  }

  Future<void> fetchUpcoming({bool reset = false}) async {
    if (reset) {
      page.value = 1;
      upcomingList.clear();
    }

    isLoading.value = true;

    final resp = await _service.getUpcomingEmis(
      page: page.value,
      limit: limit.value,
    );

    isLoading.value = false;

    if (resp == null || (resp["status"] != 200)) {
      // keep UI safe
      return;
    }

    // meta null safe
    final meta = (resp["meta"] is Map) ? resp["meta"] as Map : {};
    total.value = _toInt(meta["total"]);
    page.value = _toInt(meta["page"], fallback: page.value);
    limit.value = _toInt(meta["limit"], fallback: limit.value);

    final list = (resp["data"] is List) ? resp["data"] as List : [];

    final mapped = list.map((e) {
      final m = (e is Map) ? e : <String, dynamic>{};

      final keyId = (m["keyId"] ?? "").toString();
      final customerName = (m["customerName"] ?? "N/A").toString();

      final dueRaw = (m["dueDate"] ?? "").toString();
      final dueDate = _formatDate(dueRaw); // ✅ dd/MMM/yyyy

      final amountNum = _toInt(m["amount"]);
      final amount = _formatINR(amountNum); // ✅ ₹ 4,500.00

      return UpcomingModel(
        keyId: keyId.isEmpty ? "N/A" : keyId,
        name: customerName.isEmpty ? "N/A" : customerName,
        dueDate: dueDate,
        amount: amount,
      );
    }).toList();

    upcomingList.addAll(mapped);
  }

  // -------- helpers (null safe) --------
  static int _toInt(dynamic v, {int fallback = 0}) {
    if (v == null) return fallback;
    if (v is int) return v;
    return int.tryParse(v.toString()) ?? fallback;
  }

  static String _formatDate(String iso) {
    if (iso.isEmpty) return "N/A";
    try {
      final dt = DateTime.parse(iso).toLocal();
      return DateFormat("dd/MMM/yyyy").format(dt);
    } catch (_) {
      return "N/A";
    }
  }

  static String _formatINR(int amount) {
    // amount 0 bhi valid
    final f = NumberFormat.currency(locale: "en_IN", symbol: "₹ ", decimalDigits: 2);
    return f.format(amount);
  }
}
class UpcomingModel {
  final String keyId;
  final String name;
  final String dueDate;
  final String amount;

  UpcomingModel({
    required this.keyId,
    required this.name,
    required this.dueDate,
    required this.amount,
  });
}
