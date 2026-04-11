import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import 'app/routes/app_routes.dart';
import 'app/services/mpin_service.dart';

import 'package:get/get.dart';

class EnterPinPage extends StatefulWidget {
  const EnterPinPage({super.key});

  @override
  State<EnterPinPage> createState() => _EnterPinPageState();
}

class _EnterPinPageState extends State<EnterPinPage> {
  final mpinService = MpinService();
  String pin = "";

  void addDigit(String value) async {
    if (pin.length < 4) {
      setState(() => pin += value);

      if (pin.length == 4) {
        await Future.delayed(const Duration(milliseconds: 200));

        final isValid = await mpinService.verifyPin(pin);

        if (isValid) {
          final role = Get.arguments?["role"];
          goToDashboard(role);
          // Get.offAllNamed(AppRoutes.ROLE);
        } else {
          Get.snackbar("Error", "Wrong PIN",
              backgroundColor: Colors.red, colorText: Colors.white);

          setState(() => pin = "");
        }
      }
    }
  }

  void removeDigit() {
    if (pin.isNotEmpty) {
      setState(() => pin = pin.substring(0, pin.length - 1));
    }
  }

  Widget buildDot(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: index < pin.length
            ? const Color(0xFF1F3BB3)
            : Colors.grey.withOpacity(0.3),
      ),
    );
  }

  Widget buildKey(String number) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: () => addDigit(number),
      child: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [Color(0xFFEEF2FF), Color(0xFFDDE5FF)],
          ),
        ),
        child: Center(
          child: Text(
            number,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBackspace() {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: removeDigit,
      child: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red.withOpacity(0.1),
        ),
        child: const Icon(Icons.backspace_outlined, color: Colors.red),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FF),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),

            /// TITLE
            const Text(
              "Enter MPIN",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Secure access to your account",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 40),

            /// PIN DOTS
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, buildDot),
            ),

            const SizedBox(height: 50),

            /// KEYPAD
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: ["1", "2", "3"].map(buildKey).toList()),
                  const SizedBox(height: 15),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: ["4", "5", "6"].map(buildKey).toList()),
                  const SizedBox(height: 15),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: ["7", "8", "9"].map(buildKey).toList()),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(width: 70),
                      buildKey("0"),
                      buildBackspace(),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            // const SizedBox(height: 20),

            // TextButton(  // 👈 yaha add
            //   onPressed: () {
            //     Get.defaultDialog(
            //       title: "Forgot MPIN?",
            //       middleText: "Do you want to reset your MPIN?",
            //       textConfirm: "Yes",
            //       textCancel: "No",
            //       confirmTextColor: Colors.white,
            //       onConfirm: () async {
            //         await mpinService.clearPin();
            //         Get.offAllNamed(AppRoutes.CREATE_MPIN);
            //       },
            //     );
            //   },
            //   child: const Text("Forgot MPIN?"),
            // ),
          ],
        ),
      ),
    );
  }
}

void goToDashboard(String? role) {
  String finalRole = role ?? "";

  if (finalRole.contains("vendor")) {
    finalRole = "retailer";
  }

  if (finalRole == "retailer") {
    Get.offAllNamed(AppRoutes.DASH_RETAILER);
  } else if (finalRole == "distributor") {
    Get.offAllNamed(AppRoutes.DASH_DISTRIBUTOR);
  } else {
    Get.offAllNamed(AppRoutes.LOGIN);
    // final role = Get.arguments?["role"];
    // goToDashboard(role);
  }
}
class CreatePinPage extends StatefulWidget {
  const CreatePinPage({super.key});

  @override
  State<CreatePinPage> createState() => _CreatePinPageState();
}

// class _CreatePinPageState extends State<CreatePinPage> {
//   final mpinService = MpinService();
//   String pin = "";
//
//   void addDigit(String value) async {
//     if (pin.length < 4) {
//       setState(() => pin += value);
//
//       if (pin.length == 4) {
//         await mpinService.savePin(pin);
//
//         // Get.offAllNamed(AppRoutes.ROLE);
//         final role = Get.arguments?["role"];
//         goToDashboard(role);
//       }
//     }
//   }
//
//   void removeDigit() {
//     if (pin.isNotEmpty) {
//       setState(() => pin = pin.substring(0, pin.length - 1));
//     }
//   }
//
//   Widget buildDot(int index) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 8),
//       width: 16,
//       height: 16,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: index < pin.length
//             ? const Color(0xFF1F3BB3)
//             : Colors.grey.withOpacity(0.3),
//       ),
//     );
//   }
//
//   Widget buildKey(String number) {
//     return InkWell(
//       onTap: () => addDigit(number),
//       child: Container(
//         height: 70,
//         width: 70,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           gradient: const LinearGradient(
//             colors: [Color(0xFFEEF2FF), Color(0xFFDDE5FF)],
//           ),
//         ),
//         child: Center(
//           child: Text(
//             number,
//             style: const TextStyle(fontSize: 24),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget buildBackspace() {
//     return InkWell(
//       onTap: removeDigit,
//       child: Container(
//         height: 70,
//         width: 70,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: Colors.red.withOpacity(0.1),
//         ),
//         child: const Icon(Icons.backspace_outlined, color: Colors.red),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF7F9FF),
//       body: SafeArea(
//         child: Column(
//           children: [
//             const SizedBox(height: 40),
//             const Text("Set MPIN",
//                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 40),
//
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: List.generate(4, buildDot),
//             ),
//
//             const SizedBox(height: 50),
//
//             Expanded(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: ["1", "2", "3"].map(buildKey).toList()),
//                   const SizedBox(height: 15),
//                   Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: ["4", "5", "6"].map(buildKey).toList()),
//                   const SizedBox(height: 15),
//                   Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: ["7", "8", "9"].map(buildKey).toList()),
//                   const SizedBox(height: 15),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       const SizedBox(width: 70),
//                       buildKey("0"),
//                       buildBackspace(),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class _CreatePinPageState extends State<CreatePinPage> {
  final mpinService = MpinService();

  String pin = "";
  String confirmPin = "";
  bool isConfirmStep = false;

  void addDigit(String value) async {
    if (!isConfirmStep) {
      /// STEP 1 → CREATE PIN
      if (pin.length < 4) {
        setState(() => pin += value);

        if (pin.length == 4) {
          await Future.delayed(const Duration(milliseconds: 200));
          setState(() => isConfirmStep = true); // 👉 move to confirm
        }
      }
    } else {
      /// STEP 2 → CONFIRM PIN
      if (confirmPin.length < 4) {
        setState(() => confirmPin += value);

        if (confirmPin.length == 4) {
          await Future.delayed(const Duration(milliseconds: 200));

          if (pin == confirmPin) {
            await mpinService.savePin(pin);

            final role = Get.arguments?["role"];
            goToDashboard(role); // ✅ no impact
          } else {
            /// ❌ mismatch
            Get.snackbar("Error", "PIN not matched",
                backgroundColor: Colors.red, colorText: Colors.white);

            setState(() {
              pin = "";
              confirmPin = "";
              isConfirmStep = false;
            });
          }
        }
      }
    }
  }

  void removeDigit() {
    if (!isConfirmStep) {
      if (pin.isNotEmpty) {
        setState(() => pin = pin.substring(0, pin.length - 1));
      }
    } else {
      if (confirmPin.isNotEmpty) {
        setState(() =>
        confirmPin = confirmPin.substring(0, confirmPin.length - 1));
      }
    }
  }

  Widget buildDot(int index) {
    final current = isConfirmStep ? confirmPin : pin;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: index < current.length
            ? const Color(0xFF1F3BB3)
            : Colors.grey.withOpacity(0.3),
      ),
    );
  }

  Widget buildKey(String number) {
    return InkWell(
      onTap: () => addDigit(number),
      child: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [Color(0xFFEEF2FF), Color(0xFFDDE5FF)],
          ),
        ),
        child: Center(
          child: Text(
            number,
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }

  Widget buildBackspace() {
    return InkWell(
      onTap: removeDigit,
      child: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red.withOpacity(0.1),
        ),
        child: const Icon(Icons.backspace_outlined, color: Colors.red),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FF),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),

            /// 🔥 TITLE CHANGE
            Text(
              isConfirmStep ? "Confirm MPIN" : "Set MPIN",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              isConfirmStep
                  ? "Re-enter your MPIN"
                  : "Create a secure MPIN",
              style: const TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 40),

            /// DOTS
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, buildDot),
            ),

            const SizedBox(height: 50),

            /// KEYPAD (same as before)
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: ["1", "2", "3"].map(buildKey).toList()),
                  const SizedBox(height: 15),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: ["4", "5", "6"].map(buildKey).toList()),
                  const SizedBox(height: 15),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: ["7", "8", "9"].map(buildKey).toList()),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(width: 70),
                      buildKey("0"),
                      buildBackspace(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppLifecycleHandler extends StatefulWidget {
  final Widget child;

  const AppLifecycleHandler({super.key, required this.child});

  @override
  _AppLifecycleHandlerState createState() => _AppLifecycleHandlerState();
}

class _AppLifecycleHandlerState extends State<AppLifecycleHandler>
    with WidgetsBindingObserver {

  final mpinService = MpinService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // ✅ important
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    /// 🔐 APP RESUME → PIN SCREEN
    if (state == AppLifecycleState.resumed) {
      final hasPin = await mpinService.hasPin();

      if (hasPin) {
        if (Get.currentRoute != AppRoutes.ENTER_MPIN) {
          Get.to(() => EnterPinPage());
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}