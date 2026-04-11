import 'package:get/get.dart';


import 'package:flutter/foundation.dart';
import 'package:zlock_smart_finance/app/services/key_summary_service.dart';
import 'package:zlock_smart_finance/model/key_summary_model.dart';

class KeyDetailsController extends GetxController {
  final isLoading = false.obs;

  final totalKey = 0.obs;

  final newKey = 0.obs;
  final runningKey = 0.obs;
  final iphoneAvailable = 0.obs;

  final loanZoneKey = 0.obs;
  final eMandate = 0.obs;

  // // ✅ RxMap so UI can update without impact
  // final RxMap<String, int> newKeyStats = <String, int>{
  //   "active": 0,
  //   "lock": 0,
  //   "remove": 0,
  // }.obs;
  //
  // final RxMap<String, int> runningKeyStats = <String, int>{
  //   "active": 0,
  //   "lock": 0,
  //   "remove": 0,
  // }.obs;
  //
  // final RxMap<String, int> iphoneStats = <String, int>{
  //   "active": 0,
  //   "lock": 0,
  //   "remove": 0,
  // }.obs;

  final RxMap<String, int> newKeyStats = <String, int>{
    "active": 0,
    "lock": 0,
    "remove": 0,
    "pending": 0, // ✅ NEW
  }.obs;

  final RxMap<String, int> runningKeyStats = <String, int>{
    "active": 0,
    "lock": 0,
    "remove": 0,
    "pending": 0, // ✅ NEW
  }.obs;

  final RxMap<String, int> iphoneStats = <String, int>{
    "active": 0,
    "lock": 0,
    "remove": 0,
    "pending": 0, // ✅ NEW
  }.obs;

  final _service = KeySummaryService();

  @override
  void onInit() {
    super.onInit();
    fetchKeySummary();
  }

  Future<void> refreshData() async {
    await fetchKeySummary();
  }
  Future<void> fetchKeySummary() async {
    if (isLoading.value) return;

    isLoading.value = true;

    try {
      final resp = await _service.getKeySummary();

      if (resp == null || resp.status != 200 || resp.data == null) {
        debugPrint("❌ Failed to load key summary");
        return;
      }

      final KeySummaryData d = resp.data!;

      totalKey.value = d.totalKey;

      newKey.value = d.newKey;
      runningKey.value = d.runningKey;
      iphoneAvailable.value = d.iphoneAvailable;

      loanZoneKey.value = d.loanZoneKey;
      eMandate.value = d.eMandate;

      // ✅ Update stats
      // newKeyStats.assignAll({
      //   "active": d.total.active,
      //   "lock": d.total.lock,
      //   "remove": d.total.remove,
      // });
      //
      // runningKeyStats.assignAll({
      //   "active": d.running.active,
      //   "lock": d.running.lock,
      //   "remove": d.running.remove,
      // });
      //
      // iphoneStats.assignAll({
      //   "active": d.iphone.active,
      //   "lock": d.iphone.lock,
      //   "remove": d.iphone.remove,
      // });

      newKeyStats.assignAll({
        "active": d.total.active,
        "lock": d.total.lock,
        "remove": d.total.remove,
        "pending": d.total.pending, // ✅ NEW
      });

      runningKeyStats.assignAll({
        "active": d.running.active,
        "lock": d.running.lock,
        "remove": d.running.remove,
        "pending": d.running.pending, // ✅ NEW
      });

      iphoneStats.assignAll({
        "active": d.iphone.active,
        "lock": d.iphone.lock,
        "remove": d.iphone.remove,
        "pending": d.iphone.pending, // ✅ NEW
      });
      debugPrint("✅ KEY SUMMARY UPDATED: total=${totalKey.value}, new=${newKey.value}");
    } catch (e, st) {
      debugPrint("❌ KEY SUMMARY ERROR: $e");
      debugPrint("$st");
    } finally {
      isLoading.value = false; // ✅ always stop loader
    }
  }

}
