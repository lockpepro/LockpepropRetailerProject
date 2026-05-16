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

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zlock_smart_finance/app/services/dio_client.dart';
import 'package:zlock_smart_finance/app/services/snckbar.dart';
import 'package:zlock_smart_finance/modules/auth/login/auth_service.dart';
import '../../../app/routes/app_routes.dart';

// class LoginController extends GetxController {
//   final email = TextEditingController();
//   final password = TextEditingController();
//
//   final isObscure = true.obs;
//   final isChecked = false.obs;
//   final isLoading = false.obs;
//
//   late String role; // "retailer" / "distributor" (lowercase from args)
//   final _authService = AuthService();
//   final _box = GetStorage();
//
//   @override
//   void onInit() {
//     role = (Get.arguments ?? "retailer").toString().toLowerCase();
//     super.onInit();
//   }
//
//   String _userTypeFromRole() {
//     // API needs enum: RETAILER / DISTRIBUTOR
//     if (role == "retailer") return "RETAILER";
//     return "DISTRIBUTOR";
//   }
//
//
//   // void login() async {
//   //   print("========== LOGIN START ==========");
//   //
//   //   if (!isChecked.value) {
//   //     print("❌ Terms & Conditions NOT accepted");
//   //     AppSnack.error("Accept Terms & Conditions");
//   //     return;
//   //   }
//   //
//   //   if (email.text.trim().isEmpty || password.text.trim().isEmpty) {
//   //     print("❌ Email or Password EMPTY");
//   //     AppSnack.error("Email & Password required");
//   //     return;
//   //   }
//   //
//   //   isLoading.value = true;
//   //
//   //   final userType = _userTypeFromRole();
//   //
//   //   print("📨 Login Request Data:");
//   //   print("➡️ Email     : ${email.text.trim()}");
//   //   print("➡️ Password  : ${password.text.trim()}");
//   //   print("➡️ UserType  : $userType");
//   //
//   //   final resp = await _authService.login(
//   //     email: email.text,
//   //     password: password.text,
//   //     userType: userType,
//   //   );
//   //
//   //   isLoading.value = false;
//   //
//   //   if (resp == null) {
//   //     print("❌ LOGIN FAILED (resp null)");
//   //     print("========== LOGIN END ==========");
//   //     return;
//   //   }
//   //
//   //   final ok = (resp.status == 200); // ✅ success condition
//   //
//   //   print("📥 Login API Response:");
//   //   print("➡️ status  : ${resp.status}");
//   //   print("➡️ message : ${resp.message}");
//   //   print("➡️ token   : ${resp.data?.token}");
//   //   print("➡️ id      : ${resp.data?.id}");
//   //   print("➡️ isPinSet: ${resp.data?.isPinSet}");
//   //   print("➡️ data    : ${resp.data?.toJson()}");
//   //
//   //   if (!ok) {
//   //     print("❌ LOGIN FAILED (status != 200)");
//   //     AppSnack.error(resp.message ?? "Login failed");
//   //     print("========== LOGIN END ==========");
//   //     return;
//   //   }
//   //
//   //   // ✅ Save token
//   //   final token = resp.data?.token;
//   //   if (token != null && token.isNotEmpty) {
//   //     print("✅ Saving token to storage");
//   //     _box.write("token", token);
//   //     ApiClient.attachToken();
//   //   } else {
//   //     print("⚠️ Token NOT found in response");
//   //   }
//   //
//   //   // ✅ Save role & userType
//   //   print("💾 Saving role & userType");
//   //   _box.write("role", role);
//   //   _box.write("userType", userType);
//   //   _box.write("userData", resp.data?.toJson());
//   //   _box.write("userId", resp.data?.id);
//   //   _box.write("isPinSet", resp.data?.isPinSet ?? false);
//   //
//   //   print("📦 Stored Values:");
//   //   print("➡️ role     : ${_box.read("role")}");
//   //   print("➡️ userType : ${_box.read("userType")}");
//   //   print("➡️ token    : ${_box.read("token")}");
//   //   print("➡️ userId   : ${_box.read("userId")}");
//   //   print("➡️ isPinSet : ${_box.read("isPinSet")}");
//   //   print("➡️ userData : ${_box.read("userData")}");
//   //
//   //   // ✅ Navigation
//   //   if (role == "retailer") {
//   //     print("🚀 Navigating to RETAILER DASHBOARD");
//   //     Get.offAllNamed(AppRoutes.DASH_RETAILER);
//   //   } else {
//   //     print("🚀 Navigating to DISTRIBUTOR DASHBOARD");
//   //     Get.offAllNamed(AppRoutes.DASH_DISTRIBUTOR);
//   //   }
//   //
//   //   print("========== LOGIN END ==========");
//   // }
//
//   // void login() async {
//   //   print("========== LOGIN START ==========");
//   //
//   //   if (!isChecked.value) {
//   //     AppSnack.error("Accept Terms & Conditions");
//   //     return;
//   //   }
//   //
//   //   if (email.text.trim().isEmpty || password.text.trim().isEmpty) {
//   //     AppSnack.error("Email & Password required");
//   //     return;
//   //   }
//   //
//   //   isLoading.value = true;
//   //
//   //   final uiRole = (role).toLowerCase(); // from Get.arguments (retailer/distributor)
//   //
//   //   final resp = await _authService.login(
//   //     email: email.text,
//   //     password: password.text,
//   //     userType: _userTypeFromRole(), // ignored in payload (no impact)
//   //   );
//   //
//   //   isLoading.value = false;
//   //
//   //   if (resp == null) {
//   //     AppSnack.error("Login failed");
//   //     return;
//   //   }
//   //
//   //   final ok = (resp.status == 200) || (resp.success == true);
//   //   if (!ok) {
//   //     AppSnack.error(resp.message ?? "Login failed");
//   //     return;
//   //   }
//   //
//   //   // ✅ Save token
//   //   final token = resp.data?.token;
//   //   if (token != null && token.isNotEmpty) {
//   //     await _box.write("token", token);
//   //     ApiClient.attachToken();
//   //   }
//   //
//   //   // ✅ Save basic data
//   //   await _box.write("userId", resp.data?.id);
//   //   await _box.write("userData", resp.data?.toJson());
//   //
//   //   // ✅ BACKEND role/userType (NEW API)
//   //   final backendRole = (resp.user?.role ?? "").toString().toLowerCase();      // e.g. super_admin
//   //   final backendUserType = (resp.user?.userType ?? "").toString().toLowerCase(); // e.g. admin
//   //
//   //   // Decide final role
//   //   final isAdmin = backendUserType == "admin" ||
//   //       backendRole == "admin" ||
//   //       backendRole == "super_admin";
//   //
//   //   if (isAdmin) {
//   //     // ✅ Admin: just show toast with role
//   //     final showRole = resp.user?.role ?? resp.user?.userType ?? "admin";
//   //     AppSnack.success("Logged in as $showRole");
//   //     return; // ✅ stop here, no redirect
//   //   }
//   //
//   //   // ✅ If not admin: decide retailer/distributor (backend first, else fallback UI role)
//   //   String finalRole = uiRole;
//   //
//   //   if (backendRole.contains("vendor") || backendUserType == "retailer") {
//   //     finalRole = "retailer";
//   //   } else if (backendRole.contains("distributor") || backendUserType == "distributor") {
//   //     finalRole = "distributor";
//   //   }
//   //
//   //   // ✅ Save final role
//   //   await _box.write("role", finalRole);
//   //
//   //   // ✅ Navigation
//   //   if (finalRole == "retailer") {
//   //     Get.offAllNamed(AppRoutes.DASH_RETAILER);
//   //   } else if (finalRole == "distributor") {
//   //     Get.offAllNamed(AppRoutes.DASH_DISTRIBUTOR);
//   //     // Get.offAllNamed(AppRoutes.DASH_RETAILER);
//   //   } else {
//   //     // fallback
//   //     AppSnack.error("Unknown role: ${resp.user?.role ?? resp.user?.userType ?? finalRole}");
//   //   }
//   //
//   //   print("========== LOGIN END ==========");
//   // }
//   void login() async {
//     print("========== LOGIN START ==========");
//
//     if (!isChecked.value) {
//       AppSnack.error("Accept Terms & Conditions");
//       return;
//     }
//
//     if (email.text.trim().isEmpty || password.text.trim().isEmpty) {
//       AppSnack.error("Email & Password required");
//       return;
//     }
//
//     isLoading.value = true;
//
//     final uiRole = (role).toLowerCase();
//     print("🟡 UI ROLE (from screen): $uiRole");
//
//     final resp = await _authService.login(
//       email: email.text,
//       password: password.text,
//       userType: _userTypeFromRole(),
//     );
//
//     isLoading.value = false;
//
//     if (resp == null) {
//       print("❌ RESPONSE NULL");
//       AppSnack.error("Login failed");
//       return;
//     }
//
//     print("🟢 API STATUS: ${resp.status}");
//     print("🟢 API SUCCESS: ${resp.success}");
//     print("🟢 FULL RESPONSE: ${resp.toJson()}");
//
//     final ok = (resp.status == 200) || (resp.success == true);
//     if (!ok) {
//       print("❌ LOGIN FAILED: ${resp.message}");
//       AppSnack.error(resp.message ?? "Login failed");
//       return;
//     }
//
//     // ✅ Save token
//     final token = resp.data?.token;
//     print("🔑 TOKEN: $token");
//
//     if (token != null && token.isNotEmpty) {
//       await _box.write("token", token);
//       ApiClient.attachToken();
//     }
//
//     // ✅ Save basic data
//     await _box.write("userId", resp.data?.id);
//     await _box.write("userData", resp.data?.toJson());
//
//     // ✅ BACKEND role/userType
//     final backendRole =
//     (resp.user?.role ?? "").toString().toLowerCase();
//     final backendUserType =
//     (resp.user?.userType ?? "").toString().toLowerCase();
//
//     print("🔵 BACKEND ROLE: $backendRole");
//     print("🔵 BACKEND USER TYPE: $backendUserType");
//
//     // Admin check
//     final isAdmin = backendUserType == "admin" ||
//         backendRole == "admin" ||
//         backendRole == "super_admin";
//
//     print("🟣 IS ADMIN: $isAdmin");
//
//     if (isAdmin) {
//       final showRole = resp.user?.role ?? resp.user?.userType ?? "admin";
//       print("✅ LOGIN AS ADMIN: $showRole");
//
//       AppSnack.success("Logged in as $showRole");
//       return;
//     }
//
//     // ✅ Role decision
//     String finalRole = uiRole;
//
//     print("🟡 INITIAL FINAL ROLE (UI): $finalRole");
//
//     if (backendRole.contains("vendor") ||
//         backendUserType == "retailer") {
//       print("➡️ MATCHED VENDOR -> SET AS RETAILER");
//       finalRole = "retailer";
//     } else if (backendRole.contains("distributor") ||
//         backendUserType == "distributor") {
//       print("➡️ MATCHED DISTRIBUTOR");
//       finalRole = "distributor";
//     }
//
//     print("🟢 FINAL ROLE DECIDED: $finalRole");
//
//     // ✅ Save role
//     await _box.write("role", finalRole);
//
//     // ✅ Navigation
//     if (finalRole == "retailer") {
//       print("🚀 NAVIGATE: RETAILER DASHBOARD");
//       Get.offAllNamed(AppRoutes.DASH_RETAILER);
//     } else if (finalRole == "distributor") {
//       print("🚀 NAVIGATE: DISTRIBUTOR DASHBOARD");
//       Get.offAllNamed(AppRoutes.DASH_DISTRIBUTOR);
//     } else {
//       print("❌ UNKNOWN ROLE: $finalRole");
//       AppSnack.error(
//           "Unknown role: ${resp.user?.role ?? resp.user?.userType ?? finalRole}");
//     }
//
//     print("========== LOGIN END ==========");
//   }
//   @override
//   void onClose() {
//     email.dispose();
//     password.dispose();
//     super.onClose();
//   }
// }

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
    /// DEFAULT EMAIL SELECTED
    selectedLoginType.value = 0;

    isEmailLogin.value = true;

    isMobileLogin.value = false;
    super.onInit();
  }

  String _userTypeFromRole() {
    // API needs enum: RETAILER / DISTRIBUTOR
    if (role == "retailer") return "RETAILER";
    return "DISTRIBUTOR";
  }

  final selectedLoginType = 0.obs;
  void switchLoginType(int index) {

    selectedLoginType.value = index;

    /// EMAIL
    if (index == 0) {

      isEmailLogin.value = true;
      isMobileLogin.value = false;

      isOtpSent.value = false;
      isOtpVerified.value = false;

      loginInput.clear();
      mobile.clear();
      otp.clear();
      otpValue.value = '';
    }

    /// MOBILE
    else {

      isEmailLogin.value = false;
      isMobileLogin.value = true;

      loginInput.clear();
      email.clear();
      password.clear();
    }
  }

  void changeEmail() {

    isOtpSent.value = false;

    isOtpVerified.value = false;

    otp.clear();

    otpValue.value = '';

    otpSeconds.value = 60;

    otpTimer?.cancel();
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



    if (email.text.trim().isEmpty || password.text.trim().isEmpty) {
      AppSnack.error("Email & Password required");
      return;
    }
    if (!isChecked.value) {
      AppSnack.error("Accept Terms & Conditions");
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


  /// =========================
  /// COMMON LOGIN FLOW
  /// =========================

  final loginInput = TextEditingController();

  final mobile = TextEditingController();
  final otp = TextEditingController();

  final isEmailLogin = false.obs;
  final isMobileLogin = false.obs;

  final isOtpSent = false.obs;
  final isOtpVerified = false.obs;

  final otpValue = ''.obs;

  final otpSeconds = 60.obs;

  Timer? otpTimer;

  /// INPUT CHANGE
  void onLoginInputChanged(String value) {

    final text = value.trim();

    isEmailLogin.value = false;
    isMobileLogin.value = false;

    /// EMAIL
    if (text.contains("@")) {

      isEmailLogin.value = true;

      email.text = text;
    }

    /// MOBILE
    else if (RegExp(r'^[0-9]+$').hasMatch(text)) {

      isMobileLogin.value = true;

      mobile.text = text;
    }

    /// RESET STATES
    if (!isOtpSent.value) {

      isOtpVerified.value = false;

      otp.clear();

      otpValue.value = '';
    }
  }

  /// SEND OTP
  // Future<void> sendOtp() async {
  //
  //   final phone = mobile.text.trim();
  //
  //   if (phone.length != 10) {
  //
  //     AppSnack.error("Enter valid mobile number");
  //
  //     return;
  //   }
  //
  //   try {
  //
  //     isLoading.value = true;
  //
  //     print("📲 SEND OTP => $phone");
  //
  //     /// DUMMY API
  //     await Future.delayed(
  //       const Duration(seconds: 1),
  //     );
  //
  //     isOtpSent.value = true;
  //
  //     startOtpTimer();
  //
  //     AppSnack.success("OTP sent successfully");
  //
  //   } catch (e) {
  //
  //     AppSnack.error("Failed to send OTP");
  //
  //   } finally {
  //
  //     isLoading.value = false;
  //   }
  // }

  /// SEND OTP
  // Future<void> sendOtp() async {
  //
  //   final phone = mobile.text.trim();
  //
  //   if (phone.length != 10) {
  //
  //     AppSnack.error("Enter valid mobile number");
  //
  //     return;
  //   }
  //
  //   try {
  //
  //     isLoading.value = true;
  //
  //     print("📲 SEND OTP => $phone");
  //
  //     final response = await ApiClient.dio.post(
  //       "/api/v1/auth/login",
  //       data: {
  //         "phone": phone,
  //       },
  //     );
  //
  //     print("✅ SEND OTP RESPONSE => ${response.data}");
  //
  //     final data = response.data;
  //
  //     if (data["success"] == true) {
  //
  //       /// SAVE OTP
  //       otpValue.value = data["otp"].toString();
  //
  //       /// SHOW OTP SCREEN
  //       isOtpSent.value = true;
  //
  //       /// START TIMER
  //       startOtpTimer();
  //
  //       AppSnack.success(
  //         data["message"] ?? "OTP sent successfully",
  //       );
  //
  //     } else {
  //
  //       AppSnack.error(
  //         data["message"] ?? "Failed to send OTP",
  //       );
  //     }
  //
  //   } catch (e) {
  //
  //     print("❌ SEND OTP ERROR => $e");
  //
  //     AppSnack.error("Failed to send OTP");
  //
  //   } finally {
  //
  //     isLoading.value = false;
  //   }
  // }

  /// SEND OTP
  // Future<void> sendOtp() async {
  //
  //   final phone = mobile.text.trim();
  //
  //
  //   if (phone.length != 10) {
  //
  //     AppSnack.error("Enter valid mobile number");
  //
  //     return;
  //   }
  //   if (!isChecked.value) {
  //     AppSnack.error("Accept Terms & Conditions");
  //     return;
  //   }
  //
  //   try {
  //
  //     isLoading.value = true;
  //
  //     print("📲 SEND OTP => $phone");
  //
  //     final response = await ApiClient.dio.post(
  //       "/api/v1/auth/login",
  //       data: {
  //         "phone": phone,
  //       },
  //     );
  //
  //     print("✅ SEND OTP RESPONSE => ${response.data}");
  //
  //     final data = response.data;
  //
  //     final message =
  //     data["message"]
  //         ?.toString()
  //         .trim();
  //
  //     /// REGISTERED USER
  //     if (data["success"] == true &&
  //         message ==
  //             "OTP successfully bheja gaya.") {
  //
  //       isOtpSent.value = true;
  //
  //       startOtpTimer();
  //
  //       AppSnack.success(message ??'OTP Send successfully');
  //
  //       return;
  //     }
  //
  //     /// NOT REGISTERED
  //     if (message ==
  //         "Agar number registered hai toh OTP bhej diya gaya hai.") {
  //
  //       AppSnack.error(
  //         "Number not registered. Please contact admin.",
  //       );
  //
  //       return;
  //     }
  //
  //     AppSnack.error(
  //       message ?? "Failed to send OTP",
  //     );
  //
  //   } catch (e) {
  //
  //     print("❌ SEND OTP ERROR => $e");
  //
  //     AppSnack.error(
  //       "Failed to send OTP",
  //     );
  //
  //   } finally {
  //
  //     isLoading.value = false;
  //   }
  // }
  /// SEND OTP
  Future<void> sendOtp() async {

    final phone = mobile.text.trim();
    final emailText = email.text.trim();

    /// EMAIL LOGIN
    final isEmail = selectedLoginType.value == 0;

    /// MOBILE LOGIN
    final isMobile = selectedLoginType.value == 1;

    /// VALIDATION
    if (isMobile && phone.length != 10) {

      AppSnack.error("Enter valid mobile number");

      return;
    }

    if (isEmail && emailText.isEmpty) {

      AppSnack.error("Enter valid email");

      return;
    }

    if (!isChecked.value) {

      AppSnack.error("Accept Terms & Conditions");

      return;
    }

    try {

      isLoading.value = true;

      print("📲 SEND OTP");

      final Map<String, dynamic> body = {};

      /// EMAIL
      if (isEmail) {

        body["email"] = emailText;

      }

      /// MOBILE
      else {

        body["phone"] = phone;
      }

      final response = await ApiClient.dio.post(
        "/api/v1/auth/login",
        data: body,
      );

      print("✅ SEND OTP RESPONSE => ${response.data}");

      final data = response.data;

      final message =
      data["message"]
          ?.toString()
          .trim();

      /// SUCCESS
      if (data["success"] == true) {

        isOtpSent.value = true;

        startOtpTimer();

        AppSnack.success(
          message ?? "OTP sent successfully",
        );

        return;
      }

      /// NOT REGISTERED
      if (message ==
          "Agar number registered hai toh OTP bhej diya gaya hai.") {

        AppSnack.error(
          "Number not registered. Please contact admin.",
        );

        return;
      }

      AppSnack.error(
        message ?? "Failed to send OTP",
      );

    } catch (e) {

      print("❌ SEND OTP ERROR => $e");

      AppSnack.error(
        "Failed to send OTP",
      );

    } finally {

      isLoading.value = false;
    }
  }
  /// VERIFY OTP
  // Future<void> verifyOtp() async {
  //
  //   final phone = mobile.text.trim();
  //
  //
  //   if (otpValue.value.length != 4) {
  //
  //     AppSnack.error("Enter valid OTP");
  //
  //     return;
  //   }
  //
  //   try {
  //
  //     isLoading.value = true;
  //
  //     print("🔐 VERIFY OTP => ${otpValue.value}");
  //
  //     print("📲 SEND OTP => $phone");
  //
  //     final response = await ApiClient.dio.post(
  //       "/api/v1/auth/login",
  //       data: {
  //         "phone": phone,
  //         "otp":otpValue.value
  //       },
  //     );
  //
  //     print("✅ Verify OTP RESPONSE => ${response.data}");
  //
  //     final data = response.data;
  //
  //     // /// DUMMY API
  //     // await Future.delayed(
  //     //   const Duration(seconds: 1),
  //     // );
  //     //
  //     // isOtpVerified.value = true;
  //     //
  //     // AppSnack.success("OTP verified");
  //
  //   } catch (e) {
  //
  //     AppSnack.error("OTP verification failed");
  //
  //   } finally {
  //
  //     isLoading.value = false;
  //   }
  // }

  /// VERIFY OTP
  // Future<void> verifyOtp() async {
  //
  //   final phone = mobile.text.trim();
  //
  //   if (otpValue.value.length != 6) {
  //
  //     AppSnack.error("Enter valid 6 digit OTP");
  //
  //     return;
  //   }
  //   if (!isChecked.value) {
  //     AppSnack.error("Accept Terms & Conditions");
  //     return;
  //   }
  //
  //   try {
  //
  //     isLoading.value = true;
  //
  //     print("🔐 VERIFY OTP => ${otpValue.value}");
  //
  //     final response = await ApiClient.dio.post(
  //       "/api/v1/auth/login",
  //       data: {
  //         "phone": phone,
  //         "otp": otpValue.value,
  //       },
  //     );
  //
  //     print("✅ VERIFY OTP RESPONSE => ${response.data}");
  //
  //     final data = response.data;
  //
  //     /// INVALID OTP
  //     if (data["success"] != true) {
  //
  //       AppSnack.error(
  //         data["message"] ?? "Invalid OTP",
  //       );
  //
  //       isOtpVerified.value = false;
  //
  //       return;
  //     }
  //
  //     /// SUCCESS
  //     isOtpVerified.value = true;
  //
  //     AppSnack.success(
  //       data["message"] ?? "OTP verified successfully",
  //     );
  //
  //     /// =========================
  //     /// SAVE TOKEN
  //     /// =========================
  //
  //     final token = data["data"]?["token"];
  //
  //     if (token != null && token.toString().isNotEmpty) {
  //
  //       await _box.write("token", token);
  //
  //       ApiClient.attachToken();
  //     }
  //
  //     /// SAVE USER DATA
  //     await _box.write(
  //       "userData",
  //       data["data"],
  //     );
  //
  //     await _box.write(
  //       "userId",
  //       data["data"]?["id"],
  //     );
  //
  //     /// =========================
  //     /// ROLE HANDLE
  //     /// =========================
  //
  //     final backendRole =
  //     (data["user"]?["role"] ?? "")
  //         .toString()
  //         .toLowerCase();
  //
  //     final backendUserType =
  //     (data["user"]?["userType"] ?? "")
  //         .toString()
  //         .toLowerCase();
  //
  //     print("🔵 BACKEND ROLE => $backendRole");
  //
  //     print("🔵 BACKEND USER TYPE => $backendUserType");
  //
  //     final isAdmin =
  //         backendUserType == "admin" ||
  //             backendRole == "admin" ||
  //             backendRole == "super_admin";
  //
  //     if (isAdmin) {
  //
  //       AppSnack.success(
  //         "Logged in as Admin",
  //       );
  //
  //       return;
  //     }
  //
  //     String finalRole = role;
  //
  //     if (backendRole.contains("vendor") ||
  //         backendUserType == "retailer") {
  //
  //       finalRole = "retailer";
  //
  //     } else if (backendRole.contains("distributor") ||
  //         backendUserType == "distributor") {
  //
  //       finalRole = "distributor";
  //     }
  //
  //     await _box.write(
  //       "role",
  //       finalRole,
  //     );
  //
  //     /// =========================
  //     /// REDIRECT
  //     /// =========================
  //
  //     Future.delayed(
  //       const Duration(milliseconds: 400),
  //           () {
  //
  //         if (finalRole == "retailer") {
  //
  //           Get.offAllNamed(
  //             AppRoutes.DASH_RETAILER,
  //           );
  //
  //         } else {
  //
  //           Get.offAllNamed(
  //             AppRoutes.DASH_DISTRIBUTOR,
  //           );
  //         }
  //       },
  //     );
  //
  //   } catch (e) {
  //
  //     print("❌ VERIFY OTP ERROR => $e");
  //
  //     AppSnack.error(
  //       "Invalid OTP",
  //     );
  //
  //     isOtpVerified.value = false;
  //
  //   } finally {
  //
  //     isLoading.value = false;
  //   }
  // }
  /// VERIFY OTP
  // Future<void> verifyOtp() async {
  //
  //   final phone = mobile.text.trim();
  //   final emailText = email.text.trim();
  //
  //   final isEmail = selectedLoginType.value == 0;
  //
  //   if (otpValue.value.length != 6) {
  //
  //     AppSnack.error("Enter valid 6 digit OTP");
  //
  //     return;
  //   }
  //
  //   if (!isChecked.value) {
  //
  //     AppSnack.error("Accept Terms & Conditions");
  //
  //     return;
  //   }
  //
  //   try {
  //
  //     isLoading.value = true;
  //
  //     print("🔐 VERIFY OTP => ${otpValue.value}");
  //
  //     final Map<String, dynamic> body = {
  //       "otp": otpValue.value,
  //     };
  //
  //     /// EMAIL
  //     if (isEmail) {
  //
  //       body["email"] = emailText;
  //
  //     }
  //
  //     /// MOBILE
  //     else {
  //
  //       body["phone"] = phone;
  //     }
  //
  //     final response = await ApiClient.dio.post(
  //       "/api/v1/auth/login",
  //       data: body,
  //     );
  //
  //     print("✅ VERIFY OTP RESPONSE => ${response.data}");
  //
  //     final data = response.data;
  //
  //     /// INVALID OTP
  //     if (data["success"] != true) {
  //
  //       AppSnack.error(
  //         data["message"] ?? "Invalid OTP",
  //       );
  //
  //       isOtpVerified.value = false;
  //
  //       return;
  //     }
  //
  //     /// SUCCESS
  //     isOtpVerified.value = true;
  //
  //     AppSnack.success(
  //       data["message"] ?? "OTP verified successfully",
  //     );
  //
  //     /// SAVE TOKEN
  //     final token = data["token"];
  //
  //     if (token != null &&
  //         token.toString().isNotEmpty) {
  //
  //       await _box.write(
  //         "token",
  //         token,
  //       );
  //
  //       ApiClient.attachToken();
  //     }
  //
  //     /// SAVE USER
  //     await _box.write(
  //       "user",
  //       data["user"],
  //     );
  //
  //     final user = data["user"];
  //
  //     final backendRole =
  //     (user?["role"] ?? "")
  //         .toString()
  //         .toLowerCase();
  //
  //     final backendUserType =
  //     (user?["userType"] ?? "")
  //         .toString()
  //         .toLowerCase();
  //
  //     /// ADMIN
  //     final isAdmin =
  //         backendUserType == "admin" ||
  //             backendRole == "admin" ||
  //             backendRole == "super_admin";
  //
  //     if (isAdmin) {
  //
  //       AppSnack.success(
  //         "Logged in as Admin",
  //       );
  //
  //       return;
  //     }
  //
  //     /// ROLE
  //     String finalRole = role;
  //
  //     if (backendRole.contains("vendor") ||
  //         backendUserType == "retailer") {
  //
  //       finalRole = "retailer";
  //
  //     } else if (backendRole.contains("distributor") ||
  //         backendUserType == "distributor") {
  //
  //       finalRole = "distributor";
  //     }
  //
  //     await _box.write(
  //       "role",
  //       finalRole,
  //     );
  //
  //     /// REDIRECT
  //     Future.delayed(
  //       const Duration(milliseconds: 300),
  //           () {
  //
  //         if (finalRole == "retailer") {
  //
  //           Get.offAllNamed(
  //             AppRoutes.DASH_RETAILER,
  //           );
  //
  //         } else {
  //
  //           Get.offAllNamed(
  //             AppRoutes.DASH_DISTRIBUTOR,
  //           );
  //         }
  //       },
  //     );
  //
  //   } catch (e) {
  //
  //     print("❌ VERIFY OTP ERROR => $e");
  //
  //     AppSnack.error(
  //       "Invalid OTP",
  //     );
  //
  //     isOtpVerified.value = false;
  //
  //   } finally {
  //
  //     isLoading.value = false;
  //   }
  // }
  /// VERIFY OTP
  Future<void> verifyOtp() async {

    final phone = mobile.text.trim();
    final emailText = email.text.trim();

    final isEmail = selectedLoginType.value == 0;

    /// VALIDATION
    if (otp.text.trim().length != 6) {

      AppSnack.error("Enter valid 6 digit OTP");

      return;
    }

    if (!isChecked.value) {

      AppSnack.error("Accept Terms & Conditions");

      return;
    }

    try {

      isLoading.value = true;

      print("📧 EMAIL => $emailText");
      print("📱 PHONE => $phone");
      print("🔐 OTP => ${otp.text.trim()}");
      print("📦 LOGIN TYPE => ${selectedLoginType.value}");

      final Map<String, dynamic> body = {

        /// ✅ IMPORTANT FIX
        "otp": otp.text.trim(),
      };

      /// EMAIL LOGIN
      if (isEmail) {

        body["email"] = emailText;

      }

      /// MOBILE LOGIN
      else {

        body["phone"] = phone;
      }

      print("📤 VERIFY BODY => $body");

      final response = await ApiClient.dio.post(
        "/api/v1/auth/login",
        data: body,
      );

      print("✅ VERIFY OTP RESPONSE => ${response.data}");

      final data = response.data;

      /// INVALID OTP
      if (data["success"] != true) {

        AppSnack.error(
          data["message"] ?? "Invalid OTP",
        );

        isOtpVerified.value = false;

        return;
      }

      /// SUCCESS
      isOtpVerified.value = true;

      AppSnack.success(
        data["message"] ??
            "OTP verified successfully",
      );

      /// =========================
      /// SAVE TOKEN
      /// =========================

      final token = data["token"];

      if (token != null &&
          token.toString().isNotEmpty) {

        await _box.write(
          "token",
          token,
        );

        ApiClient.attachToken();
      }

      /// =========================
      /// SAVE USER
      /// =========================

      final user = data["user"];

      await _box.write(
        "user",
        user,
      );

      await _box.write(
        "userData",
        user,
      );

      await _box.write(
        "userId",
        user?["_id"] ?? user?["id"],
      );

      /// =========================
      /// ROLE HANDLE
      /// =========================

      final backendRole =
      (user?["role"] ?? "")
          .toString()
          .toLowerCase();

      final backendUserType =
      (user?["userType"] ?? "")
          .toString()
          .toLowerCase();

      print("🔵 BACKEND ROLE => $backendRole");

      print("🔵 BACKEND USER TYPE => $backendUserType");

      /// ADMIN
      final isAdmin =
          backendUserType == "admin" ||
              backendRole == "admin" ||
              backendRole == "super_admin";

      if (isAdmin) {

        AppSnack.success(
          "Logged in as Admin",
        );

        return;
      }

      /// FINAL ROLE
      String finalRole = role;

      if (backendRole.contains("vendor") ||
          backendUserType == "retailer") {

        finalRole = "retailer";

      } else if (backendRole.contains("distributor") ||
          backendUserType == "distributor") {

        finalRole = "distributor";
      }

      print("🟢 FINAL ROLE => $finalRole");

      await _box.write(
        "role",
        finalRole,
      );

      /// =========================
      /// REDIRECT
      /// =========================

      Future.delayed(
        const Duration(milliseconds: 300),
            () {

          if (finalRole == "retailer") {

            Get.offAllNamed(
              AppRoutes.DASH_RETAILER,
            );

          } else {

            Get.offAllNamed(
              AppRoutes.DASH_DISTRIBUTOR,
            );
          }
        },
      );

    } catch (e) {

      print("❌ VERIFY OTP ERROR => $e");

      AppSnack.error(
        "Invalid OTP. Dobara check karein.",
      );

      isOtpVerified.value = false;

    } finally {

      isLoading.value = false;
    }
  }
  /// TIMER
  void startOtpTimer() {

    otpSeconds.value = 60;

    otpTimer?.cancel();

    otpTimer = Timer.periodic(
      const Duration(seconds: 1),
          (timer) {

        if (otpSeconds.value == 0) {

          timer.cancel();

        } else {

          otpSeconds.value--;
        }
      },
    );
  }

  /// CHANGE NUMBER
  // void changeNumber() {
  //
  //   isOtpSent.value = false;
  //
  //   isOtpVerified.value = false;
  //
  //   otp.clear();
  //
  //   otpValue.value = '';
  // }

  void changeNumber() {

    isOtpSent.value = false;

    isOtpVerified.value = false;

    otp.clear();

    otpValue.value = '';

    otpSeconds.value = 60;

    otpTimer?.cancel();
  }
  /// OTP LOGIN
  void loginWithOtp() {

    if (!isChecked.value) {

      AppSnack.error("Accept Terms & Conditions");

      return;
    }

    if (!isOtpVerified.value) {

      AppSnack.error("Please verify OTP");

      return;
    }

    /// SAME REDIRECT FLOW
    if (role == "retailer") {

      Get.offAllNamed(
        AppRoutes.DASH_RETAILER,
      );

    } else {

      Get.offAllNamed(
        AppRoutes.DASH_DISTRIBUTOR,
      );
    }
  }
  //
  // @override
  // void onClose() {
  //   email.dispose();
  //   password.dispose();
  //   mobile.dispose();
  //   otp.dispose();
  //   super.onClose();
  // }

  @override
  void onClose() {

    otpTimer?.cancel();

    email.dispose();
    password.dispose();
    mobile.dispose();
    // otp.dispose();
    loginInput.dispose();

    super.onClose();
  }
}

