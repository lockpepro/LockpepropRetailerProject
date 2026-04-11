import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zlock_smart_finance/app/constants/app_colors.dart';
import 'passkey_controller.dart';

class PasskeyScreen extends StatelessWidget {
  final PasskeyController ctrl = Get.put(PasskeyController());

  PasskeyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: Container(
          decoration: const BoxDecoration(gradient: AppColors.bgTopGradient),
          child: SafeArea(
            child: Row(
              children: [
                const SizedBox(width: 16),
                GestureDetector (
                  onTap: () => Get.back(),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        )
                      ],
                    ),
                    child: const Icon(Icons.arrow_back, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            const Text(
              "Set up your pin now for\nsecurity!",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                height: 1.3,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Choose the nation where you currently live or\nreside.",
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF7D8FAB),
                height: 1.4,
              ),
            ),

            const SizedBox(height: 40),

            // PIN INPUT DOTS
            Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(4, (index) {
                bool filled = index < ctrl.pin.value.length;
                return Container(
                  width: 79,
                  height: 52,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(48),
                    border: Border.all(color: Colors.grey.shade300, width: 2),
                  ),
                  child: Center(
                    child: filled
                        ? Container(
                      width: 14,
                      height: 14,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                    )
                        : null,
                  ),
                );
              }),
            )),

            const Spacer(),

            _numericKeyboard(),

            const SizedBox(height: 120),
          ],
        ),
      ),

      // SAVE BUTTON
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
            onPressed: ctrl.isLoading.value ? null : () => ctrl.savePasskey(),
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
              "Save",
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

  // NUMERIC KEYBOARD
  Widget _numericKeyboard() {
    final keys = [
      "1","2","3",
      "4","5","6",
      "7","8","9",
      "del","0"
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: keys.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.4,
      ),
      itemBuilder: (_, index) {
        final key = keys[index];

        if (key == "del") {
          return GestureDetector(
            onTap: () => ctrl.deleteDigit(),
            child: const Icon(Icons.backspace_outlined, size: 30),
          );
        }

        return GestureDetector(
          onTap: () => ctrl.updatePin(key),
          child: Center(
            child: Text(
              key,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      },
    );
  }
}
