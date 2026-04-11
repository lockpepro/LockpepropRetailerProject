// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../app/routes/app_routes.dart';
//
// class LoginController extends GetxController {
//   final email = TextEditingController();
//   final password = TextEditingController();
//
//   var isObscure = true.obs;      // 🔥 for eye toggle
//
//   var isChecked = false.obs;
//   var isLoading = false.obs;
//
//   late String role;
//
//   @override
//   void onInit() {
//     role = Get.arguments ?? "retailer";
//     super.onInit();
//   }
//
//   void login() async {
//     if (!isChecked.value) {
//       Get.snackbar(
//           "Error", "Accept Terms & Conditions",
//           snackPosition: SnackPosition.BOTTOM,   // ⬅️ BOTTOM POSITION
//           margin: const EdgeInsets.all(12),
//           backgroundColor: Colors.red.withOpacity(0.9),
//           colorText: Colors.white,
//           borderRadius: 12,
//       );
//       return;
//     }
//
//     if (email.text.isEmpty || password.text.isEmpty) {
//       Get.snackbar(
//         "Error",
//         "Email & Password required",
//         snackPosition: SnackPosition.BOTTOM,   // ⬅️ BOTTOM POSITION
//         margin: const EdgeInsets.all(12),
//         backgroundColor: Colors.red.withOpacity(0.9),
//         colorText: Colors.white,
//         borderRadius: 12,
//       );
//       return;
//     }
//
//     isLoading.value = true;
//
//     await Future.delayed(const Duration(seconds: 1));
//
//     if (role == "retailer") {
//       Get.offAllNamed(AppRoutes.DASH_RETAILER);
//     } else {
//       Get.offAllNamed(AppRoutes.DASH_DISTRIBUTOR);
//     }
//
//     isLoading.value = false;
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zlock_smart_finance/app/services/dio_client.dart';
import 'package:zlock_smart_finance/app/services/snckbar.dart';
import 'package:zlock_smart_finance/modules/auth/login/auth_service.dart';
import '../../../app/routes/app_routes.dart';

class LoginController extends GetxController {
  final email = TextEditingController();
  final password = TextEditingController();

  final isObscure = true.obs;
  final isChecked = false.obs;
  final isLoading = false.obs;

  late String role; // "retailer" / "distributor" (lowercase from args)
  final _authService = AuthService();
  final _box = GetStorage();

  @override
  void onInit() {
    role = (Get.arguments ?? "retailer").toString().toLowerCase();
    super.onInit();
  }

  String _userTypeFromRole() {
    // API needs enum: RETAILER / DISTRIBUTOR
    if (role == "retailer") return "RETAILER";
    return "DISTRIBUTOR";
  }


  // void login() async {
  //   print("========== LOGIN START ==========");
  //
  //   if (!isChecked.value) {
  //     print("❌ Terms & Conditions NOT accepted");
  //     AppSnack.error("Accept Terms & Conditions");
  //     return;
  //   }
  //
  //   if (email.text.trim().isEmpty || password.text.trim().isEmpty) {
  //     print("❌ Email or Password EMPTY");
  //     AppSnack.error("Email & Password required");
  //     return;
  //   }
  //
  //   isLoading.value = true;
  //
  //   final userType = _userTypeFromRole();
  //
  //   print("📨 Login Request Data:");
  //   print("➡️ Email     : ${email.text.trim()}");
  //   print("➡️ Password  : ${password.text.trim()}");
  //   print("➡️ UserType  : $userType");
  //
  //   final resp = await _authService.login(
  //     email: email.text,
  //     password: password.text,
  //     userType: userType,
  //   );
  //
  //   isLoading.value = false;
  //
  //   if (resp == null) {
  //     print("❌ LOGIN FAILED (resp null)");
  //     print("========== LOGIN END ==========");
  //     return;
  //   }
  //
  //   final ok = (resp.status == 200); // ✅ success condition
  //
  //   print("📥 Login API Response:");
  //   print("➡️ status  : ${resp.status}");
  //   print("➡️ message : ${resp.message}");
  //   print("➡️ token   : ${resp.data?.token}");
  //   print("➡️ id      : ${resp.data?.id}");
  //   print("➡️ isPinSet: ${resp.data?.isPinSet}");
  //   print("➡️ data    : ${resp.data?.toJson()}");
  //
  //   if (!ok) {
  //     print("❌ LOGIN FAILED (status != 200)");
  //     AppSnack.error(resp.message ?? "Login failed");
  //     print("========== LOGIN END ==========");
  //     return;
  //   }
  //
  //   // ✅ Save token
  //   final token = resp.data?.token;
  //   if (token != null && token.isNotEmpty) {
  //     print("✅ Saving token to storage");
  //     _box.write("token", token);
  //     ApiClient.attachToken();
  //   } else {
  //     print("⚠️ Token NOT found in response");
  //   }
  //
  //   // ✅ Save role & userType
  //   print("💾 Saving role & userType");
  //   _box.write("role", role);
  //   _box.write("userType", userType);
  //   _box.write("userData", resp.data?.toJson());
  //   _box.write("userId", resp.data?.id);
  //   _box.write("isPinSet", resp.data?.isPinSet ?? false);
  //
  //   print("📦 Stored Values:");
  //   print("➡️ role     : ${_box.read("role")}");
  //   print("➡️ userType : ${_box.read("userType")}");
  //   print("➡️ token    : ${_box.read("token")}");
  //   print("➡️ userId   : ${_box.read("userId")}");
  //   print("➡️ isPinSet : ${_box.read("isPinSet")}");
  //   print("➡️ userData : ${_box.read("userData")}");
  //
  //   // ✅ Navigation
  //   if (role == "retailer") {
  //     print("🚀 Navigating to RETAILER DASHBOARD");
  //     Get.offAllNamed(AppRoutes.DASH_RETAILER);
  //   } else {
  //     print("🚀 Navigating to DISTRIBUTOR DASHBOARD");
  //     Get.offAllNamed(AppRoutes.DASH_DISTRIBUTOR);
  //   }
  //
  //   print("========== LOGIN END ==========");
  // }

  // void login() async {
  //   print("========== LOGIN START ==========");
  //
  //   if (!isChecked.value) {
  //     AppSnack.error("Accept Terms & Conditions");
  //     return;
  //   }
  //
  //   if (email.text.trim().isEmpty || password.text.trim().isEmpty) {
  //     AppSnack.error("Email & Password required");
  //     return;
  //   }
  //
  //   isLoading.value = true;
  //
  //   final uiRole = (role).toLowerCase(); // from Get.arguments (retailer/distributor)
  //
  //   final resp = await _authService.login(
  //     email: email.text,
  //     password: password.text,
  //     userType: _userTypeFromRole(), // ignored in payload (no impact)
  //   );
  //
  //   isLoading.value = false;
  //
  //   if (resp == null) {
  //     AppSnack.error("Login failed");
  //     return;
  //   }
  //
  //   final ok = (resp.status == 200) || (resp.success == true);
  //   if (!ok) {
  //     AppSnack.error(resp.message ?? "Login failed");
  //     return;
  //   }
  //
  //   // ✅ Save token
  //   final token = resp.data?.token;
  //   if (token != null && token.isNotEmpty) {
  //     await _box.write("token", token);
  //     ApiClient.attachToken();
  //   }
  //
  //   // ✅ Save basic data
  //   await _box.write("userId", resp.data?.id);
  //   await _box.write("userData", resp.data?.toJson());
  //
  //   // ✅ BACKEND role/userType (NEW API)
  //   final backendRole = (resp.user?.role ?? "").toString().toLowerCase();      // e.g. super_admin
  //   final backendUserType = (resp.user?.userType ?? "").toString().toLowerCase(); // e.g. admin
  //
  //   // Decide final role
  //   final isAdmin = backendUserType == "admin" ||
  //       backendRole == "admin" ||
  //       backendRole == "super_admin";
  //
  //   if (isAdmin) {
  //     // ✅ Admin: just show toast with role
  //     final showRole = resp.user?.role ?? resp.user?.userType ?? "admin";
  //     AppSnack.success("Logged in as $showRole");
  //     return; // ✅ stop here, no redirect
  //   }
  //
  //   // ✅ If not admin: decide retailer/distributor (backend first, else fallback UI role)
  //   String finalRole = uiRole;
  //
  //   if (backendRole.contains("vendor") || backendUserType == "retailer") {
  //     finalRole = "retailer";
  //   } else if (backendRole.contains("distributor") || backendUserType == "distributor") {
  //     finalRole = "distributor";
  //   }
  //
  //   // ✅ Save final role
  //   await _box.write("role", finalRole);
  //
  //   // ✅ Navigation
  //   if (finalRole == "retailer") {
  //     Get.offAllNamed(AppRoutes.DASH_RETAILER);
  //   } else if (finalRole == "distributor") {
  //     Get.offAllNamed(AppRoutes.DASH_DISTRIBUTOR);
  //     // Get.offAllNamed(AppRoutes.DASH_RETAILER);
  //   } else {
  //     // fallback
  //     AppSnack.error("Unknown role: ${resp.user?.role ?? resp.user?.userType ?? finalRole}");
  //   }
  //
  //   print("========== LOGIN END ==========");
  // }
  void login() async {
    print("========== LOGIN START ==========");

    if (!isChecked.value) {
      AppSnack.error("Accept Terms & Conditions");
      return;
    }

    if (email.text.trim().isEmpty || password.text.trim().isEmpty) {
      AppSnack.error("Email & Password required");
      return;
    }

    isLoading.value = true;

    final uiRole = (role).toLowerCase();
    print("🟡 UI ROLE (from screen): $uiRole");

    final resp = await _authService.login(
      email: email.text,
      password: password.text,
      userType: _userTypeFromRole(),
    );

    isLoading.value = false;

    if (resp == null) {
      print("❌ RESPONSE NULL");
      AppSnack.error("Login failed");
      return;
    }

    print("🟢 API STATUS: ${resp.status}");
    print("🟢 API SUCCESS: ${resp.success}");
    print("🟢 FULL RESPONSE: ${resp.toJson()}");

    final ok = (resp.status == 200) || (resp.success == true);
    if (!ok) {
      print("❌ LOGIN FAILED: ${resp.message}");
      AppSnack.error(resp.message ?? "Login failed");
      return;
    }

    // ✅ Save token
    final token = resp.data?.token;
    print("🔑 TOKEN: $token");

    if (token != null && token.isNotEmpty) {
      await _box.write("token", token);
      ApiClient.attachToken();
    }

    // ✅ Save basic data
    await _box.write("userId", resp.data?.id);
    await _box.write("userData", resp.data?.toJson());

    // ✅ BACKEND role/userType
    final backendRole =
    (resp.user?.role ?? "").toString().toLowerCase();
    final backendUserType =
    (resp.user?.userType ?? "").toString().toLowerCase();

    print("🔵 BACKEND ROLE: $backendRole");
    print("🔵 BACKEND USER TYPE: $backendUserType");

    // Admin check
    final isAdmin = backendUserType == "admin" ||
        backendRole == "admin" ||
        backendRole == "super_admin";

    print("🟣 IS ADMIN: $isAdmin");

    if (isAdmin) {
      final showRole = resp.user?.role ?? resp.user?.userType ?? "admin";
      print("✅ LOGIN AS ADMIN: $showRole");

      AppSnack.success("Logged in as $showRole");
      return;
    }

    // ✅ Role decision
    String finalRole = uiRole;

    print("🟡 INITIAL FINAL ROLE (UI): $finalRole");

    if (backendRole.contains("vendor") ||
        backendUserType == "retailer") {
      print("➡️ MATCHED VENDOR -> SET AS RETAILER");
      finalRole = "retailer";
    } else if (backendRole.contains("distributor") ||
        backendUserType == "distributor") {
      print("➡️ MATCHED DISTRIBUTOR");
      finalRole = "distributor";
    }

    print("🟢 FINAL ROLE DECIDED: $finalRole");

    // ✅ Save role
    await _box.write("role", finalRole);

    // ✅ Navigation
    if (finalRole == "retailer") {
      print("🚀 NAVIGATE: RETAILER DASHBOARD");
      Get.offAllNamed(AppRoutes.DASH_RETAILER);
    } else if (finalRole == "distributor") {
      print("🚀 NAVIGATE: DISTRIBUTOR DASHBOARD");
      Get.offAllNamed(AppRoutes.DASH_DISTRIBUTOR);
    } else {
      print("❌ UNKNOWN ROLE: $finalRole");
      AppSnack.error(
          "Unknown role: ${resp.user?.role ?? resp.user?.userType ?? finalRole}");
    }

    print("========== LOGIN END ==========");
  }
  @override
  void onClose() {
    email.dispose();
    password.dispose();
    super.onClose();
  }
}
