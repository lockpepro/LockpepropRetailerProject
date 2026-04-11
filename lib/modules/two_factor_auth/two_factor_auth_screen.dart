import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zlock_smart_finance/modules/two_factor_auth/two_factor_controller.dart';

class TwoFactorScreen extends StatelessWidget {
  final TwoFactorController ctrl = Get.put(TwoFactorController());

  TwoFactorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FF),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                )
              ],
            ),
            child: const Icon(Icons.arrow_back, color: Colors.black),
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const Text(
              "Enhance Your Security with\nTwo-Factor Authentication",
              style: TextStyle(
                fontSize: 24,
                height: 1.3,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Enhance security with Two-Factor Authentication to protect your account access.",
              style: TextStyle(
                fontSize: 15,
                height: 1.4,
                color: Color(0xFF7D8FAB),
              ),
            ),
            const SizedBox(height: 30),

            _tile(
              icon: "assets/icons/mobile.svg",
              title: "SMS Code",
              subtitle: "Receive a one-time code sent via text message to your registered phone number.",
              onTap: ctrl.onSetupSMS,
            ),

            _tile(
              icon: "assets/icons/sms.svg",
              title: "Email Verification",
              subtitle: "Receive a code sent to your registered email address for account verification.",
              onTap: ctrl.onSetupEmail,
            ),

            _tile(
              icon: "assets/icons/key.svg",
              title: "Enable Passkey",
              subtitle: "Navigate to your account settings and select the option to enable Passkey.",
              onTap: ctrl.onSetupPasskey,
            ),

            _tile(
              icon: "assets/icons/face.svg",
              title: "Enable Face ID",
              subtitle: "Secure your account with Face ID for quicker, hassle-free logins every time.",
              onTap: ctrl.onSetupFaceID,
            ),

            const SizedBox(height: 120),
          ],
        ),
      ),

      // BOTTOM SAVE BUTTON
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Obx(() {
        return Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Color(0xFFEDEFF5),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: ElevatedButton(
            onPressed: ctrl.isLoading.value ? null : () => ctrl.saveChanges(),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B5AF6),
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: ctrl.isLoading.value
                ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ))
                : const Text(
              "Save Changes",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _tile({
    required String icon,
    required String title,
    required String subtitle,
    required Function() onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      child: Row(
        children: [
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFE6ECFF),
              borderRadius: BorderRadius.circular(44),
            ),
            child: Center(
              child: SvgPicture.asset(icon, height: 22),
            ),
          ),
          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    )),
                const SizedBox(height: 4),
                Text(subtitle,
                    style: const TextStyle(
                      // height:height ,
                      fontSize: 12,
                      color: Color(0xFF7D8FAB),
                    )),
              ],
            ),
          ),

          ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1B4DAA),
              padding: const EdgeInsets.symmetric(horizontal: 15, ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              "Set Up",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
    );
  }
}
