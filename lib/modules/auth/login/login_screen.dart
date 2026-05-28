import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:zlock_smart_finance/modules/auth/register/register_controller.dart';
import '../../../app/constants/app_colors.dart';
import '../register/register_screen.dart';
import 'login_controller.dart';

// class LoginScreen extends GetView<LoginController> {
//   const LoginScreen({super.key});
//
//   @override
//   // Widget build(BuildContext context) {
//   //   final role = controller.role;
//   //
//   //   return SafeArea(
//   //     // bottom: false,
//   //     top: false,
//   //     child: Scaffold(
//   //       resizeToAvoidBottomInset: true, // 🔥 Fix Overflow on Keyboard Open
//   //       body: SingleChildScrollView(      // 🔥 Scrollable on keyboard open
//   //         // physics: const BouncingScrollPhysics(),
//   //         child: Container(
//   //           width: double.infinity,
//   //           height: MediaQuery.of(context).size.height, // maintain layout
//   //           decoration: const BoxDecoration(
//   //             gradient: AppColors.bgGradient,
//   //           ),
//   //           child: Column(
//   //             children: [
//   //
//   //               const SizedBox(height: 80),
//   //
//   //               Image.asset("assets/images/logo.png"),
//   //               // const SizedBox(height: 12),
//   //
//   //               // Image.asset("assets/images/LOCK.png"),
//   //               // const SizedBox(height: 8),
//   //
//   //               // const Text(
//   //               //   "Always with you",
//   //               //   style: TextStyle(
//   //               //     color: Colors.white,
//   //               //     fontSize: 25,
//   //               //   ),
//   //               // ),
//   //
//   //               const Spacer(),
//   //
//   //               // White bottom card
//   //               Container(
//   //                 padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
//   //                 decoration: const BoxDecoration(
//   //                   color: Colors.white,
//   //                   borderRadius: BorderRadius.only(
//   //                     topLeft: Radius.circular(35),
//   //                     topRight: Radius.circular(35),
//   //                   ),
//   //                 ),
//   //                 child: Column(
//   //                   crossAxisAlignment: CrossAxisAlignment.start,
//   //                   children: [
//   //
//   //                     Text(
//   //                       "Login as: ${role.capitalizeFirst}",
//   //                       style: const TextStyle(
//   //                         fontSize: 18,
//   //                         fontWeight: FontWeight.w600,
//   //                       ),
//   //                     ),
//   //
//   //                     const SizedBox(height: 20),
//   //
//   //                     inputField(controller.email, "Email", Icons.email_outlined),
//   //                     const SizedBox(height: 15),
//   //
//   //                     // 🔥 Password Field with Eye Icon
//   //                     Obx(() => inputField(
//   //                       controller.password,
//   //                       "Password",
//   //                       Icons.lock_outline,
//   //                       isPassword: true,
//   //                       isObscure: controller.isObscure.value,
//   //                       onToggle: () {
//   //                         controller.isObscure.value =
//   //                         !controller.isObscure.value;
//   //                       },
//   //                     )),
//   //
//   //                     const SizedBox(height: 10),
//   //
//   //                     // Checkbox Row
//   //                     Obx(() => Row(
//   //                       children: [
//   //                         Theme(
//   //                           data: Theme.of(context).copyWith(
//   //                             checkboxTheme: CheckboxThemeData(
//   //                               shape: RoundedRectangleBorder(
//   //                                 borderRadius: BorderRadius.circular(50),
//   //                               ),
//   //                             ),
//   //                           ),
//   //                           child: Checkbox(
//   //                             value: controller.isChecked.value,
//   //                             activeColor: AppColors.primary,
//   //                             onChanged: (v) =>
//   //                             controller.isChecked.value = v!,
//   //                           ),
//   //                         ),
//   //                         const Expanded(
//   //                           child: Text(
//   //                             "By Clicking Continue, you agree to our Terms of Service and Privacy Policy.",
//   //                             style: TextStyle(fontSize: 12),
//   //                           ),
//   //                         )
//   //                       ],
//   //                     )),
//   //
//   //                     const SizedBox(height: 15),
//   //
//   //                     // Button
//   //                     Obx(() => SizedBox(
//   //                       width: double.infinity,
//   //                       height: 55,
//   //                       child: ElevatedButton(
//   //                         style: ElevatedButton.styleFrom(
//   //                           backgroundColor: AppColors.primaryDark,
//   //                           shape: RoundedRectangleBorder(
//   //                             borderRadius: BorderRadius.circular(84),
//   //                           ),
//   //                         ),
//   //                         onPressed: controller.isLoading.value
//   //                             ? null
//   //                             : controller.login,
//   //                         child: controller.isLoading.value
//   //                             ? const CircularProgressIndicator(
//   //                             color: Colors.white)
//   //                             : const Text(
//   //                           "Continue",
//   //                           style: TextStyle(
//   //                               color: Colors.white, fontSize: 18),
//   //                         ),
//   //                       ),
//   //                     )),
//   //                     const SizedBox(height: 15),
//   //
//   //                   ],
//   //                 ),
//   //               ),
//   //             ],
//   //           ),
//   //         ),
//   //       ),
//   //     ),
//   //   );
//   // }
//   @override
//   Widget build(BuildContext context) {
//     final role = controller.role;
//
//     return SafeArea(
//       top: false,
//       child: Scaffold(
//         resizeToAvoidBottomInset: true,
//         body: LayoutBuilder(
//           builder: (context, constraints) {
//             return SingleChildScrollView(
//               keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
//               child: ConstrainedBox(
//                 constraints: BoxConstraints(minHeight: constraints.maxHeight),
//                 child: IntrinsicHeight(
//                   child: Container(
//                     width: double.infinity,
//                     decoration: const BoxDecoration(
//                       gradient: AppColors.bgGradient,
//                     ),
//                     child: Column(
//                       children: [
//                         const SizedBox(height: 80),
//
//                         Image.asset(
//                           "assets/images/logo.png",
//                           // width: MediaQuery.of(context).size.width * 0.65,
//                           // fit: BoxFit.contain,
//                         ),
//
//                         const Spacer(),
//
//                         // ✅ Bottom card
//                         Container(
//                           width: double.infinity,
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 20,
//                             vertical: 30,
//                           ),
//                           decoration: const BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(35),
//                               topRight: Radius.circular(35),
//                             ),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               // Text(
//                               //   "Login as: ${role.capitalizeFirst}",
//                               //   style: const TextStyle(
//                               //     fontSize: 18,
//                               //     fontWeight: FontWeight.w600,
//                               //   ),
//                               // ),
//                               // Text(
//                               //   "Login",
//                               //   style: const TextStyle(
//                               //     fontSize: 18,
//                               //     fontWeight: FontWeight.w600,
//                               //   ),
//                               // ),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     "Welcome Back 👋",
//                                     style: TextStyle(
//                                       fontSize: 22,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   SizedBox(height: 5),
//                                   Text(
//                                     "Login with your email to continue",
//                                     style: TextStyle(
//                                       fontSize: 14,
//                                       color: Colors.grey,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 20),
//
//                               inputField(
//                                 controller.email,
//                                 "Email",
//                                 Icons.email_outlined,
//                               ),
//                               const SizedBox(height: 15),
//
//                               Obx(
//                                     () => inputField(
//                                   controller.password,
//                                   "Password",
//                                   Icons.lock_outline,
//                                   isPassword: true,
//                                   isObscure: controller.isObscure.value,
//                                   onToggle: () {
//                                     controller.isObscure.value =
//                                     !controller.isObscure.value;
//                                   },
//                                 ),
//                               ),
//
//                               const SizedBox(height: 10),
//
//                               Obx(
//                                     () => Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Theme(
//                                       data: Theme.of(context).copyWith(
//                                         checkboxTheme: CheckboxThemeData(
//                                           shape: RoundedRectangleBorder(
//                                             borderRadius:
//                                             BorderRadius.circular(50),
//                                           ),
//                                         ),
//                                       ),
//                                       child: Checkbox(
//                                         value: controller.isChecked.value,
//                                         activeColor: AppColors.primary,
//                                         onChanged: (v) => controller
//                                             .isChecked.value = v ?? false,
//                                       ),
//                                     ),
//                                     const SizedBox(width: 6),
//                                     const Expanded(
//                                       child: Padding(
//                                         padding: EdgeInsets.only(top: 10),
//                                         child: Text(
//                                           "By Clicking Continue, you agree to our Terms of Service and Privacy Policy.",
//                                           style: TextStyle(fontSize: 12),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//
//                               const SizedBox(height: 15),
//
//                               Obx(
//                                     () => SizedBox(
//                                   width: double.infinity,
//                                   height: 55,
//                                   child: ElevatedButton(
//                                     style: ElevatedButton.styleFrom(
//                                       backgroundColor: AppColors.primaryDark,
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(84),
//                                       ),
//                                     ),
//                                     onPressed: controller.isLoading.value
//                                         ? null
//                                         : controller.login,
//                                     child: controller.isLoading.value
//                                         ? const SizedBox(
//                                       height: 22,
//                                       width: 22,
//                                       child: CircularProgressIndicator(
//                                         strokeWidth: 2.4,
//                                         color: Colors.white,
//                                       ),
//                                     )
//                                         : const Text(
//                                       "Continue",
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 18,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(height: 10),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   const Text("Don't have account? "),
//                                   GestureDetector(
//                                     onTap: () {
//                                       Get.put(RegisterController()); // ✅ ADD THIS
//                                       Get.to(() => const RegisterScreen());
//                                     },
//                                     child: const Text(
//                                       "Register",
//                                       style: TextStyle(
//                                         color: Colors.blue,
//                                         fontWeight: FontWeight.bold,fontSize: 16
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                               const SizedBox(height: 20),
//
//                               // ✅ extra bottom safe space when keyboard open
//                               SizedBox(
//                                 height:
//                                 MediaQuery.of(context).viewInsets.bottom > 0
//                                     ? 10
//                                     : 0,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//   // ***********************
//   //     INPUT FIELD
//   // ***********************
//   Widget inputField(
//       TextEditingController c,
//       String label,
//       IconData icon, {
//         bool isPassword = false,
//         bool isObscure = false,
//         VoidCallback? onToggle,
//       }) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(48),
//         border: Border.all(color: AppColors.grey.withOpacity(0.4)),
//       ),
//       child: TextField(
//         controller: c,
//         obscureText: isPassword ? isObscure : false,
//         decoration: InputDecoration(
//           prefixIcon: Icon(icon, color: AppColors.grey),
//
//           // 🔥 Show Eye Icon Only for Password
//           suffixIcon: isPassword
//               ? IconButton(
//             icon: Icon(
//               isObscure ? Icons.visibility_off : Icons.visibility,
//               color: AppColors.grey,
//             ),
//             onPressed: onToggle,
//           )
//               : null,
//
//           labelText: label,
//           border: InputBorder.none,
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../app/constants/app_colors.dart';
import '../../../app/services/snckbar.dart';
import '../register/register_controller.dart';
import '../register/register_screen.dart';
import 'login_controller.dart';

// class LoginScreen extends GetView<LoginController> {
//   const LoginScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       top: false,
//       child: Scaffold(
//         resizeToAvoidBottomInset: true,
//         body: LayoutBuilder(
//           builder: (context, constraints) {
//             return SingleChildScrollView(
//               keyboardDismissBehavior:
//               ScrollViewKeyboardDismissBehavior.onDrag,
//               child: ConstrainedBox(
//                 constraints:
//                 BoxConstraints(minHeight: constraints.maxHeight),
//                 child: IntrinsicHeight(
//                   child: Container(
//                     width: double.infinity,
//                     decoration: const BoxDecoration(
//                       gradient: AppColors.bgGradient,
//                     ),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         const SizedBox(height: 80),
//
//                         Image.asset(
//                           "assets/images/logo.png",
//                         ),
//
//                         const Spacer(),
//
//                         /// =========================
//                         /// BOTTOM CARD
//                         /// =========================
//
//                         Container(
//                           width: double.infinity,
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 20,
//                             vertical: 30,
//                           ),
//                           decoration: const BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(35),
//                               topRight: Radius.circular(35),
//                             ),
//                           ),
//                           child: Column(
//                             crossAxisAlignment:
//                             CrossAxisAlignment.start,
//                             children: [
//
//                               /// TITLE
//                               Column(
//                                 crossAxisAlignment:
//                                 CrossAxisAlignment.start,
//                                 children: [
//
//                                   const Text(
//                                     "Welcome Back 👋",
//                                     style: TextStyle(
//                                       fontSize: 24,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//
//                                   const SizedBox(height: 15),
//
//                                   // Obx(
//                                   //       () => Text(
//                                   //     controller.isMobileLogin.value
//                                   //         ? "Login with mobile OTP to continue"
//                                   //         : "Login with your email to continue",
//                                   //     style: const TextStyle(
//                                   //       fontSize: 14,
//                                   //       color: Colors.grey,
//                                   //     ),
//                                   //   ),
//                                   // ),
//                                   Text(
//                                      "Login to continue",
//                                     style: const TextStyle(
//                                       fontSize: 14,
//                                       color: Colors.grey,
//                                     ),),
//                                   const SizedBox(height: 45),
//
//
//                                 ],
//                               ),
//
//
//                               /// =========================
//                               /// LOGIN INPUT
//                               /// =========================
//
//                               Obx(
//                                     () => !controller.isOtpSent.value
//                                     ? inputField(
//                                   controller.loginInput,
//                                   "Email or Mobile Number",
//                                   Icons.person_outline,
//                                   keyboardType:
//                                   controller
//                                       .isMobileLogin
//                                       .value
//                                       ? TextInputType.number
//                                       : TextInputType.emailAddress,
//                                   maxLength:
//                                   controller
//                                       .isMobileLogin
//                                       .value
//                                       ? 10
//                                       : null,
//                                   onChanged:
//                                   controller
//                                       .onLoginInputChanged,
//                                 )
//                                     : const SizedBox(),
//                               ),
//
//                               /// =========================
//                               /// EMAIL PASSWORD FLOW
//                               /// =========================
//
//                               Obx(
//                                     () => controller
//                                     .isEmailLogin.value
//                                     ? Column(
//                                   children: [
//
//                                     const SizedBox(
//                                         height: 15),
//
//                                     inputField(
//                                       controller.password,
//                                       "Password",
//                                       Icons.lock_outline,
//                                       isPassword: true,
//                                       isObscure: controller
//                                           .isObscure
//                                           .value,
//                                       onToggle: () {
//                                         controller
//                                             .isObscure
//                                             .value =
//                                         !controller
//                                             .isObscure
//                                             .value;
//                                       },
//                                     ),
//
//                                     const SizedBox(
//                                         height: 20),
//
//                                     mainButton(
//                                       title: "Continue",
//                                       onTap: controller
//                                           .isLoading
//                                           .value
//                                           ? null
//                                           : controller
//                                           .login,
//                                       loading: controller
//                                           .isLoading
//                                           .value,
//                                     ),
//                                   ],
//                                 )
//                                     : const SizedBox(),
//                               ),
//
//                               /// =========================
//                               /// MOBILE OTP FLOW
//                               /// =========================
//
//                               Obx(
//                                     () => controller
//                                     .isMobileLogin.value
//                                     ? Column(
//                                   children: [
//
//                                     const SizedBox(
//                                         height: 15),
//
//                                     /// SEND OTP BUTTON
//                                     if (!controller
//                                         .isOtpSent
//                                         .value)
//
//                                       mainButton(
//                                         title: "Send OTP",
//                                         onTap: controller
//                                             .isLoading
//                                             .value
//                                             ? null
//                                             : controller
//                                             .sendOtp,
//                                         loading: controller
//                                             .isLoading
//                                             .value,
//                                       ),
//
//                                     /// OTP SCREEN
//                                     if (controller
//                                         .isOtpSent
//                                         .value)
//
//                                       Column(
//                                         children: [
//
//                                           Row(
//                                             children: [
//
//                                               Expanded(
//                                                 child:
//                                                 RichText(
//                                                   text:
//                                                   TextSpan(
//                                                     style:
//                                                     const TextStyle(
//                                                       color:
//                                                       Colors.black,
//                                                       fontSize:
//                                                       15,
//                                                     ),
//                                                     children: [
//
//                                                       const TextSpan(
//                                                         text:
//                                                         "OTP sent to ",
//                                                       ),
//
//                                                       TextSpan(
//                                                         text:
//                                                         "+91 ${controller.mobile.text}",
//                                                         style:
//                                                         const TextStyle(
//                                                           fontWeight:
//                                                           FontWeight.bold,
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//
//                                               TextButton(
//                                                 onPressed:
//                                                 controller.changeNumber,
//                                                 child:
//                                                 const Text(
//                                                   "Change",
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//
//                                           const SizedBox(
//                                               height: 20),
//
//                                           /// OTP BOXES
//                                           PinCodeTextField(
//                                             appContext:
//                                             context,
//                                             length: 4,
//                                             // controller:
//                                             // controller
//                                             //     .otp,
//                                             keyboardType:
//                                             TextInputType
//                                                 .number,
//                                             animationType:
//                                             AnimationType
//                                                 .fade,
//                                             enableActiveFill:
//                                             true,
//                                             cursorColor:
//                                             AppColors
//                                                 .primaryDark,
//                                             inputFormatters: [
//                                               FilteringTextInputFormatter
//                                                   .digitsOnly,
//                                             ],
//
//                                             // onChanged:
//                                             //     (value) {
//                                             //   controller
//                                             //       .otpValue
//                                             //       .value =
//                                             //       value;
//                                             // },
//                                             onChanged: (value) {
//
//                                               controller.otpValue.value = value;
//
//                                               controller.otp.text = value;
//                                             },
//
//                                             pinTheme:
//                                             PinTheme(
//                                               shape:
//                                               PinCodeFieldShape
//                                                   .box,
//                                               borderRadius:
//                                               BorderRadius
//                                                   .circular(
//                                                 16,
//                                               ),
//                                               fieldHeight:
//                                               60,
//                                               fieldWidth:
//                                               60,
//                                               activeColor:
//                                               AppColors
//                                                   .primaryDark,
//                                               selectedColor:
//                                               AppColors
//                                                   .primaryDark,
//                                               inactiveColor:
//                                               Colors.grey
//                                                   .shade300,
//                                               activeFillColor:
//                                               Colors.white,
//                                               selectedFillColor:
//                                               Colors.white,
//                                               inactiveFillColor:
//                                               Colors.white,
//                                             ),
//                                           ),
//
//                                           const SizedBox(
//                                               height: 5),
//
//                                           /// TIMER
//                                           Obx(
//                                                 () => controller
//                                                 .otpSeconds
//                                                 .value ==
//                                                 0
//                                                 ? TextButton(
//                                               onPressed:
//                                               controller
//                                                   .sendOtp,
//                                               child:
//                                               const Text(
//                                                 "Resend OTP",
//                                               ),
//                                             )
//                                                 : Text(
//                                               "Resend OTP in 00:${controller.otpSeconds.value.toString().padLeft(2, '0')}",
//                                               style:
//                                               TextStyle(
//                                                 color: Colors
//                                                     .grey
//                                                     .shade600,
//                                               ),
//                                             ),
//                                           ),
//
//                                           const SizedBox(
//                                               height: 18),
//
//                                           /// VERIFY BUTTON
//                                           mainButton(
//                                             title: controller
//                                                 .isOtpVerified
//                                                 .value
//                                                 ? "OTP Verified ✓"
//                                                 : "Verify OTP",
//                                             backgroundColor:
//                                             controller
//                                                 .otpValue
//                                                 .value
//                                                 .length ==
//                                                 4
//                                                 ? Colors
//                                                 .green
//                                                 : Colors
//                                                 .grey,
//                                             onTap: controller
//                                                 .otpValue
//                                                 .value
//                                                 .length ==
//                                                 4
//                                                 ? controller
//                                                 .verifyOtp
//                                                 : null,
//                                           ),
//
//                                           /// CONTINUE BUTTON
//                                           if (controller
//                                               .isOtpVerified
//                                               .value) ...[
//
//                                             const SizedBox(
//                                                 height:
//                                                 15),
//
//                                             mainButton(
//                                               title:
//                                               "Continue",
//                                               onTap:
//                                               controller
//                                                   .loginWithOtp,
//                                             ),
//                                           ],
//                                         ],
//                                       ),
//                                   ],
//                                 )
//                                     : const SizedBox(),
//                               ),
//
//                               const SizedBox(height: 15),
//
//                               /// TERMS
//                               Obx(
//                                     () => Row(
//                                   crossAxisAlignment:
//                                   CrossAxisAlignment
//                                       .start,
//                                   children: [
//
//                                     Theme(
//                                       data: Theme.of(
//                                           context)
//                                           .copyWith(
//                                         checkboxTheme:
//                                         CheckboxThemeData(
//                                           shape:
//                                           RoundedRectangleBorder(
//                                             borderRadius:
//                                             BorderRadius.circular(
//                                               50,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       child:
//                                       Checkbox(
//                                         value: controller
//                                             .isChecked
//                                             .value,
//                                         activeColor:
//                                         AppColors
//                                             .primary,
//                                         onChanged:
//                                             (v) {
//                                           controller
//                                               .isChecked
//                                               .value =
//                                               v ??
//                                                   false;
//                                         },
//                                       ),
//                                     ),
//
//                                     const SizedBox(
//                                         width: 6),
//
//                                     const Expanded(
//                                       child:
//                                       Padding(
//                                         padding:
//                                         EdgeInsets.only(
//                                           top: 10,
//                                         ),
//                                         child:
//                                         Text(
//                                           "By Clicking Continue, you agree to our Terms of Service and Privacy Policy.",
//                                           style:
//                                           TextStyle(
//                                             fontSize:
//                                             12,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//
//                               const SizedBox(height: 45),
//
//                               /// REGISTER
//                               Row(
//                                 mainAxisAlignment:
//                                 MainAxisAlignment
//                                     .center,
//                                 children: [
//
//                                   const Text(
//                                     "Don't have account? ",
//                                   ),
//
//                                   GestureDetector(
//                                     onTap: () {
//
//                                       Get.put(
//                                         RegisterController(),
//                                       );
//
//                                       Get.to(
//                                             () =>
//                                         const RegisterScreen(),
//                                       );
//                                     },
//                                     child:
//                                     const Text(
//                                       "Register",
//                                       style:
//                                       TextStyle(
//                                         color: Colors.blue,
//                                         fontWeight:
//                                         FontWeight.bold,
//                                         fontSize: 16,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//
//                               const SizedBox(height: 20),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   /// =========================
//   /// INPUT FIELD
//   /// =========================
//
//   Widget inputField(
//       TextEditingController c,
//       String label,
//       IconData icon, {
//         bool isPassword = false,
//         bool isObscure = false,
//         VoidCallback? onToggle,
//         TextInputType keyboardType =
//             TextInputType.text,
//         int? maxLength,
//         Function(String)? onChanged,
//       }) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius:
//         BorderRadius.circular(48),
//         border: Border.all(
//           color:
//           AppColors.grey.withOpacity(0.4),
//         ),
//       ),
//       child: TextField(
//         controller: c,
//         obscureText:
//         isPassword ? isObscure : false,
//         keyboardType: keyboardType,
//         maxLength: maxLength,
//         onChanged: onChanged,
//         inputFormatters:
//         keyboardType ==
//             TextInputType.number
//             ? [
//           FilteringTextInputFormatter
//               .digitsOnly,
//         ]
//             : null,
//         decoration: InputDecoration(
//           counterText: "",
//           prefixIcon:
//           Icon(icon, color: AppColors.grey),
//
//           suffixIcon: isPassword
//               ? IconButton(
//             icon: Icon(
//               isObscure
//                   ? Icons.visibility_off
//                   : Icons.visibility,
//               color:
//               AppColors.grey,
//             ),
//             onPressed: onToggle,
//           )
//               : null,
//
//           labelText: label,
//
//           contentPadding:
//           const EdgeInsets.symmetric(
//             vertical: 18,
//           ),
//
//           border: InputBorder.none,
//         ),
//       ),
//     );
//   }
//
//   /// =========================
//   /// MAIN BUTTON
//   /// =========================
//
//   Widget mainButton({
//     required String title,
//     required VoidCallback? onTap,
//     bool loading = false,
//     Color? backgroundColor,
//   }) {
//     return SizedBox(
//       width: double.infinity,
//       height: 55,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor:
//           backgroundColor ??
//               AppColors.primaryDark,
//           shape: RoundedRectangleBorder(
//             borderRadius:
//             BorderRadius.circular(84),
//           ),
//         ),
//         onPressed: onTap,
//         child: loading
//             ? const SizedBox(
//           height: 22,
//           width: 22,
//           child:
//           CircularProgressIndicator(
//             strokeWidth: 2.4,
//             color: Colors.white,
//           ),
//         )
//             : Text(
//           title,
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 18,
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../app/constants/app_colors.dart';
import '../register/register_controller.dart';
import '../register/register_screen.dart';
import 'login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          keyboardDismissBehavior:
          ScrollViewKeyboardDismissBehavior.onDrag,
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: AppColors.bgGradient,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // const SizedBox(height: 80),

                /// LOGO
                Image.asset(
                  "assets/images/logo.png",
                ),

                // const SizedBox(height: 40),

                /// WHITE CARD
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
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [

                      /// TITLE
                      const Text(
                        "Welcome Back 👋",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 6),

                      const Text(
                        "Login to continue",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),

                      const SizedBox(height: 10),

                      /// =========================
                      /// PREMIUM TOGGLE MOBILE OTP COMMENT FOR NOW
                      /// =========================

                      Obx(
                            () => Container(
                          height: 52,
                          padding:
                          const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color:
                            Colors.grey.shade100,
                            borderRadius:
                            BorderRadius.circular(
                              40,
                            ),
                          ),
                          child: Row(
                            children: [

                              /// EMAIL
                              Expanded(
                                child:
                                GestureDetector(
                                  onTap: () {
                                    controller
                                        .switchLoginType(
                                      0,
                                    );
                                  },
                                  child:
                                  AnimatedContainer(
                                    duration:
                                    const Duration(
                                      milliseconds:
                                      250,
                                    ),
                                    alignment:
                                    Alignment
                                        .center,
                                    decoration:
                                    BoxDecoration(
                                      color: controller
                                          .selectedLoginType
                                          .value ==
                                          0
                                          ? AppColors
                                          .primaryDark
                                          : Colors
                                          .transparent,
                                      borderRadius:
                                      BorderRadius
                                          .circular(
                                        40,
                                      ),
                                    ),
                                    child: Text(
                                      "Email",
                                      style:
                                      TextStyle(
                                        color: controller
                                            .selectedLoginType
                                            .value ==
                                            0
                                            ? Colors
                                            .white
                                            : Colors
                                            .black,
                                        fontWeight:
                                        FontWeight
                                            .w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              /// MOBILE
                              Expanded(
                                child:
                                GestureDetector(
                                  onTap: () {
                                    controller
                                        .switchLoginType(
                                      1,
                                    );
                                  },
                                  child:
                                  AnimatedContainer(
                                    duration:
                                    const Duration(
                                      milliseconds:
                                      250,
                                    ),
                                    alignment:
                                    Alignment
                                        .center,
                                    decoration:
                                    BoxDecoration(
                                      color: controller
                                          .selectedLoginType
                                          .value ==
                                          1
                                          ? AppColors
                                          .primaryDark
                                          : Colors
                                          .transparent,
                                      borderRadius:
                                      BorderRadius
                                          .circular(
                                        40,
                                      ),
                                    ),
                                    child: Text(
                                      "Mobile OTP",
                                      style:
                                      TextStyle(
                                        color: controller
                                            .selectedLoginType
                                            .value ==
                                            1
                                            ? Colors
                                            .white
                                            : Colors
                                            .black,
                                        fontWeight:
                                        FontWeight
                                            .w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),

                      /// =========================
                      /// EMAIL FLOW
                      /// =========================

                      // Obx(
                      //       () => controller
                      //       .isEmailLogin.value
                      //       ? Column(
                      //     children: [
                      //
                      //       inputField(
                      //         controller.email,
                      //         "Email Address",
                      //         Icons
                      //             .email_outlined,
                      //         keyboardType:
                      //         TextInputType
                      //             .emailAddress,
                      //       ),
                      //
                      //       const SizedBox(
                      //         height: 15,
                      //       ),
                      //       if (controller.isOtpSent.value) ...[
                      //
                      //         const SizedBox(height: 20),
                      //
                      //         PinCodeTextField(
                      //           appContext: context,
                      //           length: 6,
                      //           keyboardType: TextInputType.number,
                      //           animationType: AnimationType.fade,
                      //           enableActiveFill: true,
                      //           cursorColor: AppColors.primaryDark,
                      //           inputFormatters: [
                      //             FilteringTextInputFormatter.digitsOnly,
                      //           ],
                      //           onChanged: (value) {
                      //
                      //             controller.otpValue.value = value;
                      //
                      //           },
                      //           pinTheme: PinTheme(
                      //             shape: PinCodeFieldShape.box,
                      //             borderRadius: BorderRadius.circular(16),
                      //             fieldHeight: 54,
                      //             fieldWidth: 48,
                      //             activeColor: AppColors.primaryDark,
                      //             selectedColor: AppColors.primaryDark,
                      //             inactiveColor: Colors.grey.shade300,
                      //             activeFillColor: Colors.white,
                      //             selectedFillColor: Colors.white,
                      //             inactiveFillColor: Colors.white,
                      //           ),
                      //         ),
                      //
                      //         const SizedBox(height: 14),
                      //       ],
                      //
                      //       // inputField(
                      //       //   controller
                      //       //       .password,
                      //       //   "Password",
                      //       //   Icons
                      //       //       .lock_outline,
                      //       //   isPassword:
                      //       //   true,
                      //       //   isObscure:
                      //       //   controller
                      //       //       .isObscure
                      //       //       .value,
                      //       //   onToggle: () {
                      //       //     controller
                      //       //         .isObscure
                      //       //         .value =
                      //       //     !controller
                      //       //         .isObscure
                      //       //         .value;
                      //       //   },
                      //       // ),
                      //
                      //       const SizedBox(
                      //         height: 22,
                      //       ),
                      //
                      //       mainButton(
                      //         // title:
                      //         // "Continue",
                      //         // loading:
                      //         // controller
                      //         //     .isLoading
                      //         //     .value,
                      //         // onTap: controller
                      //         //     .isLoading
                      //         //     .value
                      //         //     ? null
                      //         //     : controller
                      //         //     .login,
                      //         title: controller.isOtpSent.value
                      //             ? "Verify OTP"
                      //             : "Send OTP",
                      //
                      //         onTap: controller.isOtpSent.value
                      //             ? controller.verifyOtp
                      //             : controller.sendOtp,
                      //       ),
                      //     ],
                      //   )
                      //       : const SizedBox(),
                      // ),

                      // /// =========================
                      // /// EMAIL FLOW
                      // /// =========================
                      //
                      // Obx(
                      //       () => controller.isEmailLogin.value
                      //       ? Column(
                      //     children: [
                      //
                      //       /// EMAIL FIELD
                      //       if (!controller.isOtpSent.value) ...[
                      //
                      //         inputField(
                      //           controller.email,
                      //           "Email Address",
                      //           Icons.email_outlined,
                      //           keyboardType:
                      //           TextInputType.emailAddress,
                      //         ),
                      //
                      //         const SizedBox(
                      //           height: 22,
                      //         ),
                      //
                      //         mainButton(
                      //           title: "Send OTP",
                      //           loading:
                      //           controller.isLoading.value,
                      //           onTap: controller
                      //               .isLoading.value
                      //               ? null
                      //               : controller.sendOtp,
                      //         ),
                      //       ],
                      //
                      //       /// OTP SCREEN
                      //       if (controller.isOtpSent.value) ...[
                      //
                      //         Row(
                      //           children: [
                      //
                      //             Expanded(
                      //               child: RichText(
                      //                 text: TextSpan(
                      //                   style: const TextStyle(
                      //                     color: Colors.black,
                      //                     fontSize: 15,
                      //                   ),
                      //                   children: [
                      //
                      //                     const TextSpan(
                      //                       text: "OTP sent to ",
                      //                     ),
                      //
                      //                     TextSpan(
                      //                       text:
                      //                       controller.email.text,
                      //                       style:
                      //                       const TextStyle(
                      //                         fontWeight:
                      //                         FontWeight.bold,
                      //                       ),
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //             ),
                      //
                      //             TextButton(
                      //               onPressed:
                      //               controller.changeEmail,
                      //               child: const Text(
                      //                 "Change",
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //
                      //         const SizedBox(height: 20),
                      //
                      //         /// OTP BOXES
                      //         PinCodeTextField(
                      //           appContext: context,
                      //           length: 6,
                      //           keyboardType:
                      //           TextInputType.number,
                      //           animationType:
                      //           AnimationType.fade,
                      //           enableActiveFill: true,
                      //           cursorColor:
                      //           AppColors.primaryDark,
                      //           inputFormatters: [
                      //             FilteringTextInputFormatter
                      //                 .digitsOnly,
                      //           ],
                      //           onChanged: (value) {
                      //
                      //             controller.otpValue.value =
                      //                 value;
                      //
                      //             controller.otp.text =
                      //                 value;
                      //           },
                      //           pinTheme: PinTheme(
                      //             shape:
                      //             PinCodeFieldShape.box,
                      //             borderRadius:
                      //             BorderRadius.circular(
                      //               16,
                      //             ),
                      //             fieldHeight: 54,
                      //             fieldWidth: 48,
                      //             activeColor:
                      //             AppColors.primaryDark,
                      //             selectedColor:
                      //             AppColors.primaryDark,
                      //             inactiveColor:
                      //             Colors.grey.shade300,
                      //             activeFillColor:
                      //             Colors.white,
                      //             selectedFillColor:
                      //             Colors.white,
                      //             inactiveFillColor:
                      //             Colors.white,
                      //           ),
                      //         ),
                      //
                      //         const SizedBox(height: 8),
                      //
                      //         /// TIMER
                      //         Obx(
                      //               () => controller
                      //               .otpSeconds.value ==
                      //               0
                      //               ? TextButton(
                      //             onPressed:
                      //             controller.sendOtp,
                      //             child: const Text(
                      //               "Resend OTP",
                      //             ),
                      //           )
                      //               : Text(
                      //             "Resend OTP in 00:${controller.otpSeconds.value.toString().padLeft(2, '0')}",
                      //             style: TextStyle(
                      //               color: Colors
                      //                   .grey.shade600,
                      //             ),
                      //           ),
                      //         ),
                      //
                      //         const SizedBox(height: 18),
                      //
                      //         /// VERIFY BUTTON
                      //         mainButton(
                      //           title: controller
                      //               .isOtpVerified.value
                      //               ? "OTP Verified ✓"
                      //               : "Verify OTP",
                      //           backgroundColor:
                      //           controller.otpValue.value
                      //               .length ==
                      //               6
                      //               ? Colors.green
                      //               : Colors.grey,
                      //           onTap: controller
                      //               .otpValue.value.length ==
                      //               6
                      //               ? controller.verifyOtp
                      //               : null,
                      //         ),
                      //
                      //         /// CONTINUE BUTTON
                      //         if (controller
                      //             .isOtpVerified.value) ...[
                      //
                      //           const SizedBox(
                      //             height: 15,
                      //           ),
                      //
                      //           mainButton(
                      //             title: "Continue",
                      //             onTap:
                      //             controller.loginWithOtp,
                      //           ),
                      //         ],
                      //       ],
                      //     ],
                      //   )
                      //       : const SizedBox(),
                      // ),
                      /// =========================
                      /// EMAIL FLOW
                      /// =========================

                      Obx(
                            () => controller.isEmailLogin.value
                            ? Column(
                          children: [

                            /// =========================
                            /// EMAIL LOGIN TYPE TOGGLE
                            /// =========================

                            // Container(
                            //   height: 52,
                            //   padding: const EdgeInsets.all(4),
                            //   decoration: BoxDecoration(
                            //     color: Colors.grey.shade100,
                            //     borderRadius: BorderRadius.circular(40),
                            //   ),
                            //   child: Row(
                            //     children: [
                            //
                            //       /// OTP LOGIN
                            //       Expanded(
                            //         child: GestureDetector(
                            //           onTap: () {
                            //             controller.switchEmailAuthType(0);
                            //           },
                            //           child: AnimatedContainer(
                            //             duration: const Duration(milliseconds: 250),
                            //             alignment: Alignment.center,
                            //             decoration: BoxDecoration(
                            //               color:
                            //               controller.selectedEmailAuthType.value == 0
                            //                   ? AppColors.primaryDark
                            //                   : Colors.transparent,
                            //               borderRadius: BorderRadius.circular(40),
                            //             ),
                            //             child: Text(
                            //               "Login with OTP",
                            //               style: TextStyle(
                            //                 color:
                            //                 controller.selectedEmailAuthType.value == 0
                            //                     ? Colors.white
                            //                     : Colors.black,
                            //                 fontWeight: FontWeight.w600,
                            //               ),
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //
                            //       /// PASSWORD LOGIN
                            //       Expanded(
                            //         child: GestureDetector(
                            //           onTap: () {
                            //             controller.switchEmailAuthType(1);
                            //           },
                            //           child: AnimatedContainer(
                            //             duration: const Duration(milliseconds: 250),
                            //             alignment: Alignment.center,
                            //             decoration: BoxDecoration(
                            //               color:
                            //               controller.selectedEmailAuthType.value == 1
                            //                   ? AppColors.primaryDark
                            //                   : Colors.transparent,
                            //               borderRadius: BorderRadius.circular(40),
                            //             ),
                            //             child: Text(
                            //               "Login with Password",
                            //               style: TextStyle(
                            //                 color:
                            //                 controller.selectedEmailAuthType.value == 1
                            //                     ? Colors.white
                            //                     : Colors.black,
                            //                 fontWeight: FontWeight.w600,
                            //               ),
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),

                            Obx(
                                  () => Container(
                                height: 64,
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  color: const Color(0xffF6F7FB),
                                  border: Border.all(
                                    color: Colors.grey.shade200,
                                  ),
                                  boxShadow: [

                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.03),
                                      blurRadius: 14,
                                      offset: const Offset(0, 6),
                                    ),

                                    const BoxShadow(
                                      color: Colors.white,
                                      blurRadius: 8,
                                      offset: Offset(-2, -2),
                                    ),
                                  ],
                                ),
                                child: Stack(
                                  children: [

                                    /// ACTIVE BACKGROUND
                                    AnimatedAlign(
                                      duration: const Duration(milliseconds: 280),
                                      curve: Curves.easeInOut,
                                      alignment:
                                      controller.selectedEmailAuthType.value == 0
                                          ? Alignment.centerLeft
                                          : Alignment.centerRight,
                                      child: Container(
                                        width:
                                        (MediaQuery.of(context).size.width - 64) / 2,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          gradient: LinearGradient(
                                            colors: [
                                              AppColors.primaryDark,
                                              AppColors.primaryDark.withOpacity(0.82),
                                            ],
                                          ),
                                          boxShadow: [

                                            BoxShadow(
                                              color: AppColors.primaryDark
                                                  .withOpacity(0.35),
                                              blurRadius: 18,
                                              offset: const Offset(0, 8),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    /// BUTTONS
                                    Row(
                                      children: [

                                        /// OTP
                                        Expanded(
                                          child: GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            onTap: () {
                                              controller.switchEmailAuthType(0);
                                            },
                                            child: Center(
                                              child: AnimatedDefaultTextStyle(
                                                duration:
                                                const Duration(milliseconds: 220),
                                                style: TextStyle(
                                                  color:
                                                  controller.selectedEmailAuthType.value == 0
                                                      ? Colors.white
                                                      : Colors.black87,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14,
                                                  letterSpacing: 0.2,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [

                                                    Icon(
                                                      Icons.flash_on_rounded,
                                                      size: 18,
                                                      color:
                                                      controller.selectedEmailAuthType.value == 0
                                                          ? Colors.white
                                                          : Colors.grey.shade700,
                                                    ),

                                                    const SizedBox(width: 8),

                                                    const Text(
                                                      "OTP Login",
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                        /// PASSWORD
                                        Expanded(
                                          child: GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            onTap: () {
                                              controller.switchEmailAuthType(1);
                                            },
                                            child: Center(
                                              child: AnimatedDefaultTextStyle(
                                                duration:
                                                const Duration(milliseconds: 220),
                                                style: TextStyle(
                                                  color:
                                                  controller.selectedEmailAuthType.value == 1
                                                      ? Colors.white
                                                      : Colors.black87,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14,
                                                  letterSpacing: 0.2,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [

                                                    Icon(
                                                      Icons.lock_rounded,
                                                      size: 17,
                                                      color:
                                                      controller.selectedEmailAuthType.value == 1
                                                          ? Colors.white
                                                          : Colors.grey.shade700,
                                                    ),

                                                    const SizedBox(width: 8),

                                                    const Text(
                                                      "Password",
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 22),

                            /// =========================
                            /// PASSWORD LOGIN FLOW
                            /// =========================

                            if (controller.selectedEmailAuthType.value == 1) ...[

                              inputField(
                                controller.email,
                                "Email Address",
                                Icons.email_outlined,
                                keyboardType: TextInputType.emailAddress,
                              ),

                              const SizedBox(height: 16),

                              Obx(
                                    () => inputField(
                                  controller.password,
                                  "Password",
                                  Icons.lock_outline,
                                  isPassword: true,
                                  isObscure:
                                  controller.isObscure.value,
                                  onToggle: () {
                                    controller.isObscure.value =
                                    !controller.isObscure.value;
                                  },
                                ),
                              ),

                              const SizedBox(height: 22),

                              mainButton(
                                title: "Continue",
                                loading: controller.isLoading.value,
                                onTap: controller.isLoading.value
                                    ? null
                                    : controller.login,
                              ),
                            ],

                            /// =========================
                            /// OTP LOGIN FLOW
                            /// =========================

                            if (controller.selectedEmailAuthType.value == 0) ...[

                              /// EMAIL FIELD
                              if (!controller.isOtpSent.value) ...[

                                inputField(
                                  controller.email,
                                  "Email Address",
                                  Icons.email_outlined,
                                  keyboardType:
                                  TextInputType.emailAddress,
                                ),

                                const SizedBox(
                                  height: 22,
                                ),

                                mainButton(
                                  title: "Send OTP",
                                  loading:
                                  controller.isLoading.value,
                                  onTap: controller
                                      .isLoading.value
                                      ? null
                                      : controller.sendOtp,
                                ),
                              ],

                              /// OTP SCREEN
                              if (controller.isOtpSent.value) ...[

                                Row(
                                  children: [

                                    Expanded(
                                      child: RichText(
                                        text: TextSpan(
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                          children: [

                                            const TextSpan(
                                              text: "OTP sent to ",
                                            ),

                                            TextSpan(
                                              text:
                                              controller.email.text,
                                              style:
                                              const TextStyle(
                                                fontWeight:
                                                FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    TextButton(
                                      onPressed:
                                      controller.changeEmail,
                                      child: const Text(
                                        "Change",
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 20),

                                /// OTP BOXES
                                PinCodeTextField(
                                  appContext: context,
                                  length: 6,
                                  keyboardType:
                                  TextInputType.number,
                                  animationType:
                                  AnimationType.fade,
                                  enableActiveFill: true,
                                  cursorColor:
                                  AppColors.primaryDark,
                                  inputFormatters: [
                                    FilteringTextInputFormatter
                                        .digitsOnly,
                                  ],
                                  onChanged: (value) {

                                    controller.otpValue.value =
                                        value;

                                    controller.otp.text =
                                        value;
                                  },
                                  pinTheme: PinTheme(
                                    shape:
                                    PinCodeFieldShape.box,
                                    borderRadius:
                                    BorderRadius.circular(
                                      16,
                                    ),
                                    fieldHeight: 54,
                                    fieldWidth: 48,
                                    activeColor:
                                    AppColors.primaryDark,
                                    selectedColor:
                                    AppColors.primaryDark,
                                    inactiveColor:
                                    Colors.grey.shade300,
                                    activeFillColor:
                                    Colors.white,
                                    selectedFillColor:
                                    Colors.white,
                                    inactiveFillColor:
                                    Colors.white,
                                  ),
                                ),

                                const SizedBox(height: 8),

                                /// TIMER
                                Obx(
                                      () => controller
                                      .otpSeconds.value ==
                                      0
                                      ? TextButton(
                                    onPressed:
                                    controller.sendOtp,
                                    child: const Text(
                                      "Resend OTP",
                                    ),
                                  )
                                      : Text(
                                    "Resend OTP in 00:${controller.otpSeconds.value.toString().padLeft(2, '0')}",
                                    style: TextStyle(
                                      color: Colors
                                          .grey.shade600,
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 18),

                                /// VERIFY BUTTON
                                mainButton(
                                  title: controller
                                      .isOtpVerified.value
                                      ? "OTP Verified ✓"
                                      : "Verify OTP",
                                  backgroundColor:
                                  controller.otpValue.value
                                      .length ==
                                      6
                                      ? Colors.green
                                      : Colors.grey,
                                  onTap: controller
                                      .otpValue.value.length ==
                                      6
                                      ? controller.verifyOtp
                                      : null,
                                ),

                                /// CONTINUE BUTTON
                                if (controller
                                    .isOtpVerified.value) ...[

                                  const SizedBox(
                                    height: 15,
                                  ),

                                  mainButton(
                                    title: "Continue",
                                    onTap:
                                    controller.loginWithOtp,
                                  ),
                                ],
                              ],
                            ],
                          ],
                        )
                            : const SizedBox(),
                      ),

                      /// =========================
                      /// MOBILE FLOW
                      /// =========================

                      Obx(
                            () => controller
                            .isMobileLogin
                            .value
                            ? Column(
                          children: [

                            /// MOBILE FIELD
                            if (!controller
                                .isOtpSent
                                .value) ...[
                              inputField(
                                controller
                                    .mobile,
                                "Mobile Number",
                                Icons
                                    .phone_android,
                                keyboardType:
                                TextInputType
                                    .number,
                                maxLength:
                                10,
                              ),

                              const SizedBox(
                                height: 20,
                              ),

                              mainButton(
                                title:
                                "Send OTP",
                                loading:
                                controller
                                    .isLoading
                                    .value,
                                onTap: controller
                                    .isLoading
                                    .value
                                    ? null
                                    : controller
                                    .sendOtp,
                              ),
                            ],

                            /// OTP SCREEN
                            if (controller
                                .isOtpSent
                                .value) ...[

                              Row(
                                children: [

                                  Expanded(
                                    child:
                                    RichText(
                                      text:
                                      TextSpan(
                                        style:
                                        const TextStyle(
                                          color:
                                          Colors.black,
                                          fontSize:
                                          15,
                                        ),
                                        children: [

                                          const TextSpan(
                                            text:
                                            "OTP sent to ",
                                          ),

                                          TextSpan(
                                            text:
                                            "+91 ${controller.mobile.text}",
                                            style:
                                            const TextStyle(
                                              fontWeight:
                                              FontWeight.bold,
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),

                                  TextButton(
                                    onPressed:
                                    controller
                                        .changeNumber,
                                    child:
                                    const Text(
                                      "Change",
                                    ),
                                  ),
                                ],
                              ),
                              // Obx(
                              //       () => Align(
                              //         alignment: Alignment.topLeft,
                              //         child: Text(
                              //           "OTP: ${controller.otpValue.value}",
                              //
                              //           style: const TextStyle(
                              //         color: Colors.green,
                              //         fontSize: 16,
                              //         fontWeight: FontWeight.bold,
                              //                                           ),
                              //                                         ),
                              //       ),
                              // ),



                              const SizedBox(
                                height: 20,
                              ),

                              /// OTP BOXES
                              PinCodeTextField(
                                appContext:
                                context,
                                length: 6,
                                keyboardType:
                                TextInputType
                                    .number,
                                animationType:
                                AnimationType
                                    .fade,
                                enableActiveFill:
                                true,
                                cursorColor:
                                AppColors
                                    .primaryDark,
                                inputFormatters: [
                                  FilteringTextInputFormatter
                                      .digitsOnly,
                                ],
                                onChanged:
                                    (value) {
                                  controller
                                      .otpValue
                                      .value = value;

                                  controller
                                      .otp
                                      .text =
                                      value;
                                },
                                pinTheme:
                                PinTheme(
                                  shape:
                                  PinCodeFieldShape
                                      .box,
                                  borderRadius:
                                  BorderRadius
                                      .circular(
                                    16,
                                  ),
                                  fieldHeight:
                                  54,
                                  fieldWidth:
                                  48,
                                  activeColor:
                                  AppColors
                                      .primaryDark,
                                  selectedColor:
                                  AppColors
                                      .primaryDark,
                                  inactiveColor:
                                  Colors.grey
                                      .shade300,
                                  activeFillColor:
                                  Colors.white,
                                  selectedFillColor:
                                  Colors.white,
                                  inactiveFillColor:
                                  Colors.white,
                                ),
                              ),

                              const SizedBox(
                                height: 8,
                              ),

                              /// TIMER
                              Obx(
                                    () => controller
                                    .otpSeconds
                                    .value ==
                                    0
                                    ? TextButton(
                                  onPressed:
                                  controller
                                      .sendOtp,
                                  child:
                                  const Text(
                                    "Resend OTP",
                                  ),
                                )
                                    : Text(
                                  "Resend OTP in 00:${controller.otpSeconds.value.toString().padLeft(2, '0')}",
                                  style:
                                  TextStyle(
                                    color: Colors
                                        .grey
                                        .shade600,
                                  ),
                                ),
                              ),

                              const SizedBox(
                                height: 18,
                              ),

                              /// VERIFY BUTTON
                              mainButton(
                                title: controller
                                    .isOtpVerified
                                    .value
                                    ? "OTP Verified ✓"
                                    : "Verify OTP",
                                backgroundColor:
                                controller
                                    .otpValue
                                    .value
                                    .length ==
                                    6
                                    ? Colors
                                    .green
                                    : Colors
                                    .grey,
                                onTap: controller
                                    .otpValue
                                    .value
                                    .length ==
                                    6
                                    ? controller
                                    .verifyOtp
                                    : null,
                              ),

                              /// CONTINUE
                              if (controller
                                  .isOtpVerified
                                  .value) ...[
                                const SizedBox(
                                  height: 15,
                                ),

                                mainButton(
                                  title:
                                  "Continue",
                                  onTap:
                                  controller
                                      .loginWithOtp,
                                ),
                              ],
                            ],
                          ],
                        )
                            : const SizedBox(),
                      ),

                      const SizedBox(height: 18),

                      /// TERMS
                      Obx(
                            () => Row(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                          children: [

                            Theme(
                              data: Theme.of(
                                  context)
                                  .copyWith(
                                checkboxTheme:
                                CheckboxThemeData(
                                  shape:
                                  RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius
                                        .circular(
                                      50,
                                    ),
                                  ),
                                ),
                              ),
                              child: Checkbox(
                                value: controller
                                    .isChecked
                                    .value,
                                activeColor:
                                AppColors
                                    .primary,
                                onChanged: (v) {
                                  controller
                                      .isChecked
                                      .value =
                                      v ?? false;
                                },
                              ),
                            ),

                            const SizedBox(
                              width: 6,
                            ),

                            const Expanded(
                              child: Padding(
                                padding:
                                EdgeInsets.only(
                                  top: 10,
                                ),
                                child: Text(
                                  "By Clicking Continue, you agree to our Terms of Service and Privacy Policy.",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 8),

                      /// REGISTER
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment
                            .center,
                        children: [

                          const Text(
                            "Don't have account? ",
                          ),

                          GestureDetector(
                            onTap: () {
                              Get.put(
                                RegisterController(),
                              );

                              Get.to(
                                    () =>
                                const RegisterScreen(),
                              );
                            },
                            child: const Text(
                              "Register",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight:
                                FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// =========================
  /// INPUT FIELD
  /// =========================

  // Widget inputField(
  //     TextEditingController c,
  //     String label,
  //     IconData icon, {
  //       bool isPassword = false,
  //       bool isObscure = false,
  //       VoidCallback? onToggle,
  //       TextInputType keyboardType =
  //           TextInputType.text,
  //       int? maxLength,
  //     }) {
  //   return Container(
  //     height: 72,
  //     decoration: BoxDecoration(
  //       borderRadius:
  //       BorderRadius.circular(48),
  //       border: Border.all(
  //         color:
  //         AppColors.grey.withOpacity(0.4),
  //       ),
  //     ),
  //     child: TextField(
  //       controller: c,
  //       obscureText:
  //       isPassword ? isObscure : false,
  //       keyboardType: keyboardType,
  //       maxLength: maxLength,
  //       inputFormatters:
  //       keyboardType ==
  //           TextInputType.number
  //           ? [
  //         FilteringTextInputFormatter
  //             .digitsOnly,
  //       ]
  //           : null,
  //       decoration: InputDecoration(
  //         counterText: "",
  //         prefixIcon:
  //         Icon(icon, color: AppColors.grey),
  //
  //         suffixIcon: isPassword
  //             ? IconButton(
  //           icon: Icon(
  //             isObscure
  //                 ? Icons.visibility_off
  //                 : Icons.visibility,
  //             color: AppColors.grey,
  //           ),
  //           onPressed: onToggle,
  //         )
  //             : null,
  //
  //         labelText: label,
  //
  //         contentPadding:
  //         const EdgeInsets.symmetric(
  //           vertical: 12,
  //         ),
  //
  //         border: InputBorder.none,
  //       ),
  //     ),
  //   );
  // }
  Widget inputField(
      TextEditingController c,
      String label,
      IconData icon, {
        bool isPassword = false,
        bool isObscure = false,
        VoidCallback? onToggle,
        TextInputType keyboardType = TextInputType.text,
        int? maxLength,
      }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(48),
        border: Border.all(
          color: AppColors.grey.withOpacity(0.4),
        ),
      ),
      child: TextField(
        controller: c,
        obscureText: isPassword ? isObscure : false,
        keyboardType: keyboardType,
        maxLength: maxLength,
        inputFormatters:
        keyboardType == TextInputType.number
            ? [
          FilteringTextInputFormatter
              .digitsOnly,
        ]
            : null,
        decoration: InputDecoration(
          counterText: "",

          prefixIcon: Icon(
            icon,
            color: AppColors.grey,
          ),

          suffixIcon: isPassword
              ? IconButton(
            icon: Icon(
              isObscure
                  ? Icons.visibility_off
                  : Icons.visibility,
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

  /// =========================
  /// MAIN BUTTON
  /// =========================

  Widget mainButton({
    required String title,
    required VoidCallback? onTap,
    bool loading = false,
    Color? backgroundColor,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
          backgroundColor ??
              AppColors.primaryDark,
          shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(84),
          ),
        ),
        onPressed: onTap,
        child: loading
            ? const SizedBox(
          height: 22,
          width: 22,
          child:
          CircularProgressIndicator(
            strokeWidth: 2.4,
            color: Colors.white,
          ),
        )
            : Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}