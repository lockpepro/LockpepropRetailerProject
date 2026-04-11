import 'package:get/get.dart';
import 'package:flutter/material.dart';

class PasskeyController extends GetxController {
  RxString pin = "".obs;
  RxBool isLoading = false.obs;

  // Update each digit
  void updatePin(String value) {
    if (pin.value.length < 4) {
      pin.value += value;
    }
  }

  // Delete last digit
  void deleteDigit() {
    if (pin.value.isNotEmpty) {
      pin.value = pin.value.substring(0, pin.value.length - 1);
    }
  }

  Future<void> savePasskey() async {
    if (pin.value.length != 4) {
      Get.snackbar(
        "Error",
        "Enter a 4-digit PIN",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isLoading.value = true;

    await Future.delayed(const Duration(seconds: 2)); // API CALL HERE

    isLoading.value = false;
    Get.back(); // return to 2FA screen

    // Get.snackbar(
    //   "Success",
    //   "Passkey created successfully",
    //   snackPosition: SnackPosition.BOTTOM,
    //   backgroundColor: const Color(0xFF3B5AF6),
    //   colorText: Colors.white,
    //   borderRadius: 12,
    //   margin: const EdgeInsets.all(16),
    // );
    //
    Get.back(); // return to 2FA screen
  }
}
