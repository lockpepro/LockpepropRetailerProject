import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zlock_smart_finance/app/services/devices_service.dart';
import 'package:zlock_smart_finance/app/services/retailer_dashboard_service.dart';
import 'package:zlock_smart_finance/model/device_list_response.dart';
import 'package:zlock_smart_finance/model/user_model.dart';
import 'package:zlock_smart_finance/modules/retailer/qr_code/qr_dialog_helper.dart';

// ---------------- CONTROLLER ----------------

// enum DeviceListType { NEW, RUNNING, ACTIVE, LOCKED, REMOVED, IPHONE }
// enum DeviceTypeFilter { ANDROID, IPHONE, RUNNING } // ✅ as your swagger
//
// extension DeviceListTypeX on DeviceListType {
//   String get api => name; // returns "ACTIVE" etc
// }
//
// extension DeviceTypeFilterX on DeviceTypeFilter {
//   String get api => name; // returns "ANDROID" etc
// }


// UserModel mapDeviceToUserModel(DeviceItem d, UserStatus uiStatus) {
//   final dt = d.createdAt;
//   final timeText = dt == null
//       ? ""
//       : DateFormat("dd MMM, hh:mm a").format(dt.toLocal());
//
//   return UserModel(
//     keyId: d.keyId,
//     name: d.customerName,
//     mobile: d.mobile,
//     imei: d.imei,
//     loanBy: d.loanProvider,
//     brand: d.brandModel,
//     emi: d.emiStatus,
//     time: timeText,
//     status: uiStatus,
//     createdDate: d.createdAt?.toIso8601String() ?? "",
//   );
// }

// class UsersController extends GetxController {
//   final search = ''.obs;
//   final selectedPlatform = 0.obs; // 0 Android, 1 iPhone
//   final selectedStatus = UserStatus.active.obs;
//
//   final users = <UserModel>[
//     UserModel(
//       keyId: '158567',
//       name: 'John Doe',
//       mobile: '88420 54542',
//       imei: '352397458773904',
//       loanBy: 'BANK OF BARODA',
//       brand: 'OPPO',
//       emi: '01/12',
//       time: 'Today, 10:28 AM',
//       status: UserStatus.active, createdDate: '',
//     ),
//     UserModel(
//       keyId: '158568',
//       name: 'John Doe',
//       mobile: '88420 54542',
//       imei: '352397458773904',
//       loanBy: 'BANK OF BARODA',
//       brand: 'OPPO',
//       emi: '01/12',
//       time: 'Today, 10:28 AM',
//       status: UserStatus.locked, createdDate: '',
//     ),
//     UserModel(
//       keyId: '158569',
//       name: 'John Doe',
//       mobile: '88420 54542',
//       imei: '352397458773904',
//       loanBy: 'BANK OF BARODA',
//       brand: 'OPPO',
//       emi: '01/12',
//       time: 'Today, 10:28 AM',
//       status: UserStatus.removed, createdDate: '',
//     ),
//   ].obs;
//
//   List<UserModel> get filteredUsers {
//     if (search.value.isEmpty) return users;
//     return users
//         .where((u) =>
//     u.name.toLowerCase().contains(search.value.toLowerCase()) ||
//         u.keyId.contains(search.value) ||
//         u.mobile.contains(search.value))
//         .toList();
//   }
// }

class UsersController extends GetxController {
  // coming from KeyDetailsPage
  final selectedPlatform = 0.obs; // 0 Android, 1 iPhone
  final selectedStatus = UserStatus.active.obs;

  // API filters (current)
  final apiDeviceType = "ANDROID".obs; // ANDROID / IPHONE
  final apiStatus = "ACTIVE".obs;      // ACTIVE / LOCKED / REMOVED / PENDING


  String type = "ACTIVE";        // ACTIVE/LOCKED/REMOVED/PENDING
  String deviceType = "ANDROID"; // ANDROID/IPHONE
  int today = 0;

  // search text
  final search = ''.obs;

  // list + pagination
  final users = <UserModel>[].obs;

  final isLoading = false.obs;        // first load
  final isLoadingMore = false.obs;    // pagination load
  final hasMore = true.obs;

  int _page = 1;
  final int _limit = 10;
  int _total = 0;

  final _service = DevicesService();

  Timer? _debounce;


  bool _statusListenerReady = false;
  bool _platformListenerReady = false;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;
    debugPrint("argS>>>>>>>>>>>>>$args");

    if (args is Map) {
      type = (args["type"] ?? "ACTIVE").toString().toUpperCase();
      deviceType = (args["deviceType"] ?? "ANDROID").toString().toUpperCase();
      today = int.tryParse((args["today"] ?? 0).toString()) ?? 0;
    } else {
      type = "ACTIVE";
      deviceType = "ANDROID";
      today = 0;
    }

    // ✅ Sync UI tabs without triggering listeners
    selectedPlatform.value = (deviceType == "IPHONE") ? 1 : 0;
    selectedStatus.value = _uiStatusFromApi(type);

    debugPrint("📌 UsersController filters => type=$type deviceType=$deviceType today=$today");

    // ✅ attach listeners but ignore first auto event
    ever(selectedPlatform, (_) {
      if (!_platformListenerReady) return; // ignore first
      final tabDeviceType = (selectedPlatform.value == 1) ? "IPHONE" : "ANDROID";
      if (deviceType == tabDeviceType) return;
      deviceType = tabDeviceType;
      fetchFirstPage();
    });

    ever(selectedStatus, (_) {
      if (!_statusListenerReady) return; // ignore first
      final newType = _apiStatusFromUi(selectedStatus.value);
      if (type == newType) return;
      type = newType;
      fetchFirstPage();
    });

    // ✅ enable listeners AFTER initial state set
    _platformListenerReady = true;
    _statusListenerReady = true;

    // ✅ debounce search
    ever(search, (_) {
      _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 400), () {
        fetchFirstPage();
      });
    });

    // ✅ initial fetch (must use args type e.g. LOCKED)
    fetchFirstPage();
  }


  String _apiStatusFromUi(UserStatus s) {
    switch (s) {
      case UserStatus.active:  return "ACTIVE";
      case UserStatus.locked:  return "LOCK";
      case UserStatus.removed: return "REMOVE";
      case UserStatus.pending: return "PENDING";
    }
  }

  UserStatus _uiStatusFromApi(String s) {
    switch (s.toUpperCase()) {
      case "LOCK":  return UserStatus.locked;
      case "REMOVE": return UserStatus.removed;
      case "PENDING": return UserStatus.pending;
      case "ACTIVE":
      default:        return UserStatus.active;
    }
  }


  UserStatus _mapToUiStatus(String type) {
    // UI badge based on listing type
    if (type == "ACTIVE") return UserStatus.active;
    if (type == "LOCK") return UserStatus.locked;
    if (type == "REMOVE") return UserStatus.removed;

    // fallback: treat as active for NEW/RUNNING/IPHONE
    return UserStatus.active;
  }

  Future<void> fetchFirstPage() async {
    if (isLoading.value) return;

    isLoading.value = true;
    isLoadingMore.value = false;
    hasMore.value = true;

    _page = 1;
    users.clear();

    try {
      final resp = await _service.getDevices(
        type: type, // ✅ EXACT API enum

        deviceType: deviceType, // ✅ EXACT API enum
        today: today,
        search: search.value,
        page: _page,
        limit: _limit,
      );

      if (resp == null || resp.status != 200) {
        debugPrint("❌ DEVICES: failed first page");
        return;
      }

      _total = resp.meta?.total ?? 0;

      final uiStatus = _mapToUiStatus(type);

      final mapped = resp.data.map((d) {
        return UserModel(
          keyId: d.keyId,
          deviceId: d.deviceId,
          deviceType: d.deviceType,
          productImage: d.productImage,
          name: d.customerName,
          mobile: d.mobile,
          imei: d.imei,
          loanBy: d.loanProvider,
          brand: d.brandModel,
          emi: d.emiStatus,
          time: d.createdAt?.toLocal().toString() ?? "",
          status: uiStatus,
          createdDate: d.createdAt?.toIso8601String() ?? "",
         signatureImage: d.signatureImage,
         imei2: d.imei2,
          productPrice: d.productPrice?.toString(),
          downPayment: d.downPayment?.toString(),
          balancePayment: d.balancePayment?.toString(),
          tenure: d.tenure?.toString(),
          interest: d.interest?.toString(),
          emiAmount: d.emiAmount?.toString(),


        );
      }).toList();

      final enforced = mapped.where((u) {
        return u.deviceType.toUpperCase() == apiDeviceType.value;
      }).toList();

      users.assignAll(enforced);

      hasMore.value = users.length < _total;

      debugPrint("✅ FIRST PAGE: got=${users.length} total=$_total hasMore=${hasMore.value}");
      // users.assignAll(mapped);
      //
      // // has more?
      // hasMore.value = users.length < _total;

      debugPrint("✅ DEVICES FIRST PAGE: got=${users.length} total=$_total hasMore=${hasMore.value}");
    } catch (e) {
      debugPrint("❌ DEVICES FIRST PAGE ERROR: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMore() async {
    if (!hasMore.value) return;
    if (isLoading.value || isLoadingMore.value) return;

    isLoadingMore.value = true;

    try {
      final nextPage = _page + 1;

      final resp = await _service.getDevices(
        type: type,
        deviceType: deviceType,
        today: today,
        search: search.value,
        page: nextPage,
        limit: _limit,
      );

      if (resp == null || resp.status != 200) {
        debugPrint("❌ DEVICES: failed loadMore");
        return;
      }

      final uiStatus = _mapToUiStatus(type);

      final mapped = resp.data.map((d) {
        return UserModel(
          keyId: d.keyId,
          deviceId: d.deviceId,
          deviceType: d.deviceType,
          productImage: d.productImage,
          name: d.customerName,
          mobile: d.mobile,
          imei: d.imei,
          loanBy: d.loanProvider,
          brand: d.brandModel,
          emi: d.emiStatus,
          time: d.createdAt?.toLocal().toString() ?? "",
          status: uiStatus,
          createdDate: d.createdAt?.toIso8601String() ?? "",
           signatureImage: d.signatureImage,
          imei2: d.imei2,
          productPrice: d.productPrice?.toString(),
          downPayment: d.downPayment?.toString(),
          balancePayment: d.balancePayment?.toString(),
          tenure: d.tenure?.toString(),
          interest: d.interest?.toString(),
          emiAmount: d.emiAmount?.toString(),
        );
      }).toList();
      final enforced = mapped.where((u) {
        return u.deviceType.toUpperCase() == apiDeviceType.value;
      }).toList();

      users.addAll(enforced);
      _page = nextPage;

      hasMore.value = users.length < _total;

      debugPrint("✅ LOAD MORE: page=$_page added=${enforced.length} totalNow=${users.length}");

      // users.addAll(mapped);
      // _page = nextPage;
      //
      // hasMore.value = users.length < _total;

      debugPrint("✅ DEVICES LOAD MORE: page=$_page got=${mapped.length} totalNow=${users.length} hasMore=${hasMore.value}");
    } catch (e) {
      debugPrint("❌ DEVICES LOAD MORE ERROR: $e");
    } finally {
      isLoadingMore.value = false;
    }
  }

  // ✅ for list
  List<UserModel> get filteredUsers => users;

  @override
  void onClose() {
    _debounce?.cancel();
    super.onClose();
  }
}