import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zlock_smart_finance/modules/auth/register/register_controller.dart';
import '../../../app/constants/app_colors.dart';
import '../register/register_screen.dart';
import 'login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  // Widget build(BuildContext context) {
  //   final role = controller.role;
  //
  //   return SafeArea(
  //     // bottom: false,
  //     top: false,
  //     child: Scaffold(
  //       resizeToAvoidBottomInset: true, // 🔥 Fix Overflow on Keyboard Open
  //       body: SingleChildScrollView(      // 🔥 Scrollable on keyboard open
  //         // physics: const BouncingScrollPhysics(),
  //         child: Container(
  //           width: double.infinity,
  //           height: MediaQuery.of(context).size.height, // maintain layout
  //           decoration: const BoxDecoration(
  //             gradient: AppColors.bgGradient,
  //           ),
  //           child: Column(
  //             children: [
  //
  //               const SizedBox(height: 80),
  //
  //               Image.asset("assets/images/logo.png"),
  //               // const SizedBox(height: 12),
  //
  //               // Image.asset("assets/images/LOCK.png"),
  //               // const SizedBox(height: 8),
  //
  //               // const Text(
  //               //   "Always with you",
  //               //   style: TextStyle(
  //               //     color: Colors.white,
  //               //     fontSize: 25,
  //               //   ),
  //               // ),
  //
  //               const Spacer(),
  //
  //               // White bottom card
  //               Container(
  //                 padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
  //                 decoration: const BoxDecoration(
  //                   color: Colors.white,
  //                   borderRadius: BorderRadius.only(
  //                     topLeft: Radius.circular(35),
  //                     topRight: Radius.circular(35),
  //                   ),
  //                 ),
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //
  //                     Text(
  //                       "Login as: ${role.capitalizeFirst}",
  //                       style: const TextStyle(
  //                         fontSize: 18,
  //                         fontWeight: FontWeight.w600,
  //                       ),
  //                     ),
  //
  //                     const SizedBox(height: 20),
  //
  //                     inputField(controller.email, "Email", Icons.email_outlined),
  //                     const SizedBox(height: 15),
  //
  //                     // 🔥 Password Field with Eye Icon
  //                     Obx(() => inputField(
  //                       controller.password,
  //                       "Password",
  //                       Icons.lock_outline,
  //                       isPassword: true,
  //                       isObscure: controller.isObscure.value,
  //                       onToggle: () {
  //                         controller.isObscure.value =
  //                         !controller.isObscure.value;
  //                       },
  //                     )),
  //
  //                     const SizedBox(height: 10),
  //
  //                     // Checkbox Row
  //                     Obx(() => Row(
  //                       children: [
  //                         Theme(
  //                           data: Theme.of(context).copyWith(
  //                             checkboxTheme: CheckboxThemeData(
  //                               shape: RoundedRectangleBorder(
  //                                 borderRadius: BorderRadius.circular(50),
  //                               ),
  //                             ),
  //                           ),
  //                           child: Checkbox(
  //                             value: controller.isChecked.value,
  //                             activeColor: AppColors.primary,
  //                             onChanged: (v) =>
  //                             controller.isChecked.value = v!,
  //                           ),
  //                         ),
  //                         const Expanded(
  //                           child: Text(
  //                             "By Clicking Continue, you agree to our Terms of Service and Privacy Policy.",
  //                             style: TextStyle(fontSize: 12),
  //                           ),
  //                         )
  //                       ],
  //                     )),
  //
  //                     const SizedBox(height: 15),
  //
  //                     // Button
  //                     Obx(() => SizedBox(
  //                       width: double.infinity,
  //                       height: 55,
  //                       child: ElevatedButton(
  //                         style: ElevatedButton.styleFrom(
  //                           backgroundColor: AppColors.primaryDark,
  //                           shape: RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(84),
  //                           ),
  //                         ),
  //                         onPressed: controller.isLoading.value
  //                             ? null
  //                             : controller.login,
  //                         child: controller.isLoading.value
  //                             ? const CircularProgressIndicator(
  //                             color: Colors.white)
  //                             : const Text(
  //                           "Continue",
  //                           style: TextStyle(
  //                               color: Colors.white, fontSize: 18),
  //                         ),
  //                       ),
  //                     )),
  //                     const SizedBox(height: 15),
  //
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    final role = controller.role;

    return SafeArea(
      top: false,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: AppColors.bgGradient,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 80),

                        Image.asset(
                          "assets/images/logo.png",
                          // width: MediaQuery.of(context).size.width * 0.65,
                          // fit: BoxFit.contain,
                        ),

                        const Spacer(),

                        // ✅ Bottom card
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 30,
                          ),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(35),
                              topRight: Radius.circular(35),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Text(
                              //   "Login as: ${role.capitalizeFirst}",
                              //   style: const TextStyle(
                              //     fontSize: 18,
                              //     fontWeight: FontWeight.w600,
                              //   ),
                              // ),
                              // Text(
                              //   "Login",
                              //   style: const TextStyle(
                              //     fontSize: 18,
                              //     fontWeight: FontWeight.w600,
                              //   ),
                              // ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Welcome Back 👋",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Login with your email to continue",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),

                              inputField(
                                controller.email,
                                "Email",
                                Icons.email_outlined,
                              ),
                              const SizedBox(height: 15),

                              Obx(
                                    () => inputField(
                                  controller.password,
                                  "Password",
                                  Icons.lock_outline,
                                  isPassword: true,
                                  isObscure: controller.isObscure.value,
                                  onToggle: () {
                                    controller.isObscure.value =
                                    !controller.isObscure.value;
                                  },
                                ),
                              ),

                              const SizedBox(height: 10),

                              Obx(
                                    () => Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Theme(
                                      data: Theme.of(context).copyWith(
                                        checkboxTheme: CheckboxThemeData(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(50),
                                          ),
                                        ),
                                      ),
                                      child: Checkbox(
                                        value: controller.isChecked.value,
                                        activeColor: AppColors.primary,
                                        onChanged: (v) => controller
                                            .isChecked.value = v ?? false,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    const Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 10),
                                        child: Text(
                                          "By Clicking Continue, you agree to our Terms of Service and Privacy Policy.",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 15),

                              Obx(
                                    () => SizedBox(
                                  width: double.infinity,
                                  height: 55,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primaryDark,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(84),
                                      ),
                                    ),
                                    onPressed: controller.isLoading.value
                                        ? null
                                        : controller.login,
                                    child: controller.isLoading.value
                                        ? const SizedBox(
                                      height: 22,
                                      width: 22,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.4,
                                        color: Colors.white,
                                      ),
                                    )
                                        : const Text(
                                      "Continue",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Don't have account? "),
                                  GestureDetector(
                                    onTap: () {
                                      Get.put(RegisterController()); // ✅ ADD THIS
                                      Get.to(() => const RegisterScreen());
                                    },
                                    child: const Text(
                                      "Register",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,fontSize: 16
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 20),

                              // ✅ extra bottom safe space when keyboard open
                              SizedBox(
                                height:
                                MediaQuery.of(context).viewInsets.bottom > 0
                                    ? 10
                                    : 0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
  // ***********************
  //     INPUT FIELD
  // ***********************
  Widget inputField(
      TextEditingController c,
      String label,
      IconData icon, {
        bool isPassword = false,
        bool isObscure = false,
        VoidCallback? onToggle,
      }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(48),
        border: Border.all(color: AppColors.grey.withOpacity(0.4)),
      ),
      child: TextField(
        controller: c,
        obscureText: isPassword ? isObscure : false,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: AppColors.grey),

          // 🔥 Show Eye Icon Only for Password
          suffixIcon: isPassword
              ? IconButton(
            icon: Icon(
              isObscure ? Icons.visibility_off : Icons.visibility,
              color: AppColors.grey,
            ),
            onPressed: onToggle,
          )
              : null,

          labelText: label,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
