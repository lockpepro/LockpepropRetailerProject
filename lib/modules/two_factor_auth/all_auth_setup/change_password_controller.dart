import 'package:get/get.dart';
import 'package:flutter/material.dart';

// class ChangePasswordController extends GetxController {
//   final currentPassword = TextEditingController();
//   final newPassword = TextEditingController();
//   final confirmPassword = TextEditingController();
//
//   RxBool isSaving = false.obs;
//
//   Future<void> savePassword() async {
//     if (currentPassword.text.isEmpty ||
//         newPassword.text.isEmpty ||
//         confirmPassword.text.isEmpty) {
//       Get.snackbar("Error", "All fields are required",
//           snackPosition: SnackPosition.BOTTOM);
//       return;
//     }
//
//     if (newPassword.text != confirmPassword.text) {
//       Get.snackbar("Error", "Passwords do not match",
//           snackPosition: SnackPosition.BOTTOM);
//       return;
//     }
//
//     isSaving.value = true;
//     await Future.delayed(const Duration(seconds: 2)); // Simulate API call
//     isSaving.value = false;
//
//     Get.back(); // Close dialog
//
//     Get.snackbar("Success", "Password updated successfully",
//         snackPosition: SnackPosition.BOTTOM);
//   }
//
//   @override
//   void onClose() {
//     currentPassword.dispose();
//     newPassword.dispose();
//     confirmPassword.dispose();
//     super.onClose();
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zlock_smart_finance/app/services/password_service.dart';

// class ChangePasswordController extends GetxController {
//   final currentPassword = TextEditingController(); // ✅ OTP
//   final newPassword = TextEditingController();
//   final confirmPassword = TextEditingController();
//
//   RxBool isSaving = false.obs;
//
//   final _service = PasswordService();
//   final _box = GetStorage();
//
//   Future<void> savePassword() async {
//     final otp = currentPassword.text.trim();
//     final np = newPassword.text.trim();
//     final cp = confirmPassword.text.trim();
//
//     if (otp.isEmpty || np.isEmpty || cp.isEmpty) {
//       Get.snackbar("Error", "All fields are required",
//           snackPosition: SnackPosition.BOTTOM);
//       return;
//     }
//
//     if (np != cp) {
//       Get.snackbar("Error", "Passwords do not match",
//           snackPosition: SnackPosition.BOTTOM);
//       return;
//     }
//
//     // ✅ userId required in URL
//     final userId = _box.read("userId")?.toString() ?? "";
//     if (userId.isEmpty) {
//       Get.snackbar("Error", "User not found. Please login again.",
//           snackPosition: SnackPosition.BOTTOM);
//       return;
//     }
//
//     isSaving.value = true;
//
//     final resp = await _service.changePassword(
//       userId: userId,
//       otp: otp,
//       newPassword: np,
//       confirmPassword: cp,
//     );
//
//     isSaving.value = false;
//
//     if (!resp.success) {
//       Get.snackbar("Error", resp.message,
//           snackPosition: SnackPosition.BOTTOM);
//       return;
//     }
//
//     Get.back(); // close dialog
//     Get.snackbar("Success", resp.message,
//         snackPosition: SnackPosition.BOTTOM);
//
//     // optional: clear fields
//     currentPassword.clear();
//     newPassword.clear();
//     confirmPassword.clear();
//   }
//
//   @override
//   void onClose() {
//     currentPassword.dispose();
//     newPassword.dispose();
//     confirmPassword.dispose();
//     super.onClose();
//   }
// }

// class ChangePasswordController extends GetxController {
//   final currentPassword = TextEditingController();
//   final newPassword = TextEditingController();
//   final confirmPassword = TextEditingController();
//
//   RxBool isSaving = false.obs;
//
//   final _service = PasswordService();
//
//   Future<void> savePassword() async {
//     final cp = currentPassword.text.trim();
//     final np = newPassword.text.trim();
//     final cnp = confirmPassword.text.trim();
//
//     if (cp.isEmpty || np.isEmpty || cnp.isEmpty) {
//       Get.snackbar("Error", "All fields are required",
//           snackPosition: SnackPosition.BOTTOM);
//       return;
//     }
//
//     if (np != cnp) {
//       Get.snackbar("Error", "Passwords do not match",
//           snackPosition: SnackPosition.BOTTOM);
//       return;
//     }
//
//     isSaving.value = true;
//
//     final resp = await _service.changePassword(
//       currentPassword: cp,
//       newPassword: np,
//       confirmPassword: cnp,
//     );
//
//     isSaving.value = false;
//
//     if (resp.status != 200) {
//       Get.snackbar("Error", resp.message,
//           snackPosition: SnackPosition.BOTTOM);
//       return;
//     }
//
//     // ✅ close dialog + success
//     Get.back();
//     Get.snackbar("Success", resp.message,
//         snackPosition: SnackPosition.BOTTOM);
//
//     // ✅ clear
//     currentPassword.clear();
//     newPassword.clear();
//     confirmPassword.clear();
//   }
//
//   @override
//   void onClose() {
//     currentPassword.dispose();
//     newPassword.dispose();
//     confirmPassword.dispose();
//     super.onClose();
//   }
// }

class ChangePasswordController extends GetxController {

  final currentPassword = TextEditingController();
  final newPassword = TextEditingController();
  final confirmPassword = TextEditingController();

  final isCurrentVisible = false.obs;
  final isNewVisible = false.obs;
  final isConfirmVisible = false.obs;

  RxBool isSaving = false.obs;

  final _service = PasswordService();

  Future<void> savePassword() async {

    final cp = currentPassword.text.trim();
    final np = newPassword.text.trim();
    // final cnp = confirmPassword.text.trim();

    if (cp.isEmpty || np.isEmpty ){
      Get.snackbar("Error", "All fields are required",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    // if (np != cnp) {
    //   Get.snackbar("Error", "Passwords do not match",
    //       snackPosition: SnackPosition.BOTTOM);
    //   return;
    // }

    isSaving.value = true;

    final resp = await _service.changePassword(
      currentPassword: cp,
      newPassword: np,
    );

    isSaving.value = false;

    if (!resp.success) {
      Get.snackbar("Error", resp.message,
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    Get.back();

    Get.snackbar(
      "Success",
      resp.message,
      snackPosition: SnackPosition.BOTTOM,
    );

    currentPassword.clear();
    newPassword.clear();
    confirmPassword.clear();
  }

  @override
  void onClose() {
    currentPassword.dispose();
    newPassword.dispose();
    confirmPassword.dispose();
    super.onClose();
  }
}
class ChangePasswordRetailerController extends GetxController {

  final String retailerId;

  ChangePasswordRetailerController(this.retailerId);

  final currentPassword = TextEditingController();
  final newPassword = TextEditingController();
  final confirmPassword = TextEditingController();

  final isCurrentVisible = false.obs;
  final isNewVisible = false.obs;
  final isConfirmVisible = false.obs;

  RxBool isSaving = false.obs;

  final _service = PasswordService();

  Future<void> savePassword() async {
    print("call here Save password API>>>>>>>>");

    // final cp = currentPassword.text.trim();
    final np = newPassword.text.trim();
    final cnp = confirmPassword.text.trim();

    if (np.isEmpty || cnp.isEmpty ){
      Get.snackbar("Error", "All fields are required",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    if (np != cnp) {
      Get.snackbar("Error", "Passwords do not match",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    isSaving.value = true;
    print("retailer Id >>>>>>>>>>>>>>>>>>>>>$retailerId");
    print("newPassword >>>>>>>>>>>>>>>>>>>>>$np");
    print("confirmPassword >>>>>>>>>>>>>>>>>>>>>$cnp");

    final resp = await _service.changePasswordRetailer(
      newPassword: np,
      confirmPassword: cnp,
      targetId:retailerId
    );

    isSaving.value = false;

    if (!resp.success) {
      Get.snackbar("Error", resp.message,
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    Get.back();

    Get.snackbar(
      "Success",
      resp.message,
      snackPosition: SnackPosition.BOTTOM,
    );

    currentPassword.clear();
    newPassword.clear();
    confirmPassword.clear();
  }

  @override
  void onClose() {
    currentPassword.dispose();
    newPassword.dispose();
    confirmPassword.dispose();
    super.onClose();
  }
}