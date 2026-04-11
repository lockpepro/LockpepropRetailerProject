import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zlock_smart_finance/app/request/update_retailer_models.dart';
import 'package:zlock_smart_finance/app/routes/app_routes.dart';
import 'package:zlock_smart_finance/app/services/distributor_retailer_details_service.dart';
import 'package:zlock_smart_finance/model/retailer_details_response.dart';
import 'package:zlock_smart_finance/modules/distributor/total_retailer/retailer_controller.dart';

// class EditRetailerController extends GetxController {
//   final String retailerId;
//   EditRetailerController({required this.retailerId});
//
//   final _picker = ImagePicker();
//   final _service = DistributorRetailerDetailsService();
//
//   // ✅ states
//   final isLoading = false.obs;
//   final isUpdating = false.obs;
//   final error = "".obs;
//
//   // ✅ data
//   final details = Rxn<RetailerDetailsData>();
//   final existingImageUrl = "".obs; // old url for preview
//   final Rx<File?> selectedImage = Rx<File?>(null);
//
//   // ✅ controllers (prefill)
//   final retailerName = TextEditingController();
//   final ownerName = TextEditingController();
//   final phone = TextEditingController();
//   final email = TextEditingController();
//   final plan = TextEditingController();
//   final state = TextEditingController();
//   final address = TextEditingController();
//   final gst = TextEditingController();
//
//   // optional password change
//   final password = TextEditingController();
//   final confirmPassword = TextEditingController();
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchDetails();
//   }
//
//   Future<void> fetchDetails() async {
//     isLoading.value = true;
//     error.value = "";
//     try {
//       final resp = await _service.getRetailerDetails(retailerId);
//       if (resp == null || resp.status != 200 || resp.data == null) {
//         error.value = "Retailer details not found";
//         return;
//       }
//
//       details.value = resp.data!;
//       final d = resp.data!;
//
//       // ✅ prefill
//       retailerName.text = d.retailerName;
//       ownerName.text = d.ownerName;
//       phone.text = d.mobile;
//       email.text = d.email;
//       state.text = d.state;
//
//       // these are not in details response, so keep empty (user fill/edit)
//       // plan/address/gst -> if you want prefill, use update-details api response or add fields in details api
//       // but we keep safe:
//       plan.text = "";
//       address.text = "";
//       gst.text = "";
//
//       existingImageUrl.value = (d.image ?? "");
//     } catch (e) {
//       error.value = "Something went wrong";
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   // ✅ BottomSheet Image pick
//   void showImagePickOptions(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Colors.white,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder: (_) {
//         return SafeArea(
//           child: Wrap(
//             children: [
//               ListTile(
//                 leading: const Icon(Icons.camera_alt),
//                 title: const Text("Camera"),
//                 onTap: () async {
//                   Navigator.pop(context);
//                   await pickImage(ImageSource.camera);
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.photo_library),
//                 title: const Text("Gallery"),
//                 onTap: () async {
//                   Navigator.pop(context);
//                   await pickImage(ImageSource.gallery);
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.close),
//                 title: const Text("Cancel"),
//                 onTap: () => Navigator.pop(context),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Future<void> pickImage(ImageSource source) async {
//     try {
//       final XFile? image = await _picker.pickImage(
//         source: source,
//         imageQuality: 85,
//         maxWidth: 1200,
//         maxHeight: 1200,
//       );
//       if (image == null) return;
//       selectedImage.value = File(image.path);
//     } catch (_) {
//       Get.snackbar("Error", "Could not pick image", snackPosition: SnackPosition.BOTTOM);
//     }
//   }
//
//   bool _isValidEmail(String v) => RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v.trim());
//   bool _isValidMobile(String v) => RegExp(r'^\d{10}$').hasMatch(v.trim());
//
//   bool validate() {
//     if (retailerName.text.trim().isEmpty) {
//       Get.snackbar("Required", "Retailer Name is required", snackPosition: SnackPosition.BOTTOM);
//       return false;
//     }
//     if (ownerName.text.trim().isEmpty) {
//       Get.snackbar("Required", "Owner Name is required", snackPosition: SnackPosition.BOTTOM);
//       return false;
//     }
//     if (!_isValidMobile(phone.text.trim())) {
//       Get.snackbar("Invalid", "Enter valid 10-digit phone", snackPosition: SnackPosition.BOTTOM);
//       return false;
//     }
//     if (!_isValidEmail(email.text.trim())) {
//       Get.snackbar("Invalid", "Enter valid email", snackPosition: SnackPosition.BOTTOM);
//       return false;
//     }
//     if (plan.text.trim().isEmpty) {
//       Get.snackbar("Required", "Membership Plan is required", snackPosition: SnackPosition.BOTTOM);
//       return false;
//     }
//     if (state.text.trim().isEmpty) {
//       Get.snackbar("Required", "State is required", snackPosition: SnackPosition.BOTTOM);
//       return false;
//     }
//     if (address.text.trim().isEmpty) {
//       Get.snackbar("Required", "Address is required", snackPosition: SnackPosition.BOTTOM);
//       return false;
//     }
//     if (gst.text.trim().isEmpty) {
//       Get.snackbar("Required", "GST Number is required", snackPosition: SnackPosition.BOTTOM);
//       return false;
//     }
//
//     // ✅ password optional: only validate if user typed
//     final p = password.text.trim();
//     final cp = confirmPassword.text.trim();
//     if (p.isNotEmpty || cp.isNotEmpty) {
//       if (p.length < 4) {
//         Get.snackbar("Invalid", "Password too short", snackPosition: SnackPosition.BOTTOM);
//         return false;
//       }
//       if (p != cp) {
//         Get.snackbar("Mismatch", "Password and Confirm Password must match",
//             snackPosition: SnackPosition.BOTTOM);
//         return false;
//       }
//     }
//
//     return true;
//   }
//
//   // Future<void> updateRetailer() async {
//   //   if (isUpdating.value) return;
//   //   Get.focusScope?.unfocus();
//   //
//   //   if (!validate()) return;
//   //
//   //   final req = UpdateRetailerRequest(
//   //     retailerName: retailerName.text.trim(),
//   //     ownerName: ownerName.text.trim(),
//   //     phone: phone.text.trim(),
//   //     email: email.text.trim(),
//   //     membershipPlan: plan.text.trim(),
//   //     state: state.text.trim(),
//   //     address: address.text.trim(),
//   //     gstNumber: gst.text.trim(),
//   //     password: password.text.trim().isEmpty ? null : password.text.trim(),
//   //     confirmPassword: confirmPassword.text.trim().isEmpty ? null : confirmPassword.text.trim(),
//   //   );
//   //
//   //   try {
//   //     isUpdating.value = true;
//   //
//   //     final resp = await _service.updateRetailer(
//   //       retailerId: retailerId,
//   //       request: req,
//   //       imageFile: selectedImage.value, // optional
//   //     );
//   //
//   //     if (resp == null) {
//   //       Get.snackbar("Error", "No response from server", snackPosition: SnackPosition.BOTTOM);
//   //       return;
//   //     }
//   //
//   //     if (resp.status == 200) {
//   //       Get.snackbar(
//   //         "Success",
//   //         resp.message ?? "Retailer updated successfully",
//   //         snackPosition: SnackPosition.BOTTOM,
//   //         backgroundColor: const Color(0xFF16A34A),
//   //         colorText: Colors.white,
//   //         margin: const EdgeInsets.all(12),
//   //         borderRadius: 12,
//   //         duration: const Duration(seconds: 2),
//   //       );
//   //
//   //       // ✅ return result so list/details can refresh if needed
//   //       Get.back(result: true);
//   //     } else {
//   //       Get.snackbar("Error", resp.message ?? "Update failed",
//   //           snackPosition: SnackPosition.BOTTOM);
//   //     }
//   //   } finally {
//   //     isUpdating.value = false;
//   //   }
//   // }
//
//   Future<void> updateRetailer() async {
//     if (isUpdating.value) return;
//     Get.focusScope?.unfocus();
//
//     if (!validate()) return;
//
//     final req = UpdateRetailerRequest(
//       retailerName: retailerName.text.trim(),
//       ownerName: ownerName.text.trim(),
//       phone: phone.text.trim(),
//       email: email.text.trim(),
//       membershipPlan: plan.text.trim(),
//       state: state.text.trim(),
//       address: address.text.trim(),
//       gstNumber: gst.text.trim(),
//       password: password.text.trim().isEmpty ? null : password.text.trim(),
//       confirmPassword: confirmPassword.text.trim().isEmpty ? null : confirmPassword.text.trim(),
//     );
//
//     try {
//       isUpdating.value = true;
//
//       final resp = await _service.updateRetailer(
//         retailerId: retailerId,
//         request: req,
//         imageFile: selectedImage.value,
//       );
//
//       if (resp == null) {
//         Get.snackbar("Error", "No response from server",
//             snackPosition: SnackPosition.BOTTOM);
//         return;
//       }
//
//       if (resp.status == 200) {
//         // ✅ success snackbar (you already had)
//         Get.snackbar(
//           "Success",
//           resp.message ?? "Retailer updated successfully",
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: const Color(0xFF16A34A),
//           colorText: Colors.white,
//           margin: const EdgeInsets.all(12),
//           borderRadius: 12,
//           duration: const Duration(seconds: 2),
//         );
//
//         // ✅ OPTIONAL: refresh list if controller exists (NO impact if not)
//         if (Get.isRegistered<RetailerController>()) {
//           final listC = Get.find<RetailerController>();
//           await listC.fetchRetailers(); // reload list
//         }
//
//         // ✅ POP EDIT PAGE
//         Get.back(result: true);
//
//         // ✅ POP VIEW PAGE → back to TotalRetailerListPage
//         // (small delay so first pop completes cleanly)
//         Future.delayed(const Duration(milliseconds: 200), () {
//           if (Get.key.currentState?.canPop() ?? false) {
//             Get.back(result: true);
//           }
//         });
//
//       } else {
//         Get.snackbar(
//           "Error",
//           resp.message ?? "Update failed",
//           snackPosition: SnackPosition.BOTTOM,
//         );
//       }
//     } finally {
//       isUpdating.value = false;
//     }
//   }
//
//   @override
//   void onClose() {
//     retailerName.dispose();
//     ownerName.dispose();
//     phone.dispose();
//     email.dispose();
//     plan.dispose();
//     state.dispose();
//     address.dispose();
//     gst.dispose();
//     password.dispose();
//     confirmPassword.dispose();
//     super.onClose();
//   }
// }


import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zlock_smart_finance/model/retailer_details_response.dart';
import 'package:zlock_smart_finance/app/services/manage_account_service.dart';

import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zlock_smart_finance/model/retailer_details_response.dart';
import 'package:zlock_smart_finance/app/services/manage_account_service.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zlock_smart_finance/model/retailer_details_response.dart';
import 'package:zlock_smart_finance/app/services/manage_account_service.dart';
import 'package:zlock_smart_finance/modules/distributor/total_retailer/view_retailer_page.dart';

class EditRetailerController extends GetxController {
  final String retailerId;
  final RetailerDetailsData data;

  EditRetailerController({
    required this.retailerId,
    required this.data,
  });

  final isUpdating = false.obs;

  /// CONTROLLERS
  final retailerName = TextEditingController();
  final companyName = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final state = TextEditingController();
  final city = TextEditingController();
  final address = TextEditingController();
  final gst = TextEditingController();

  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  /// IMAGE
  final existingImageUrl = "".obs;
  final Rx<File?> selectedImage = Rx<File?>(null);

  final _picker = ImagePicker();
  final _service = ManageAccountService();
  final RetailerController rc = Get.isRegistered<RetailerController>()
      ? Get.find<RetailerController>()
      : Get.put(RetailerController());

  @override
  void onInit() {
    super.onInit();

    /// ✅ PREFILL
    retailerName.text = data.retailerName;
    companyName.text = data.companyName ?? data.ownerName;
    phone.text = data.mobile;
    email.text = data.email;
    state.text = data.state;
    city.text = data.city ?? "";
    address.text = data.address ?? "";
    gst.text = data.gstNumber ?? "";

    existingImageUrl.value = data.image ?? "";

    /// 🔥 DEBUG PREFILL
    print("🟢 PREFILL DATA:");
    print("ID: $retailerId");
    print("Name: ${data.retailerName}");
    print("Company: ${data.companyName}");
    print("Phone: ${data.mobile}");
    print("Email: ${data.email}");
    print("State: ${data.state}");
    print("City: ${data.city}");
    print("Address: ${data.address}");
    print("GST: ${data.gstNumber}");
    print("Image: ${data.image}");
  }

  Future<void> pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      selectedImage.value = File(picked.path);
      print("📸 PICKED IMAGE: ${picked.path}");
    }
  }

  Future<void> updateRetailer() async {
    if (isUpdating.value) return;

    try {
      isUpdating.value = true;

      /// ✅ CORRECT PAYLOAD (BACKEND MATCH 🔥)
      final payload = <String, dynamic>{
        "id": retailerId, // 🔥 MUST
        "name": retailerName.text.trim(), // 🔥 FIXED
        "company": companyName.text.trim(), // 🔥 FIXED
        "phone": phone.text.trim(),
        "state": state.text.trim(),
      };

      if (city.text.trim().isNotEmpty) {
        payload["city"] = city.text.trim();
      }

      if (address.text.trim().isNotEmpty) {
        payload["address"] = address.text.trim();
      }

      if (gst.text.trim().isNotEmpty) {
        payload["gst"] = gst.text.trim();
      }

      if (password.text.trim().isNotEmpty) {
        payload["password"] = password.text.trim();
      }

      if (confirmPassword.text.trim().isNotEmpty) {
        payload["confirmPassword"] = confirmPassword.text.trim();
      }

      /// 🔥 DEBUG PAYLOAD
      print("🚀 UPDATE API PAYLOAD:");
      payload.forEach((key, value) {
        print("$key : $value");
      });

      if (selectedImage.value != null) {
        print("📸 IMAGE FILE: ${selectedImage.value!.path}");
      }

      final res = await _service.updateProfileMultipart(
        payload: payload,
        imageFile: selectedImage.value,
      );

      /// 🔥 RESPONSE DEBUG
      print("📩 SUCCESS: ${res.success.runtimeType}");
      print("📩 MESSAGE: ${res.message}");
      print("📩 DATA: ${res.data}");

      if (res.success) {
        rc.fetchRetailers();

        print("🟢 SUCCESS BLOCK ENTERED");

        Get.snackbar("Success", res.message);
        // Get.back(result: true);

        /// 🔥 PROPER NAVIGATION FLOW
        Future.delayed(const Duration(seconds: 1), () {
          Get.offAllNamed(AppRoutes.DASH_DISTRIBUTOR);

        });

      } else {
        print("🔴 FAILED BLOCK");
        Get.snackbar("Error", res.message);
      }
    } catch (e) {
      print("❌ FULL ERROR: $e");

      /// 🔥 अगर Dio error है तो body print करो
      if (e.toString().contains("DioException")) {
        print("❌ POSSIBLE BACKEND ERROR RESPONSE");
      }

      Get.snackbar("Error", "Update failed");
    } finally {
      isUpdating.value = false;
    }
  }
}