import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:zlock_smart_finance/app/utils/common_bottom_button.dart';

import '../add_retailer/add_retailer_controller.dart';

// class EditRetailerPage extends StatelessWidget {
//   const EditRetailerPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final c = Get.put(AddRetailerController());
//
//     return Scaffold(
//       backgroundColor: const Color(0xFFF6F8FF),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//               /// HEADER
//               Row(
//                 children: [
//                   _circleBack(),
//                   const SizedBox(width: 12),
//                   const Text(
//                     "Edit Retailer",
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               ),
//
//               const SizedBox(height: 20),
//
//               /// FORM CARD
//               Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(18),
//                 ),
//                 child: Column(
//                   children: [
//                     /// IMAGE PICKER
//                     GestureDetector(
//                       // onTap: c.pickImage,
//                       onTap: () => c.showImagePickOptions(context),
//
//                       child: Obx(() {
//                         return Container(
//                           height: 110,
//                           width: 110,
//                           decoration: BoxDecoration(
//                             color: const Color(0xFFF2F4F8),
//                             shape: BoxShape.circle,
//                             image: c.selectedImage.value != null
//                                 ? DecorationImage(
//                               image:
//                               FileImage(c.selectedImage.value!),
//                               fit: BoxFit.cover,
//                             )
//                                 : null,
//                           ),
//                           child: c.selectedImage.value == null
//                               ? Column(
//                             mainAxisAlignment:
//                             MainAxisAlignment.center,
//                             children: [
//                               SvgPicture.asset(
//                                 "assets/icons/camera.svg",
//                                 width: 30,
//                               ),
//                             ],
//                           )
//                               : null,
//                         );
//                       }),
//                     ),
//                     const SizedBox(height: 6),
//                     const Text(
//                       "Customer + Product Image",
//                       style: TextStyle(fontSize: 11),
//                     ),
//                     const Text(
//                       "Upload photos",
//                       style: TextStyle(
//                         fontSize: 11,
//                         color: Color(0xFF3D5CFF),
//                       ),
//                     ),
//
//
//                     const SizedBox(height: 20),
//
//                     _field("Retailer Name", c.retailerName),
//                     _field("Owner Name", c.ownerName),
//                     _field("Retailer Phone Number", c.phone,
//                         keyboard: TextInputType.phone),
//                     _field("Retailer Email ID", c.email,
//                         keyboard: TextInputType.emailAddress),
//                     _field("Membership Plan Name", c.plan),
//                     _field("State", c.state),
//                     _field("Full Address", c.address, maxLines: 3),
//                     _field("GST Number", c.gst),
//
//                     const SizedBox(height: 14),
//
//                     // /// PASSWORD CARD
//                     // Container(
//                     //   padding: const EdgeInsets.all(14),
//                     //   decoration: BoxDecoration(
//                     //     color: const Color(0xFFF8FAFF),
//                     //     borderRadius: BorderRadius.circular(14),
//                     //   ),
//                     //   child: Column(
//                     //     crossAxisAlignment: CrossAxisAlignment.start,
//                     //     children: [
//                     //       const Text(
//                     //         "Create Password",
//                     //         style: TextStyle(
//                     //           fontWeight: FontWeight.w600,
//                     //         ),
//                     //       ),
//                     //       const SizedBox(height: 12),
//                     //       _field("Password", c.password,
//                     //           obscure: true),
//                     //       _field("Confirm Password",
//                     //           c.confirmPassword,
//                     //           obscure: true),
//                     //     ],
//                     //   ),
//                     // ),
//
//                     const SizedBox(height: 100),
//
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       floatingActionButton: CommonBottomButtonUpdate(
//         title: "Update",
//         onTap: () => c.submit(), // ✅ function CALL
//       ),
//
//     );
//   }
//
//   Widget _circleBack() {
//     return GestureDetector(
//       onTap: Get.back,
//       child: Container(
//         height: 40,
//         width: 40,
//         decoration: const BoxDecoration(
//           color: Color(0xFFF1F3F7),
//           shape: BoxShape.circle,
//         ),
//         child: const Icon(Icons.arrow_back),
//       ),
//     );
//   }
//
//   Widget _field(
//       String hint,
//       TextEditingController controller, {
//         bool obscure = false,
//         int maxLines = 1,
//         TextInputType keyboard = TextInputType.text,
//       }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: TextField(
//         controller: controller,
//         obscureText: obscure,
//         maxLines: maxLines,
//         keyboardType: keyboard,
//         decoration: InputDecoration(
//           hintText: hint,
//           filled: true,
//           fillColor: Colors.white,
//           contentPadding:
//           const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(14),
//             borderSide: const BorderSide(color: Color(0xFFE3E8F1)),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(14),
//             borderSide: const BorderSide(color: Color(0xFFE3E8F1)),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:zlock_smart_finance/app/utils/common_bottom_button.dart';
import 'edit_retailer_controller.dart';

// class EditRetailerPage extends StatelessWidget {
//   final String retailerId;
//   const EditRetailerPage({super.key, required this.retailerId});
//
//   @override
//   Widget build(BuildContext context) {
//     final c = Get.put(EditRetailerController(retailerId: retailerId));
//
//     return Scaffold(
//       backgroundColor: const Color(0xFFF6F8FF),
//       body: SafeArea(
//         child: Obx(() {
//           // if (c.isLoading.value) {
//           //   return const Center(
//           //     child: CircularProgressIndicator(
//           //       color: Color(0xFF3D5CFF),
//           //       strokeWidth: 2.5,
//           //     ),
//           //   );
//           // }
//           //
//           // if (c.error.value.isNotEmpty) {
//           //   return Center(
//           //     child: Column(
//           //       mainAxisSize: MainAxisSize.min,
//           //       children: [
//           //         Text(c.error.value, style: const TextStyle(color: Colors.red)),
//           //         const SizedBox(height: 10),
//           //         ElevatedButton(
//           //           onPressed: c.fetchDetails,
//           //           child: const Text("Retry"),
//           //         ),
//           //       ],
//           //     ),
//           //   );
//           // }
//
//           return SingleChildScrollView(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               children: [
//                 /// HEADER
//                 Row(
//                   children: [
//                     _circleBack(),
//                     const SizedBox(width: 12),
//                     const Text(
//                       "Edit Retailer",
//                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//                     ),
//                   ],
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 /// FORM CARD
//                 Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(18),
//                   ),
//                   child: Column(
//                     children: [
//                       /// IMAGE PICKER (prefill old url OR picked file)
//                       GestureDetector(
//                         onTap: () => c.showImagePickOptions(context),
//                         child: Obx(() {
//                           final File? picked = c.selectedImage.value;
//                           final String url = c.existingImageUrl.value;
//
//                           DecorationImage? img;
//                           if (picked != null) {
//                             img = DecorationImage(image: FileImage(picked), fit: BoxFit.cover);
//                           } else if (url.isNotEmpty && url.startsWith("http")) {
//                             img = DecorationImage(image: NetworkImage(url), fit: BoxFit.cover);
//                           }
//
//                           return Container(
//                             height: 110,
//                             width: 110,
//                             decoration: BoxDecoration(
//                               color: const Color(0xFFF2F4F8),
//                               shape: BoxShape.circle,
//                               image: img,
//                             ),
//                             child: img == null
//                                 ? Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 SvgPicture.asset("assets/icons/camera.svg", width: 30),
//                               ],
//                             )
//                                 : null,
//                           );
//                         }),
//                       ),
//                       const SizedBox(height: 6),
//                       const Text("Retailer Image", style: TextStyle(fontSize: 11)),
//                       const Text(
//                         "Tap to upload",
//                         style: TextStyle(fontSize: 11, color: Color(0xFF3D5CFF)),
//                       ),
//
//                       const SizedBox(height: 20),
//
//                       _field("Retailer Name", c.retailerName),
//                       _field("Owner Name", c.ownerName),
//                       _field("Retailer Phone Number", c.phone, keyboard: TextInputType.phone),
//                       _field("Retailer Email ID", c.email, keyboard: TextInputType.emailAddress),
//                       _field("Membership Plan Name", c.plan),
//                       _field("State", c.state),
//                       _field("Full Address", c.address, maxLines: 3),
//                       _field("GST Number", c.gst),
//
//                       const SizedBox(height: 14),
//
//                       /// OPTIONAL PASSWORD (only if you want change)
//                       Container(
//                         padding: const EdgeInsets.all(14),
//                         decoration: BoxDecoration(
//                           color: const Color(0xFFF8FAFF),
//                           borderRadius: BorderRadius.circular(14),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text("Change Password (Optional)",
//                                 style: TextStyle(fontWeight: FontWeight.w600)),
//                             const SizedBox(height: 12),
//                             _field("Password", c.password, obscure: true),
//                             _field("Confirm Password", c.confirmPassword, obscure: true),
//                           ],
//                         ),
//                       ),
//
//                       const SizedBox(height: 120),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }),
//       ),
//
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       floatingActionButton: Obx(() {
//         final loading = c.isUpdating.value;
//         return CommonBottomButtonUpdate(
//           title: loading ? "Updating..." : "Update",
//           onTap: c.updateRetailer,
//           // isButtonDisabled: loading,
//         );
//       }),
//     );
//   }
//
//   Widget _circleBack() {
//     return GestureDetector(
//       onTap: Get.back,
//       child: Container(
//         height: 40,
//         width: 40,
//         decoration: const BoxDecoration(color: Color(0xFFF1F3F7), shape: BoxShape.circle),
//         child: const Icon(Icons.arrow_back),
//       ),
//     );
//   }
//
//   Widget _field(
//       String hint,
//       TextEditingController controller, {
//         bool obscure = false,
//         int maxLines = 1,
//         TextInputType keyboard = TextInputType.text,
//       }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: TextField(
//         controller: controller,
//         obscureText: obscure,
//         maxLines: maxLines,
//         keyboardType: keyboard,
//         decoration: InputDecoration(
//           hintText: hint,
//           filled: true,
//           fillColor: Colors.white,
//           contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(14),
//             borderSide: const BorderSide(color: Color(0xFFE3E8F1)),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(14),
//             borderSide: const BorderSide(color: Color(0xFFE3E8F1)),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zlock_smart_finance/app/utils/common_bottom_button.dart';
import 'package:zlock_smart_finance/model/retailer_details_response.dart';
import 'edit_retailer_controller.dart';

class EditRetailerPage extends StatefulWidget {
  final String retailerId;
  final RetailerDetailsData data;

  const EditRetailerPage({
    super.key,
    required this.retailerId,
    required this.data,
  });

  @override
  State<EditRetailerPage> createState() => _EditRetailerPageState();
}

class _EditRetailerPageState extends State<EditRetailerPage> {
  @override
  Widget build(BuildContext context) {
    final c = Get.put(
      EditRetailerController(
        retailerId: widget.retailerId,
        data: widget.data,
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              /// HEADER
              Row(
                children: [
                  _circleBack(),
                  const SizedBox(width: 12),
                  const Text(
                    "Edit Retailer",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// FORM
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [

                    /// IMAGE
                    GestureDetector(
                      onTap: () => c.pickImage(),
                      child: Obx(() {
                        final picked = c.selectedImage.value;
                        final url = c.existingImageUrl.value;

                        DecorationImage? img;

                        if (picked != null) {
                          img = DecorationImage(
                            image: FileImage(picked),
                            fit: BoxFit.cover,
                          );
                        } else if (url.isNotEmpty) {
                          img = DecorationImage(
                            image: NetworkImage(url),
                            fit: BoxFit.cover,
                          );
                        }

                        return Container(
                          height: 110,
                          width: 110,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFFF2F4F8),
                            image: img,
                          ),
                          child: img == null
                              ? SvgPicture.asset("assets/icons/camera.svg", width: 30)
                              : null,
                        );
                      }),
                    ),

                    const SizedBox(height: 20),

                    _field("Retailer Name", c.retailerName),
                    _field("Company Name", c.companyName),
                    _field("Retailer Phone", c.phone),

                    /// ❌ EMAIL NOT EDITABLE
                    _field("Email", c.email, enabled: false),

                    _field("State", c.state),
                    _field("City", c.city),
                    _field("Full Address", c.address, maxLines: 3),
                    _field("GST Number", c.gst),

                    const SizedBox(height: 16),

                    /// PASSWORD OPTIONAL
                    // Container(
                    //   padding: const EdgeInsets.all(12),
                    //   decoration: BoxDecoration(
                    //     color: const Color(0xFFF8FAFF),
                    //     borderRadius: BorderRadius.circular(12),
                    //   ),
                    //   child: Column(
                    //     children: [
                    //       _field("Password", c.password, obscure: true),
                    //       _field("Confirm Password", c.confirmPassword, obscure: true),
                    //     ],
                    //   ),
                    // ),

                    const SizedBox(height: 120),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Obx(() {
        return CommonBottomButtonUpdate(
          title: c.isUpdating.value ? "Updating..." : "Update",
          onTap: c.updateRetailer,
        );
      }),
    );
  }

  Widget _circleBack() {
    return GestureDetector(
      onTap: Get.back,
      child: const CircleAvatar(
        backgroundColor: Color(0xFFF1F3F7),
        child: Icon(Icons.arrow_back),
      ),
    );
  }

  Widget _field(
      String hint,
      TextEditingController controller, {
        bool enabled = true,
        bool obscure = false,
        int maxLines = 1,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        enabled: enabled,
        obscureText: obscure,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}