//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../app/routes/app_routes.dart';
// import '../../../app/constants/app_colors.dart';
//
// class RoleScreen extends StatelessWidget {
//   const RoleScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: AppColors.bgGradient,
//         ),
//         child: Column(
//           children: [
//             // ⭐ TOP AREA (Center perfect like Figma)
//             Expanded(
//               flex: 7,
//               child: Center(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Image.asset(
//                       "assets/images/logo.png",
//                       // width: 160,
//                     ),
//                     // const SizedBox(height: 12),
//                     // Image.asset(
//                     //   "assets/images/LOCK.png",
//                     //   // width: 130,
//                     // ),
//                     const SizedBox(height: 8),
//                     const Text(
//                       "Always with you",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 25,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//             // ⭐ BOTTOM WHITE CARD
//             Expanded(
//               flex: 4,
//               child: Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(35),
//                     topRight: Radius.circular(35),
//                   ),
//                 ),
//                 child: Column(
//                   children: [
//                     const Text(
//                       "Login as:",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     const SizedBox(height: 25),
//
//                     roleButton("Retailer", "retailer"),
//                     const SizedBox(height: 12),
//
//                     // const Text(
//                     //   "or",
//                     //   style: TextStyle(color: AppColors.grey, fontSize: 16),
//                     // ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 28.0),
//                       child: Row(
//                         children: const [
//                           Expanded(
//                             child: Divider(
//                               color: AppColors.grey,
//                               thickness: 0.8,
//                               endIndent: 5,
//                             ),
//                           ),
//                           Text(
//                             "or",
//                             style: TextStyle(
//                               color: AppColors.grey,
//                               fontSize: 16,
//                             ),
//                           ),
//                           Expanded(
//                             child: Divider(
//                               color: AppColors.grey,
//                               thickness: 0.8,
//                               indent: 6,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//
//                     roleButton("Distributor", "distributor"),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//
//   }
//
//   Widget roleButton(String title, String role) {
//     return SizedBox(
//       width: double.infinity,
//       height: 55,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//
//           backgroundColor:
//           role == "retailer" ? AppColors.primaryDark : AppColors.primaryLight,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(85),
//           ),
//
//         ),
//         onPressed: () => Get.toNamed(AppRoutes.LOGIN, arguments: role),
//         child: Text(title,
//             style: const TextStyle(color: Colors.white, fontSize: 16)),
//       ),
//     );
//   }
// }


///latest role screen comment for now
///
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../app/routes/app_routes.dart';
// import '../../../app/constants/app_colors.dart';
//
// class RoleScreen extends StatelessWidget {
//   const RoleScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         decoration: const BoxDecoration(gradient: AppColors.bgGradient),
//         child: SafeArea(
//           bottom: false,
//           child: Column(
//             children: [
//               // ✅ TOP AREA
//               // Expanded(
//               //   flex: 7,
//               //   child: Center(
//               //     child: Padding(
//               //       padding: const EdgeInsets.symmetric(horizontal: 0),
//               //       child: Column(
//               //         mainAxisSize: MainAxisSize.min,
//               //         children: [
//               //           // Logo
//               //           Image.asset(
//               //             "assets/images/logo.png",
//               //             width: size.width,
//               //           ),
//               //           // const SizedBox(height: 10),
//               //
//               //           // // Tagline
//               //           // const Text(
//               //           //   "Always with you",
//               //           //   textAlign: TextAlign.center,
//               //           //   style: TextStyle(
//               //           //     color: Colors.white,
//               //           //     fontSize: 22,
//               //           //     fontWeight: FontWeight.w600,
//               //           //     letterSpacing: 0.2,
//               //           //   ),
//               //           // ),
//               //           // const SizedBox(height: 6),
//               //           //
//               //           // // Subtitle (optional modern feel)
//               //           // const Text(
//               //           //   "Choose your role to continue",
//               //           //   textAlign: TextAlign.center,
//               //           //   style: TextStyle(
//               //           //     color: Colors.white70,
//               //           //     fontSize: 14,
//               //           //     fontWeight: FontWeight.w400,
//               //           //   ),
//               //           // ),
//               //         ],
//               //       ),
//               //     ),
//               //   ),
//               // ),
//               Expanded(
//                 flex: 7,
//                 child: Center(
//                   child: Container(
//                     padding: const EdgeInsets.all(18),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.06), // ✅ soft glass effect
//                       borderRadius: BorderRadius.circular(24),
//                       border: Border.all(color: Colors.white.withOpacity(0.10)),
//                     ),
//                     child: Image.asset(
//                       "assets/images/logo.png",
//                       width: size.width * 0.62,
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 height: 8,
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.6),
//                   borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(28),
//                     topRight: Radius.circular(28),
//                   ),
//                 ),
//               ),
//               // ✅ BOTTOM CARD
//               Expanded(
//                 flex: 5,
//                 child: Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.fromLTRB(20, 26, 20, 26),
//                   // decoration: BoxDecoration(
//                   //   color: Colors.white,
//                   //   borderRadius: const BorderRadius.only(
//                   //     topLeft: Radius.circular(28),
//                   //     topRight: Radius.circular(28),
//                   //   ),
//                   //   boxShadow: [
//                   //     BoxShadow(
//                   //       color: Colors.black.withOpacity(0.10),
//                   //       blurRadius: 18,
//                   //       offset: const Offset(0, -6),
//                   //     ),
//                   //   ],
//                   // ),
//                   // decoration: BoxDecoration(
//                   //   gradient: const LinearGradient(
//                   //     begin: Alignment.topCenter,
//                   //     end: Alignment.bottomCenter,
//                   //     colors: [
//                   //       Color(0xFFF5F8FF),
//                   //       Color(0xFFFFFFFF),
//                   //     ],
//                   //   ),
//                   //   borderRadius: const BorderRadius.only(
//                   //     topLeft: Radius.circular(28),
//                   //     topRight: Radius.circular(28),
//                   //   ),
//                   // ),
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                       colors: [
//                         AppColors.topBgColour.withOpacity(0.55), // ✅ theme tint start
//                         const Color(0xFFFFFFFF),                 // ✅ clean white end
//                       ],
//                     ),
//                     borderRadius: const BorderRadius.only(
//                       topLeft: Radius.circular(28),
//                       topRight: Radius.circular(28),
//                     ),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.10),
//                         blurRadius: 18,
//                         offset: const Offset(0, -6),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         "Login as",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w700,
//                           color: AppColors.textDark,
//                         ),
//                       ),
//                       const SizedBox(height: 6),
//                       const Text(
//                         "Select one option below",
//                         style: TextStyle(
//                           fontSize: 13,
//                           color: AppColors.textGrey,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                       const SizedBox(height: 18),
//
//                       // ✅ Buttons
//                       _roleButton(
//                         title: "Retailer",
//                         role: "retailer",
//                         bgColor: AppColors.primaryDark,
//                       ),
//                       const SizedBox(height: 14),
//
//                       _dividerOr(),
//
//                       const SizedBox(height: 14),
//                       _roleButton(
//                         title: "Distributor",
//                         role: "distributor",
//                         bgColor: AppColors.primaryLight,
//                       ),
//
//                       const Spacer(),
//
//                       // ✅ Bottom hint
//                       Center(
//                         child: Text(
//                           "By continuing you agree to our terms.",
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Colors.black.withOpacity(0.45),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _dividerOr() {
//     return Row(
//       children: [
//         Expanded(
//           child: Divider(
//             color: AppColors.border.withOpacity(0.9),
//             thickness: 1,
//             endIndent: 10,
//           ),
//         ),
//         const Text(
//           "OR",
//           style: TextStyle(
//             color: AppColors.white,
//             fontSize: 12,
//             fontWeight: FontWeight.w600,
//             letterSpacing: 1.0,
//           ),
//         ),
//         Expanded(
//           child: Divider(
//             color: AppColors.border.withOpacity(0.9),
//             thickness: 1,
//             indent: 10,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _roleButton({
//     required String title,
//     required String role,
//     required Color bgColor,
//   }) {
//     return SizedBox(
//       width: double.infinity,
//       height: 54,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: bgColor,
//           elevation: 0,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//         ),
//         onPressed: () => Get.toNamed(AppRoutes.LOGIN, arguments: role),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               title,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w700,
//                 letterSpacing: 0.2,
//               ),
//             ),
//             const SizedBox(width: 8),
//             const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }