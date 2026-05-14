// import 'package:get/get.dart';
// import '../../app/routes/app_routes.dart';
//
// class SplashController extends GetxController {
//   @override
//   void onInit() {
//     Future.delayed(const Duration(seconds: 6), () {
//       Get.offAllNamed(AppRoutes.ROLE);
//     });
//     super.onInit();
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zlock_smart_finance/app/services/dio_client.dart';
import 'package:zlock_smart_finance/app/services/mpin_service.dart';
import '../../app/routes/app_routes.dart';

class SplashController extends GetxController {
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    _checkSession();
  }

  // void _checkSession() async {
  //   await Future.delayed(const Duration(seconds: 3));
  //
  //   final token = box.read("token");
  //   final role = box.read("role"); // retailer / distributor
  //
  //   print("🟢 Splash Session Check");
  //   print("Token: $token");
  //   print("Role : $role");
  //
  //   // ❌ Not logged in
  //   if (token == null || token.toString().isEmpty) {
  //     print("➡️ Redirecting to ROLE screen");
  //     Get.offAllNamed(AppRoutes.ROLE);
  //     return;
  //   }
  //
  //   // ✅ Logged in + role based routing
  //   if (role == "retailer") {
  //     print("➡️ Redirecting to RETAILER DASHBOARD");
  //     Get.offAllNamed(AppRoutes.DASH_RETAILER);
  //   } else if (role == "distributor") {
  //     print("➡️ Redirecting to DISTRIBUTOR DASHBOARD");
  //     Get.offAllNamed(AppRoutes.DASH_DISTRIBUTOR);
  //   } else {
  //     // fallback safety
  //     print("⚠️ Role missing / invalid, redirecting to ROLE");
  //     Get.offAllNamed(AppRoutes.ROLE);
  //   }
  // }


  // void _checkSession() async {
  //   await Future.delayed(const Duration(seconds: 3));
  //
  //   final token = box.read("token");
  //   final role = box.read("role");
  //
  //   print("🟢 Splash Session Check");
  //   print("Token: $token");
  //   print("Role : $role");
  //
  //   if (token == null || token.toString().isEmpty) {
  //     Get.offAllNamed(AppRoutes.ROLE);
  //     return;
  //   }
  //
  //   // ✅ attach token to Dio BEFORE any API calls (profile/dashboard)
  //   ApiClient.attachToken();
  //
  //   if (role == "retailer") {
  //     Get.offAllNamed(AppRoutes.DASH_RETAILER);
  //   } else if (role == "distributor") {
  //     Get.offAllNamed(AppRoutes.DASH_DISTRIBUTOR);
  //   } else {
  //     Get.offAllNamed(AppRoutes.ROLE);
  //   }
  // }

  // void _checkSession() async {
  //   await Future.delayed(const Duration(seconds: 2));
  //
  //   final token = box.read("token")?.toString();
  //   final role = box.read("role")?.toString().toLowerCase().trim();
  //
  //   debugPrint("🟢 Splash Session Check");
  //   debugPrint("Token: $token");
  //   debugPrint("Role : $role");
  //
  //   if (token == null || token.isEmpty) {
  //     debugPrint("🔴 No token -> ROLE screen");
  //     Get.offAllNamed(AppRoutes.ROLE);
  //     return;
  //   }
  //
  //   // ✅ optional (interceptor already does it)
  //   ApiClient.attachToken();
  //
  //   // if (role == "retailer") {
  //   //   debugPrint("➡️ Redirecting to RETAILER DASHBOARD");
  //   //   Get.offAllNamed(AppRoutes.DASH_RETAILER);
  //   // } else if (role == "distributor") {
  //   //   debugPrint("➡️ Redirecting to DISTRIBUTOR DASHBOARD");
  //   //   Get.offAllNamed(AppRoutes.DASH_DISTRIBUTOR);
  //   // } else {
  //   //   debugPrint("🟡 Unknown role -> ROLE screen");
  //   //   Get.offAllNamed(AppRoutes.ROLE);
  //   // }
  //   if (role == "retailer") {
  //     debugPrint("➡️ Redirecting to RETAILER DASHBOARD");
  //     Get.offAllNamed(AppRoutes.DASH_RETAILER);
  //   } else if (role == "distributor") {
  //     debugPrint("➡️ Redirecting to DISTRIBUTOR DASHBOARD");
  //     // Get.offAllNamed(AppRoutes.DASH_DISTRIBUTOR);
  //     Get.offAllNamed(AppRoutes.DASH_RETAILER);
  //
  //   } else {
  //     debugPrint("🟡 Unknown role -> ROLE screen");
  //     Get.offAllNamed(AppRoutes.ROLE);
  //   }
  //
  // }

  // void _checkSession() async {
  //   await Future.delayed(const Duration(seconds: 2));
  //
  //   final token = box.read("token")?.toString();
  //   final roleRaw = box.read("role")?.toString();
  //   final role = roleRaw?.toLowerCase().trim();
  //
  //   debugPrint("========== SPLASH SESSION START ==========");
  //   debugPrint("🟢 TOKEN: $token");
  //   debugPrint("🟢 RAW ROLE (from storage): $roleRaw");
  //   debugPrint("🟢 FORMATTED ROLE: $role");
  //
  //   // ❌ No token
  //   if (token == null || token.isEmpty) {
  //     debugPrint("🔴 No token -> Redirect ROLE");
  //     Get.offAllNamed(AppRoutes.ROLE);
  //     return;
  //   }
  //
  //   // ✅ Attach token
  //   ApiClient.attachToken();
  //
  //   // 🟡 Role decision (with vendor support)
  //   String finalRole = role ?? "";
  //
  //   if (finalRole.contains("vendor")) {
  //     debugPrint("➡️ ROLE MATCHED: VENDOR -> RETAILER");
  //     finalRole = "retailer";
  //   }
  //
  //   debugPrint("🟢 FINAL ROLE USED: $finalRole");
  //
  //   // ✅ Navigation
  //   if (finalRole == "retailer") {
  //     debugPrint("🚀 NAVIGATE: RETAILER DASHBOARD");
  //     Get.offAllNamed(AppRoutes.DASH_RETAILER);
  //   } else if (finalRole == "distributor") {
  //     debugPrint("🚀 NAVIGATE: DISTRIBUTOR DASHBOARD");
  //     Get.offAllNamed(AppRoutes.DASH_DISTRIBUTOR);
  //   } else {
  //     debugPrint("🟡 UNKNOWN ROLE -> ROLE SCREEN");
  //     Get.offAllNamed(AppRoutes.ROLE);
  //   }
  //
  //   debugPrint("========== SPLASH SESSION END ==========");
  // }

  // void _checkSession() async {
  //   await Future.delayed(const Duration(seconds: 2));
  //
  //   final token = box.read("token")?.toString();
  //   final mpinService = MpinService();
  //
  //   debugPrint("========== SPLASH START ==========");
  //
  //   /// ❌ No login
  //   if (token == null || token.isEmpty) {
  //     Get.offAllNamed(AppRoutes.ROLE);
  //     return;
  //   }
  //
  //   /// ✅ attach token
  //   ApiClient.attachToken();
  //
  //   /// 🔐 MPIN CHECK
  //   final hasPin = await mpinService.hasPin();
  //
  //   if (hasPin) {
  //     debugPrint("🔐 MPIN EXISTS → ENTER PIN");
  //     Get.offAllNamed(AppRoutes.ENTER_MPIN);
  //   } else {
  //     debugPrint("⚠️ NO MPIN → CREATE PIN");
  //     Get.offAllNamed(AppRoutes.CREATE_MPIN);
  //   }
  // }

  void _checkSession() async {
    await Future.delayed(const Duration(seconds: 2));

    final token = box.read("token")?.toString();
    final roleRaw = box.read("role")?.toString();
    final role = roleRaw?.toLowerCase().trim();

    final mpinService = MpinService();

    /// ❌ No login
    if (token == null || token.isEmpty) {
      Get.offAllNamed(AppRoutes.LOGIN);
      return;
    }

    /// ✅ attach token
    ApiClient.attachToken();

    /// 🔐 MPIN CHECK
    final hasPin = await mpinService.hasPin();

    if (hasPin) {
      /// 👉 PASS ROLE
      Get.offAllNamed(
        AppRoutes.ENTER_MPIN,
        arguments: {"role": role},
      );
    } else {
      /// 👉 PASS ROLE
      Get.offAllNamed(
        AppRoutes.CREATE_MPIN,
        arguments: {"role": role},
      );
    }
  }
}
