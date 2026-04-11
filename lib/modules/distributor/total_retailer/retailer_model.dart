import 'package:zlock_smart_finance/model/distributor_retailers_response.dart';
import 'package:get/get.dart';

// class RetailerModel {
//   final String retailerId;     // mongo id (retailerId)
//   final String id;             // retailerCode (RX-xxxxx)
//   final String name;           // retailerName
//   final String? image;         // image url (nullable)
//   final String mobile;
//   final String email;
//   final String state;
//   final double balance;
//
//   // ✅ IMPORTANT: for Switch + chip
//   final RxBool isActive;
//
//   final RxBool isToggling = false.obs; // ✅ NEW
//
//   RetailerModel({
//     required this.retailerId,
//     required this.id,
//     required this.name,
//     required this.image,
//     required this.mobile,
//     required this.email,
//     required this.state,
//     required this.balance,
//     required bool active,
//   }) : isActive = active.obs;
//
//   // factory RetailerModel.fromApi(DistributorRetailerItem item) {
//   //   return RetailerModel(
//   //     retailerId: item.retailerId,
//   //     id: item.retailerCode,
//   //     name: item.retailerName,
//   //     image: item.image,
//   //     mobile: item.mobile,
//   //     email: item.email,
//   //     state: item.state,
//   //     balance: item.balance.toDouble(),
//   //     active: item.status,
//   //   );
//   // }
//   factory RetailerModel.fromApi(DistributorRetailerItem e) {
//     return RetailerModel(
//       retailerId: e.retailerId,
//       name: e.retailerName,
//       mobile: e.mobile,
//       email: e.email,
//       state: e.state,
//       image: e.image ?? "",
//       balance: e.balance.toDouble(),
//       isActive: RxBool(e.status),
//       isToggling: false.obs,
//     );
//   }
// }

import 'package:zlock_smart_finance/model/distributor_retailers_response.dart';
import 'package:get/get.dart';

class RetailerModel {
  final String retailerId;
  final String id;
  final String customId;
  final String name;
  final String? image;
  final String mobile;
  final String email;
  final String state;
  final String createdAt;
  final double balance;

  final KeyBalance keyBalance;

  /// ✅ reactive fields
  final RxBool isActive;
  final RxBool isToggling = false.obs;

  RetailerModel({
    required this.retailerId,
    required this.id,
    required this.customId,
    required this.name,
    required this.image,
    required this.mobile,
    required this.email,
    required this.state,
    required this.createdAt,
    required this.balance,
    required this.keyBalance,
    required bool active,
  }) : isActive = active.obs;

  /// ✅ FIXED FACTORY 🔥
  factory RetailerModel.fromApi(DistributorRetailerItem e) {
    final kb = e.keyBalance; // 👈 assume already parsed

    return RetailerModel(
      retailerId: e.retailerId,
      customId: e.customId,
      id: e.retailerCode,
      name: e.retailerName,
      image: e.image,
      mobile: e.mobile,
      email: e.email,
      state: e.state,
      createdAt: e.createdAt,

      /// 🔥 MAIN FIX
      keyBalance: kb,

      /// 🔥 BALANCE FROM total_available
      balance: (kb.totalAvailable).toDouble(),

      active: e.status,
    );
  }
}