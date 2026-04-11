import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zlock_smart_finance/modules/two_factor_auth/two_factor_controller.dart';

class FaceIDDialog {
  static void show() {
    final TwoFactorController ctrl = Get.put(TwoFactorController());

    Get.dialog(
      Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: Get.width * 0.85,
            padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE7EDFF),
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    "assets/icons/face_icon.svg",
                    color: const Color(0xFF3B5AF6),
                  ),
                ),

                const SizedBox(height: 22),

                const Text(
                  "Enable Face ID for\nFaster Access",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    height: 1.3,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 12),

                const Text(
                  "Secure your account with Face ID for\nquicker, hassle-free logins every time.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.4,
                    color: Color(0xFF8F96A2),
                  ),
                ),

                const SizedBox(height: 30),

                // Primary Button: Enable Face ID
                Obx(() {
                  return GestureDetector(
                    onTap: ctrl.isEnabling.value
                        ? null
                        : () => ctrl.enableFaceId(),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3B5AF6),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Center(
                        child: ctrl.isEnabling.value
                            ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                            : const Text(
                          "Yes, Enable Face ID",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  );
                }),

                const SizedBox(height: 16),

                // Secondary Button: Not Now
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F6FA),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: const Center(
                      child: Text(
                        "Not Now",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 4),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }
}
