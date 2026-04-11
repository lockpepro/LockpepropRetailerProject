import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zlock_smart_finance/modules/two_factor_auth/all_auth_setup/faceid_dialog.dart';
import 'package:zlock_smart_finance/modules/two_factor_auth/all_auth_setup/passkey_screen.dart';

class TwoFactorController extends GetxController {
  RxBool isLoading = false.obs;

  void onSetupSMS() {
    // navigate to SMS setup screen / API call
    Get.snackbar("SMS Code", "SMS setup clicked",
        snackPosition: SnackPosition.BOTTOM);
  }

  void onSetupEmail() {
    Get.snackbar("Email Verification", "Email setup clicked",
        snackPosition: SnackPosition.BOTTOM);
  }

  void onSetupPasskey() {
    Get.to(() => PasskeyScreen());

  }


  void onSetupFaceID() {
    FaceIDDialog.show();

    // Get.snackbar("Face ID", "Face ID setup clicked",
    //     snackPosition: SnackPosition.BOTTOM);
  }

  Future<void> saveChanges() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    isLoading.value = false;

    Get.snackbar("Success", "Two-Factor settings updated",
        snackPosition: SnackPosition.BOTTOM,
        snackStyle: SnackStyle.FLOATING,
        backgroundColor: const Color(0xFF3B5AF6),
        colorText: Colors.white,
        borderRadius: 12,
        margin: const EdgeInsets.all(16));
  }

  RxBool isEnabling = false.obs;

  Future<void> enableFaceId() async {
    isEnabling.value = true;

    await Future.delayed(const Duration(seconds: 2)); // API call

    isEnabling.value = false;

    Get.back(); // close dialog

    Get.snackbar(
      "Face ID Enabled",
      "Your Face ID authentication is now active.",
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
