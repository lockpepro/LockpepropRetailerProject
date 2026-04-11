// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:zlock_smart_finance/modules/retailer/qr_code/qr_controller.dart';
//
// // class CustomerQrDialog extends StatelessWidget {
// //   const CustomerQrDialog({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final ctrl = Get.find<QrController>();
// //
// //     return Dialog(
// //       backgroundColor: Colors.transparent,
// //       insetPadding: const EdgeInsets.symmetric(horizontal: 20),
// //       child: Container(
// //         padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
// //         decoration: BoxDecoration(
// //           color: Colors.white,
// //           borderRadius: BorderRadius.circular(28),
// //         ),
// //         child: Column(
// //           mainAxisSize: MainAxisSize.min,
// //           children: [
// //             /// HEADER
// //             Row(
// //               children: [
// //                 const Spacer(),
// //                 const Text(
// //                   "Customer QR Code",
// //                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
// //                 ),
// //                 const Spacer(),
// //                 GestureDetector(
// //                   onTap: () => Get.back(),
// //                   child: const Icon(Icons.close),
// //                 )
// //               ],
// //             ),
// //
// //             const SizedBox(height: 18),
// //
// //             /// DEVICE ID CHIP
// //             Container(
// //               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
// //               decoration: BoxDecoration(
// //                 color: const Color(0xffEEF1FF),
// //                 borderRadius: BorderRadius.circular(30),
// //               ),
// //               child: RichText(
// //                 text: TextSpan(
// //                   style: const TextStyle(fontSize: 14),
// //                   children: [
// //                     TextSpan(
// //                       text: "Device ID:  ",
// //                       style: TextStyle(color: Colors.grey.shade700),
// //                     ),
// //                     TextSpan(
// //                       text: ctrl.deviceId,
// //                       style: const TextStyle(
// //                         fontWeight: FontWeight.w700,
// //                         color: Color(0xff1E2A5A),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //
// //             const SizedBox(height: 20),
// //
// //             /// QR BOX
// //             Container(
// //               padding: const EdgeInsets.all(18),
// //               decoration: BoxDecoration(
// //                 color: const Color(0xffEEF1FF),
// //                 borderRadius: BorderRadius.circular(22),
// //               ),
// //               child: QrImageView(
// //                 data: ctrl.qrData,
// //                 size: 220,
// //                 backgroundColor: const Color(0xffEEF1FF),
// //                 eyeStyle: const QrEyeStyle(
// //                   eyeShape: QrEyeShape.square,
// //                   color: Colors.black87,
// //                 ),
// //                 dataModuleStyle: const QrDataModuleStyle(
// //                   dataModuleShape: QrDataModuleShape.square,
// //                   color: Colors.black87,
// //                 ),
// //               ),
// //             ),
// //
// //             const SizedBox(height: 26),
// //
// //             /// ACTIVE BUTTON
// //             SizedBox(
// //               width: double.infinity,
// //               height: 54,
// //               child: ElevatedButton(
// //                 onPressed: () {
// //                   // API CALL / STATUS CHANGE
// //                   Get.back();
// //                 },
// //                 style: ElevatedButton.styleFrom(
// //                   backgroundColor: const Color(0xff4F6BED),
// //                   shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(28),
// //                   ),
// //                 ),
// //                 child: const Text(
// //                   "Active Now",
// //                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: Colors.white),
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:zlock_smart_finance/modules/retailer/qr_code/qr_controller.dart';
//
// class CustomerQrDialog extends StatelessWidget {
//   const CustomerQrDialog({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final ctrl = Get.find<QrController>();
//
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       insetPadding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Container(
//         padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(28),
//         ),
//         child: Obx(() {
//           final loading = ctrl.isLoading.value;
//           final Uint8List? bytes = ctrl.qrBytes.value;
//           final deviceLabel = ctrl.deviceIdLabel.value.isEmpty
//               ? "-"
//               : ctrl.deviceIdLabel.value;
//
//           final url = ctrl.qrUrl.value.trim();
//
//           return Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               /// HEADER
//               Row(
//                 children: [
//                   const Spacer(),
//                   const Text(
//                     "Customer QR Code",
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
//                   ),
//                   const Spacer(),
//                   GestureDetector(
//                     onTap: () => Get.back(),
//                     child: const Icon(Icons.close),
//                   )
//                 ],
//               ),
//
//               const SizedBox(height: 18),
//
//
//
//               /// QR BOX
//               Container(
//                 padding: const EdgeInsets.all(18),
//                 decoration: BoxDecoration(
//                   color: const Color(0xffEEF1FF),
//                   borderRadius: BorderRadius.circular(22),
//                 ),
//                 // child: SizedBox(
//                 //   height: 220,
//                 //   width: 220,
//                 //   child: loading
//                 //       ? const Center(child: CircularProgressIndicator())
//                 //       : (bytes == null
//                 //       ? Column(
//                 //     mainAxisAlignment: MainAxisAlignment.center,
//                 //     children: [
//                 //       const Icon(Icons.qr_code_2, size: 44),
//                 //       const SizedBox(height: 10),
//                 //       const Text("QR load failed"),
//                 //       const SizedBox(height: 10),
//                 //       TextButton(
//                 //         onPressed: ctrl.fetchQr, // ✅ retry
//                 //         child: const Text("Retry"),
//                 //       )
//                 //     ],
//                 //   )
//                 //       : ClipRRect(
//                 //     borderRadius: BorderRadius.circular(12),
//                 //     child: Image.memory(
//                 //       bytes,
//                 //       fit: BoxFit.contain,
//                 //     ),
//                 //   )),
//                 // ),
//                 child: SizedBox(
//                   height: 220,
//                   width: 220,
//                   child: loading
//                       ? const Center(child: CircularProgressIndicator())
//                       : (url.isNotEmpty
//                       ? ClipRRect(
//                     borderRadius: BorderRadius.circular(12),
//                     child: Image.network(
//                       url,
//                       fit: BoxFit.contain,
//                       errorBuilder: (_, __, ___) => Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Icon(Icons.broken_image, size: 44),
//                           const SizedBox(height: 10),
//                           const Text("QR image failed"),
//                           const SizedBox(height: 10),
//                           TextButton(
//                             onPressed: () {
//                               // reload same url (force rebuild)
//                               ctrl.qrUrl.refresh();
//                             },
//                             child: const Text("Retry"),
//                           )
//                         ],
//                       ),
//                     ),
//                   )
//                       : (bytes == null
//                       ? Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Icon(Icons.qr_code_2, size: 44),
//                       const SizedBox(height: 10),
//                       const Text("QR load failed"),
//                       const SizedBox(height: 10),
//                       TextButton(
//                         onPressed: ctrl.fetchQr,
//                         child: const Text("Retry"),
//                       )
//                     ],
//                   )
//                       : ClipRRect(
//                     borderRadius: BorderRadius.circular(12),
//                     child: Image.memory(bytes, fit: BoxFit.contain),
//                   ))),
//                 ),
//               ),
//
//               const SizedBox(height: 10),
//               /// DEVICE ID CHIP
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 decoration: BoxDecoration(
//                   color: const Color(0xffEEF1FF),
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 child: RichText(
//                   text: TextSpan(
//                     style: const TextStyle(fontSize: 14),
//                     children: [
//                       TextSpan(
//                         text: "Device ID:  ",
//                         style: TextStyle(color: Colors.grey.shade700),
//                       ),
//                       TextSpan(
//                         text: deviceLabel, // ✅ dynamic
//                         style: const TextStyle(
//                           fontWeight: FontWeight.w700,
//                           color: Color(0xff1E2A5A),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//
//
//               /// Expires label (optional)
//               if (ctrl.expiresIn.value.isNotEmpty) ...[
//                 Text(
//                   "Expires in: ${ctrl.expiresIn.value}",
//                   style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
//                 ),
//                 const SizedBox(height: 16),
//               ] else
//                 const SizedBox(height: 16),
//
//               /// ACTIVE BUTTON
//               // SizedBox(
//               //   width: double.infinity,
//               //   height: 54,
//               //   child: ElevatedButton(
//               //     onPressed: () {
//               //       // TODO: API CALL / STATUS CHANGE
//               //       Get.back();
//               //     },
//               //     style: ElevatedButton.styleFrom(
//               //       backgroundColor: const Color(0xff4F6BED),
//               //       shape: RoundedRectangleBorder(
//               //         borderRadius: BorderRadius.circular(28),
//               //       ),
//               //     ),
//               //     child: const Text(
//               //       "Active Now",
//               //       style: TextStyle(
//               //         fontSize: 16,
//               //         fontWeight: FontWeight.w600,
//               //         color: Colors.white,
//               //       ),
//               //     ),
//               //   ),
//               // ),
//             ],
//           );
//         }),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:zlock_smart_finance/modules/retailer/qr_code/qr_controller.dart';

// class CustomerQrDialog extends StatelessWidget {
//   const CustomerQrDialog({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final ctrl = Get.find<QrController>();
//
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       insetPadding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Container(
//         padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(28),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             /// HEADER
//             Row(
//               children: [
//                 const Spacer(),
//                 const Text(
//                   "Customer QR Code",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
//                 ),
//                 const Spacer(),
//                 GestureDetector(
//                   onTap: () => Get.back(),
//                   child: const Icon(Icons.close),
//                 )
//               ],
//             ),
//
//             const SizedBox(height: 18),
//
//             /// DEVICE ID CHIP
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               decoration: BoxDecoration(
//                 color: const Color(0xffEEF1FF),
//                 borderRadius: BorderRadius.circular(30),
//               ),
//               child: RichText(
//                 text: TextSpan(
//                   style: const TextStyle(fontSize: 14),
//                   children: [
//                     TextSpan(
//                       text: "Device ID:  ",
//                       style: TextStyle(color: Colors.grey.shade700),
//                     ),
//                     TextSpan(
//                       text: ctrl.deviceId,
//                       style: const TextStyle(
//                         fontWeight: FontWeight.w700,
//                         color: Color(0xff1E2A5A),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 20),
//
//             /// QR BOX
//             Container(
//               padding: const EdgeInsets.all(18),
//               decoration: BoxDecoration(
//                 color: const Color(0xffEEF1FF),
//                 borderRadius: BorderRadius.circular(22),
//               ),
//               child: QrImageView(
//                 data: ctrl.qrData,
//                 size: 220,
//                 backgroundColor: const Color(0xffEEF1FF),
//                 eyeStyle: const QrEyeStyle(
//                   eyeShape: QrEyeShape.square,
//                   color: Colors.black87,
//                 ),
//                 dataModuleStyle: const QrDataModuleStyle(
//                   dataModuleShape: QrDataModuleShape.square,
//                   color: Colors.black87,
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 26),
//
//             /// ACTIVE BUTTON
//             SizedBox(
//               width: double.infinity,
//               height: 54,
//               child: ElevatedButton(
//                 onPressed: () {
//                   // API CALL / STATUS CHANGE
//                   Get.back();
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xff4F6BED),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(28),
//                   ),
//                 ),
//                 child: const Text(
//                   "Active Now",
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: Colors.white),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zlock_smart_finance/modules/retailer/qr_code/qr_controller.dart';

class CustomerQrDialog extends StatefulWidget {
  const CustomerQrDialog({super.key});

  @override
  State<CustomerQrDialog> createState() => _CustomerQrDialogState();
}

class _CustomerQrDialogState extends State<CustomerQrDialog> {
  @override
  // Widget build(BuildContext context) {
  //   final ctrl = Get.find<QrController>();
  //
  //   return Scaffold(
  //     backgroundColor: Colors.white,
  //     body: SafeArea(
  //       child: Padding(
  //         padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
  //         child: Obx(() {
  //           return SingleChildScrollView(
  //             child: Column(
  //               children: [
  //                 /// YOUR SAME UI (no changes inside)
  //                 Obx(() {
  //                   final loading = ctrl.isLoading.value;
  //                   final Uint8List? bytes = ctrl.qrBytes.value;
  //                   final deviceLabel = ctrl.deviceIdLabel.value.isEmpty
  //                       ? "-"
  //                       : ctrl.deviceIdLabel.value;
  //
  //                   final url = ctrl.qrUrl.value.trim();
  //
  //                   return Column(
  //                     mainAxisSize: MainAxisSize.min,
  //                     children: [
  //                       /// HEADER
  //                       Row(
  //                         children: [
  //                           const Spacer(),
  //                           const Text(
  //                             "Customer QR Code",
  //                             style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
  //                           ),
  //                           const Spacer(),
  //                           GestureDetector(
  //                             onTap: () => Get.back(),
  //                             child: const Icon(Icons.close),
  //                           )
  //                         ],
  //                       ),
  //
  //                       const SizedBox(height: 18),
  //
  //
  //
  //                       /// QR BOX
  //                       Container(
  //                         padding: const EdgeInsets.all(18),
  //                         decoration: BoxDecoration(
  //                           color: const Color(0xffEEF1FF),
  //                           borderRadius: BorderRadius.circular(22),
  //                         ),
  //                         // child: SizedBox(
  //                         //   height: 220,
  //                         //   width: 220,
  //                         //   child: loading
  //                         //       ? const Center(child: CircularProgressIndicator())
  //                         //       : (bytes == null
  //                         //       ? Column(
  //                         //     mainAxisAlignment: MainAxisAlignment.center,
  //                         //     children: [
  //                         //       const Icon(Icons.qr_code_2, size: 44),
  //                         //       const SizedBox(height: 10),
  //                         //       const Text("QR load failed"),
  //                         //       const SizedBox(height: 10),
  //                         //       TextButton(
  //                         //         onPressed: ctrl.fetchQr, // ✅ retry
  //                         //         child: const Text("Retry"),
  //                         //       )
  //                         //     ],
  //                         //   )
  //                         //       : ClipRRect(
  //                         //     borderRadius: BorderRadius.circular(12),
  //                         //     child: Image.memory(
  //                         //       bytes,
  //                         //       fit: BoxFit.contain,
  //                         //     ),
  //                         //   )),
  //                         // ),
  //                         child: SizedBox(
  //                           height: 220,
  //                           width: 220,
  //                           child: loading
  //                               ? const Center(child: CircularProgressIndicator())
  //                               : (url.isNotEmpty
  //                               ? ClipRRect(
  //                             borderRadius: BorderRadius.circular(12),
  //                             child: Image.network(
  //                               url,
  //                               fit: BoxFit.contain,
  //                               errorBuilder: (_, __, ___) => Column(
  //                                 mainAxisAlignment: MainAxisAlignment.center,
  //                                 children: [
  //                                   const Icon(Icons.broken_image, size: 44),
  //                                   const SizedBox(height: 10),
  //                                   const Text("QR image failed"),
  //                                   const SizedBox(height: 10),
  //                                   TextButton(
  //                                     onPressed: () {
  //                                       // reload same url (force rebuild)
  //                                       ctrl.qrUrl.refresh();
  //                                     },
  //                                     child: const Text("Retry"),
  //                                   )
  //                                 ],
  //                               ),
  //                             ),
  //                           )
  //                               : (bytes == null
  //                               ? Column(
  //                             mainAxisAlignment: MainAxisAlignment.center,
  //                             children: [
  //                               const Icon(Icons.qr_code_2, size: 44),
  //                               const SizedBox(height: 10),
  //                               const Text("QR load failed"),
  //                               const SizedBox(height: 10),
  //                               TextButton(
  //                                 onPressed: ctrl.fetchQr,
  //                                 child: const Text("Retry"),
  //                               )
  //                             ],
  //                           )
  //                               : ClipRRect(
  //                             borderRadius: BorderRadius.circular(12),
  //                             child: Image.memory(bytes, fit: BoxFit.contain),
  //                           ))),
  //                         ),
  //                       ),
  //
  //                       const SizedBox(height: 10),
  //                       /// DEVICE ID CHIP
  //                       Container(
  //                         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //                         decoration: BoxDecoration(
  //                           color: const Color(0xffEEF1FF),
  //                           borderRadius: BorderRadius.circular(30),
  //                         ),
  //                         child: RichText(
  //                           text: TextSpan(
  //                             style: const TextStyle(fontSize: 14),
  //                             children: [
  //                               TextSpan(
  //                                 text: "Device ID:  ",
  //                                 style: TextStyle(color: Colors.grey.shade700),
  //                               ),
  //                               TextSpan(
  //                                 text: deviceLabel, // ✅ dynamic
  //                                 style: const TextStyle(
  //                                   fontWeight: FontWeight.w700,
  //                                   color: Color(0xff1E2A5A),
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       ),
  //
  //
  //                       /// Expires label (optional)
  //                       if (ctrl.expiresIn.value.isNotEmpty) ...[
  //                         Text(
  //                           "Expires in: ${ctrl.expiresIn.value}",
  //                           style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
  //                         ),
  //                         const SizedBox(height: 16),
  //                       ] else
  //                         const SizedBox(height: 16),
  //
  //                       /// ACTIVE BUTTON
  //                       // SizedBox(
  //                       //   width: double.infinity,
  //                       //   height: 54,
  //                       //   child: ElevatedButton(
  //                       //     onPressed: () {
  //                       //       // TODO: API CALL / STATUS CHANGE
  //                       //       Get.back();
  //                       //     },
  //                       //     style: ElevatedButton.styleFrom(
  //                       //       backgroundColor: const Color(0xff4F6BED),
  //                       //       shape: RoundedRectangleBorder(
  //                       //         borderRadius: BorderRadius.circular(28),
  //                       //       ),
  //                       //     ),
  //                       //     child: const Text(
  //                       //       "Active Now",
  //                       //       style: TextStyle(
  //                       //         fontSize: 16,
  //                       //         fontWeight: FontWeight.w600,
  //                       //         color: Colors.white,
  //                       //       ),
  //                       //     ),
  //                       //   ),
  //                       // ),
  //                     ],
  //                   );
  //                 }),
  //               ],
  //             ),
  //           );
  //         }),
  //       ),
  //     ),
  //   );
  //   // return Dialog(
  //   //   backgroundColor: Colors.transparent,
  //   //   insetPadding: const EdgeInsets.symmetric(horizontal: 20),
  //   //   child: Container(
  //   //     padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
  //   //     decoration: BoxDecoration(
  //   //       color: Colors.white,
  //   //       borderRadius: BorderRadius.circular(28),
  //   //     ),
  //   //     child: Obx(() {
  //   //       final loading = ctrl.isLoading.value;
  //   //       final Uint8List? bytes = ctrl.qrBytes.value;
  //   //       final deviceLabel = ctrl.deviceIdLabel.value.isEmpty
  //   //           ? "-"
  //   //           : ctrl.deviceIdLabel.value;
  //   //
  //   //       final url = ctrl.qrUrl.value.trim();
  //   //
  //   //       return Column(
  //   //         mainAxisSize: MainAxisSize.min,
  //   //         children: [
  //   //           /// HEADER
  //   //           Row(
  //   //             children: [
  //   //               const Spacer(),
  //   //               const Text(
  //   //                 "Customer QR Code",
  //   //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
  //   //               ),
  //   //               const Spacer(),
  //   //               GestureDetector(
  //   //                 onTap: () => Get.back(),
  //   //                 child: const Icon(Icons.close),
  //   //               )
  //   //             ],
  //   //           ),
  //   //
  //   //           const SizedBox(height: 18),
  //   //
  //   //
  //   //
  //   //           /// QR BOX
  //   //           Container(
  //   //             padding: const EdgeInsets.all(18),
  //   //             decoration: BoxDecoration(
  //   //               color: const Color(0xffEEF1FF),
  //   //               borderRadius: BorderRadius.circular(22),
  //   //             ),
  //   //             // child: SizedBox(
  //   //             //   height: 220,
  //   //             //   width: 220,
  //   //             //   child: loading
  //   //             //       ? const Center(child: CircularProgressIndicator())
  //   //             //       : (bytes == null
  //   //             //       ? Column(
  //   //             //     mainAxisAlignment: MainAxisAlignment.center,
  //   //             //     children: [
  //   //             //       const Icon(Icons.qr_code_2, size: 44),
  //   //             //       const SizedBox(height: 10),
  //   //             //       const Text("QR load failed"),
  //   //             //       const SizedBox(height: 10),
  //   //             //       TextButton(
  //   //             //         onPressed: ctrl.fetchQr, // ✅ retry
  //   //             //         child: const Text("Retry"),
  //   //             //       )
  //   //             //     ],
  //   //             //   )
  //   //             //       : ClipRRect(
  //   //             //     borderRadius: BorderRadius.circular(12),
  //   //             //     child: Image.memory(
  //   //             //       bytes,
  //   //             //       fit: BoxFit.contain,
  //   //             //     ),
  //   //             //   )),
  //   //             // ),
  //   //             child: SizedBox(
  //   //               height: 220,
  //   //               width: 220,
  //   //               child: loading
  //   //                   ? const Center(child: CircularProgressIndicator())
  //   //                   : (url.isNotEmpty
  //   //                   ? ClipRRect(
  //   //                 borderRadius: BorderRadius.circular(12),
  //   //                 child: Image.network(
  //   //                   url,
  //   //                   fit: BoxFit.contain,
  //   //                   errorBuilder: (_, __, ___) => Column(
  //   //                     mainAxisAlignment: MainAxisAlignment.center,
  //   //                     children: [
  //   //                       const Icon(Icons.broken_image, size: 44),
  //   //                       const SizedBox(height: 10),
  //   //                       const Text("QR image failed"),
  //   //                       const SizedBox(height: 10),
  //   //                       TextButton(
  //   //                         onPressed: () {
  //   //                           // reload same url (force rebuild)
  //   //                           ctrl.qrUrl.refresh();
  //   //                         },
  //   //                         child: const Text("Retry"),
  //   //                       )
  //   //                     ],
  //   //                   ),
  //   //                 ),
  //   //               )
  //   //                   : (bytes == null
  //   //                   ? Column(
  //   //                 mainAxisAlignment: MainAxisAlignment.center,
  //   //                 children: [
  //   //                   const Icon(Icons.qr_code_2, size: 44),
  //   //                   const SizedBox(height: 10),
  //   //                   const Text("QR load failed"),
  //   //                   const SizedBox(height: 10),
  //   //                   TextButton(
  //   //                     onPressed: ctrl.fetchQr,
  //   //                     child: const Text("Retry"),
  //   //                   )
  //   //                 ],
  //   //               )
  //   //                   : ClipRRect(
  //   //                 borderRadius: BorderRadius.circular(12),
  //   //                 child: Image.memory(bytes, fit: BoxFit.contain),
  //   //               ))),
  //   //             ),
  //   //           ),
  //   //
  //   //           const SizedBox(height: 10),
  //   //           /// DEVICE ID CHIP
  //   //           Container(
  //   //             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //   //             decoration: BoxDecoration(
  //   //               color: const Color(0xffEEF1FF),
  //   //               borderRadius: BorderRadius.circular(30),
  //   //             ),
  //   //             child: RichText(
  //   //               text: TextSpan(
  //   //                 style: const TextStyle(fontSize: 14),
  //   //                 children: [
  //   //                   TextSpan(
  //   //                     text: "Device ID:  ",
  //   //                     style: TextStyle(color: Colors.grey.shade700),
  //   //                   ),
  //   //                   TextSpan(
  //   //                     text: deviceLabel, // ✅ dynamic
  //   //                     style: const TextStyle(
  //   //                       fontWeight: FontWeight.w700,
  //   //                       color: Color(0xff1E2A5A),
  //   //                     ),
  //   //                   ),
  //   //                 ],
  //   //               ),
  //   //             ),
  //   //           ),
  //   //
  //   //
  //   //           /// Expires label (optional)
  //   //           if (ctrl.expiresIn.value.isNotEmpty) ...[
  //   //             Text(
  //   //               "Expires in: ${ctrl.expiresIn.value}",
  //   //               style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
  //   //             ),
  //   //             const SizedBox(height: 16),
  //   //           ] else
  //   //             const SizedBox(height: 16),
  //   //
  //   //           /// ACTIVE BUTTON
  //   //           // SizedBox(
  //   //           //   width: double.infinity,
  //   //           //   height: 54,
  //   //           //   child: ElevatedButton(
  //   //           //     onPressed: () {
  //   //           //       // TODO: API CALL / STATUS CHANGE
  //   //           //       Get.back();
  //   //           //     },
  //   //           //     style: ElevatedButton.styleFrom(
  //   //           //       backgroundColor: const Color(0xff4F6BED),
  //   //           //       shape: RoundedRectangleBorder(
  //   //           //         borderRadius: BorderRadius.circular(28),
  //   //           //       ),
  //   //           //     ),
  //   //           //     child: const Text(
  //   //           //       "Active Now",
  //   //           //       style: TextStyle(
  //   //           //         fontSize: 16,
  //   //           //         fontWeight: FontWeight.w600,
  //   //           //         color: Colors.white,
  //   //           //       ),
  //   //           //     ),
  //   //           //   ),
  //   //           // ),
  //   //         ],
  //   //       );
  //   //     }),
  //   //   ),
  //   // );
  // }
  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<QrController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
          child: Obx(() {
            final loading = ctrl.isLoading.value;
            final Uint8List? bytes = ctrl.qrBytes.value;
            final deviceLabel = ctrl.deviceIdLabel.value.isEmpty
                ? "-"
                : ctrl.deviceIdLabel.value;

            final url = ctrl.qrUrl.value.trim();

            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// HEADER
                  Row(
                    children: [
                      const Spacer(),
                      const Text(
                        "Customer QR Code",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: const Icon(Icons.close),
                      )
                    ],
                  ),

                  const SizedBox(height: 228),

                  /// QR BOX
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: const Color(0xffEEF1FF),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: SizedBox(
                        height: 220,
                        width: 220,
                        child: loading
                            ? const Center(child: CircularProgressIndicator())
                            : (url.isNotEmpty
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            url,
                            fit: BoxFit.contain,
                            errorBuilder: (_, __, ___) => Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.broken_image, size: 44),
                                const SizedBox(height: 10),
                                const Text("QR image failed"),
                                const SizedBox(height: 10),
                                TextButton(
                                  onPressed: () {
                                    ctrl.qrUrl.refresh();
                                  },
                                  child: const Text("Retry"),
                                )
                              ],
                            ),
                          ),
                        )
                            : (bytes == null
                            ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.qr_code_2, size: 44),
                            const SizedBox(height: 10),
                            const Text("QR load failed"),
                            const SizedBox(height: 10),
                            TextButton(
                              onPressed: ctrl.fetchQr,
                              child: const Text("Retry"),
                            )
                          ],
                        )
                            : ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.memory(bytes, fit: BoxFit.contain),
                        ))),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// DEVICE ID
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xffEEF1FF),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(fontSize: 14),
                        children: [
                          TextSpan(
                            text: "Device ID:  ",
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                          TextSpan(
                            text: deviceLabel,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color(0xff1E2A5A),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  if (ctrl.expiresIn.value.isNotEmpty)
                    Text(
                      "Expires in: ${ctrl.expiresIn.value}",
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                    ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
