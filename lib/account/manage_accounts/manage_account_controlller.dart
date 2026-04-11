// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:signature/signature.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// import 'package:path/path.dart' as path;
//
// class ManageAccountController extends GetxController {
//   // Observables
//   final company = ''.obs;
//   final fullName = ''.obs;
//   final email = ''.obs;
//   final phone = ''.obs;
//   final dob = ''.obs; // store as string like 09/08/1997
//   final address = ''.obs;
//   final city = ''.obs;
//   final gst = ''.obs;
//
//   // profile image (local file path)
//   final profileImagePath = RxnString();
//   final isLoading = false.obs;
//
//   // Signature controller from signature package
//   final signatureController = SignatureController(
//     penStrokeWidth: 3,
//     penColor: Colors.black,
//     exportBackgroundColor: Colors.white,
//   );
//
//   // Image picker
//   final ImagePicker _picker = ImagePicker();
//
//   @override
//   void onInit() {
//     super.onInit();
//     // You can load existing user data here (from API/local storage)
//     // Example stub:
//     company.value = 'P.S International';
//     fullName.value = 'Jonathan Frixy Alexander';
//     email.value = 'jonathanfrixy@gmail.com';
//     phone.value = '998288630022';
//     dob.value = '09/08/1997';
//     address.value = '789 Oakwood Drive, Springdale, FL 32003';
//     city.value = 'Delhi';
//     gst.value = '01AYDSK514ZY';
//     // profileImagePath remains null until user picks
//   }
//
//   Future<void> pickProfileImage(ImageSource source) async {
//     try {
//       final XFile? picked = await _picker.pickImage(
//         source: source,
//         imageQuality: 85,
//         maxWidth: 1200,
//         maxHeight: 1200,
//       );
//       if (picked != null) {
//         profileImagePath.value = picked.path;
//       }
//     } catch (e) {
//       debugPrint('Image pick error: $e');
//       Get.snackbar(
//           'Error',
//           'Could not pick image',
//         snackPosition: SnackPosition.BOTTOM,   // ⬅️ BOTTOM POSITION
//         margin: const EdgeInsets.all(12),
//         backgroundColor: Colors.red.withOpacity(0.9),
//         colorText: Colors.white,
//         borderRadius: 12,
//
//       );
//     }
//   }
//
//   void resetSignature() {
//     signatureController.clear();
//   }
//
//   // Optional: convert dob DateTime to string
//   void setDobFromDate(DateTime d) {
//     dob.value = DateFormat('dd/MM/yyyy').format(d);
//   }
//
//   bool validateFields() {
//     if (fullName.value.trim().isEmpty) {
//       Get.snackbar(
//           'Validation',
//           'Please enter full name',
//         snackPosition: SnackPosition.BOTTOM,   // ⬅️ BOTTOM POSITION
//         margin: const EdgeInsets.all(12),
//         backgroundColor: Colors.red.withOpacity(0.9),
//         colorText: Colors.white,
//         borderRadius: 12,
//
//       );
//       return false;
//     }
//     if (email.value.trim().isEmpty) {
//       Get.snackbar('Validation', 'Please enter email',
//         snackPosition: SnackPosition.BOTTOM,   // ⬅️ BOTTOM POSITION
//         margin: const EdgeInsets.all(12),
//         backgroundColor: Colors.red.withOpacity(0.9),
//         colorText: Colors.white,
//         borderRadius: 12,
//
//       );
//       return false;
//     }
//     // add more validations as needed
//     return true;
//   }
//
//   Future<void> updateProfile() async {
//     if (!validateFields()) return;
//
//     try {
//       isLoading.value = true;
//
//       // API endpoint - replace with your real endpoint
//       final uri = Uri.parse('https://example.com/api/updateProfile');
//
//       final request = http.MultipartRequest('POST', uri);
//
//       // Add headers if needed, e.g., auth token:
//       // request.headers['Authorization'] = 'Bearer YOUR_TOKEN';
//
//       // Add text fields
//       request.fields['company'] = company.value;
//       request.fields['full_name'] = fullName.value;
//       request.fields['email'] = email.value;
//       request.fields['phone'] = phone.value;
//       request.fields['dob'] = dob.value;
//       request.fields['address'] = address.value;
//       request.fields['city'] = city.value;
//       request.fields['gst'] = gst.value;
//
//       // Attach profile image if available
//       if (profileImagePath.value != null && profileImagePath.value!.isNotEmpty) {
//         final file = File(profileImagePath.value!);
//         final fileStream = http.ByteStream(Stream.castFrom(file.openRead()));
//         final length = await file.length();
//
//         final multipartFile = http.MultipartFile(
//           'profile_image',
//           fileStream,
//           length,
//           filename: path.basename(file.path),
//         );
//         request.files.add(multipartFile);
//       }
//
//       // Attach signature as PNG if not empty
//       final signatureData = await signatureController.toPngBytes();
//       if (signatureData != null && signatureData.isNotEmpty) {
//         final multipartSignature = http.MultipartFile.fromBytes(
//           'signature',
//           signatureData,
//           filename: 'signature_${DateTime.now().millisecondsSinceEpoch}.png',
//           // contentType:
//           // contentType: MediaType('image', 'png'),
//         );
//         request.files.add(multipartSignature);
//       }
//
//       // Send request
//       final streamed = await request.send();
//       final response = await http.Response.fromStream(streamed);
//
//       if (response.statusCode == 200) {
//         // parse response if needed
//         Get.snackbar(
//           'Success',
//           'Profile updated',
//           snackPosition: SnackPosition.BOTTOM,   // bottom
//           snackStyle: SnackStyle.FLOATING,       // floating style
//           backgroundColor: Colors.green.withOpacity(0.9),
//           colorText: Colors.white,
//           borderRadius: 12,
//           margin: const EdgeInsets.all(16),
//           duration: const Duration(seconds: 2),
//         );
//       } else {
//         debugPrint('Error response: ${response.statusCode} ${response.body}');
//         Get.snackbar(
//           'Error',
//           'Failed to update profile. Try again.',
//           snackPosition: SnackPosition.BOTTOM,   // ⬅️ BOTTOM POSITION
//           margin: const EdgeInsets.all(12),
//           backgroundColor: Colors.red.withOpacity(0.9),
//           colorText: Colors.white,
//           borderRadius: 12,
//         );
//       }
//     } catch (e, st) {
//       debugPrint('Update error: $e\n$st');
//       Get.snackbar('Error', 'Something went wrong',
//         snackPosition: SnackPosition.BOTTOM,   // ⬅️ BOTTOM POSITION
//         margin: const EdgeInsets.all(12),
//         backgroundColor: Colors.red.withOpacity(0.9),
//         colorText: Colors.white,
//         borderRadius: 12,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   // Date picker helper
//   Future<void> showDobPicker(BuildContext context) async {
//     DateTime initial = DateTime.now().subtract(const Duration(days: 365 * 18));
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: initial,
//       firstDate: DateTime(1900),
//       lastDate: DateTime.now(),
//     );
//     if (picked != null) {
//       setDobFromDate(picked);
//     }
//   }
// }
//
// // Helper for content-type (http.MultipartFile needs MediaType)
// class MediaType {
//   final String type;
//   final String subtype;
//   MediaType(this.type, this.subtype);
//
//   @override
//   String toString() => '$type/$subtype';
// }

import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:signature/signature.dart';

import 'package:flutter/material.dart';
import 'package:zlock_smart_finance/app/services/manage_account_service.dart';
import 'package:zlock_smart_finance/app/services/profile_api_services.dart';
import 'package:zlock_smart_finance/model/user_profile_model.dart';


class ManageAccountController extends GetxController {
  final company = ''.obs;
  final fullName = ''.obs;
  final userId = ''.obs;
  final email = ''.obs;
  final phone = ''.obs;
  final dob = ''.obs;

  final address = ''.obs;
  final city = ''.obs;
  final gst = ''.obs;
  final aadhaar = ''.obs;

  final state = ''.obs;
  final zipCode = ''.obs;

  final profileImagePath = RxnString();
  final userImageUrl = ''.obs;

  final isLoading = false.obs;
  String get signatureUrl => _originalUser?.signature ?? "";

  final isEditingSignature = false.obs;
  final signatureController = SignatureController(
    penStrokeWidth: 3,
    penColor: const Color(0xFF000000),
    exportBackgroundColor: const Color(0xFFFFFFFF),
  );

  final ImagePicker _picker = ImagePicker();

  final _profileService = ProfileService();
  final _service = ManageAccountService();

  User? _originalUser;

  void startSignatureEdit() {
    isEditingSignature.value = true;
    signatureController.clear();
  }

  void resetSignature() {
    signatureController.clear();
    isEditingSignature.value = true;
  }
  @override
  void onInit() {
    super.onInit();
    fetchProfileAndFill();
  }

  /// ---------------- FETCH PROFILE ----------------
  // Future<void> fetchProfileAndFill() async {
  //   debugPrint("🟢 ManageAccount: fetchProfileAndFill()");
  //
  //   final resp = await _profileService.getProfile();
  //
  //   if (resp?.status != 200 || resp?.data?.user == null) {
  //     debugPrint("❌ ManageAccount: profile not loaded");
  //     return;
  //   }
  //
  //   final user = resp!.data!.user!;
  //   _originalUser = user;
  //
  //   company.value = user.companyName ?? '';
  //   fullName.value = user.displayName;
  //   email.value = user.email ?? '';
  //   phone.value = user.phone ?? '';
  //
  //   city.value = user.city ?? '';
  //
  //   address.value = user.address ?? '';
  //   gst.value = user.gst ?? '';
  //   state.value = user.state ?? '';
  //   zipCode.value = '';
  //
  //   update();
  //
  //   // debugPrint("🖼️ PROFILE IMAGE: ${user.image}");
  //   // debugPrint("✍️ SIGNATURE: ${user.signature}");
  //   // debugPrint("✅ ManageAccount: fields filled");
  // }

  Future<void> fetchProfileAndFill() async {
    final resp = await _profileService.getProfile();

    if (resp?.status != 200 || resp?.data?.user == null) return;

    final user = resp!.data!.user!;
    _originalUser = user;

    company.value = user.companyName ?? '';
    fullName.value = user.displayName;
    email.value = user.email ?? '';
    phone.value = user.phone ?? '';
    userId.value = user.id ?? '';
    print("user Id >>>>>>>>>>${userId.value}");
    city.value = user.city ?? '';
    address.value = user.address ?? '';
    gst.value = user.gst ?? '';
    state.value = user.state ?? '';

    /// 🔥 IMPORTANT
    userImageUrl.value = user.image ?? "";

    debugPrint("🖼️ IMAGE: ${user.image}");
    debugPrint("✍️ SIGNATURE: ${user.signature}");
  }
  /// ---------------- IMAGE PICK ----------------
  // Future<void> pickProfileImage(ImageSource source) async {
  //   try {
  //     final XFile? picked = await _picker.pickImage(
  //       source: source,
  //       imageQuality: 85,
  //       maxWidth: 1200,
  //       maxHeight: 1200,
  //     );
  //
  //     if (picked == null) return;
  //
  //     profileImagePath.value = picked.path;
  //
  //     await uploadSelectedProfileImage();
  //   } catch (e) {
  //     debugPrint('Image pick error: $e');
  //
  //     Get.snackbar(
  //       "Error",
  //       "Could not pick image",
  //       snackPosition: SnackPosition.BOTTOM,
  //     );
  //   }
  // }

  Future<void> pickProfileImage(ImageSource source) async {
    try {
      final XFile? picked = await _picker.pickImage(source: source);

      if (picked == null) return;

      profileImagePath.value = picked.path;

      debugPrint("📸 Selected Image: ${picked.path}");

    } catch (e) {
      debugPrint('Image pick error: $e');
    }
  }
  /// ---------------- IMAGE UPLOAD ----------------
  Future<void> uploadSelectedProfileImage() async {
    final p = profileImagePath.value;

    if (p == null || p.isEmpty) return;

    final file = File(p);

    if (!file.existsSync()) {
      Get.snackbar(
        "Error",
        "Image file not found",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isLoading.value = true;

    final resp = await _service.uploadProfileImage(file);

    isLoading.value = false;

    if (!resp.success) {
      Get.snackbar(
        "Error",
        resp.message,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      final data = resp.data;
      final img = (data is Map) ? (data["image"]?.toString() ?? "") : "";

      if (img.isNotEmpty) {
        userImageUrl.value = img;
      }
    } catch (_) {}

    Get.snackbar(
      "Success",
      resp.message,
      snackPosition: SnackPosition.BOTTOM,
    );
  }


  /// ---------------- DOB ----------------
  void setDobFromDate(DateTime d) {
    dob.value = DateFormat('dd/MM/yyyy').format(d);
  }

  Future<void> showDobPicker(context) async {
    DateTime initial = DateTime.now().subtract(const Duration(days: 365 * 18));

    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) setDobFromDate(picked);
  }

  /// ---------------- VALIDATION ----------------
  bool validateFields() {
    if (fullName.value.trim().isEmpty) {
      Get.snackbar(
        "Validation",
        "Please enter full name",
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    if (email.value.trim().isEmpty) {
      Get.snackbar(
        "Validation",
        "Please enter email",
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    if (!GetUtils.isEmail(email.value.trim())) {
      Get.snackbar(
        "Validation",
        "Please enter valid email",
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    return true;
  }

  /// ---------------- BUILD UPDATE PAYLOAD ----------------
  // Map<String, dynamic> _buildEditPayloadOnlyChanged() {
  //   final u = _originalUser;
  //
  //   bool changed(String? oldVal, String newVal) {
  //     return (oldVal ?? "").trim() != newVal.trim();
  //   }
  //
  //   final payload = <String, dynamic>{};
  //
  //   if (changed(u?.name, fullName.value)) {
  //     payload["name"] = fullName.value.trim();
  //   }
  //
  //   if (changed(u?.phone, phone.value)) {
  //     payload["phone"] = phone.value.trim();
  //   }
  //
  //   if (changed(u?.email, email.value)) {
  //     payload["email"] = email.value.trim();
  //   }
  //
  //   if (changed(u?.companyName, company.value)) {
  //     payload["company"] = company.value.trim();
  //   }
  //
  //   if (changed(u?.city, city.value)) {
  //     payload["city"] = city.value.trim();
  //   }
  //
  //   if (changed(u?.state, state.value)) {
  //     payload["state"] = state.value.trim();
  //   }
  //
  //   if (changed(u?.address, address.value)) {
  //     payload["address"] = address.value.trim();
  //   }
  //
  //   if (changed(u?.gst, gst.value)) {
  //     payload["gst"] = gst.value.trim();
  //   }
  //
  //   return payload;
  // }

  Map<String, dynamic> _buildEditPayloadOnlyChanged() {
    final u = _originalUser;

    final payload = <String, dynamic>{};

    payload["id"] = u?.id;

    payload["name"] = fullName.value.trim();
    payload["email"] = email.value.trim();
    payload["phone"] = phone.value.trim();
    payload["company"] = company.value.trim();
    payload["city"] = city.value.trim();
    payload["state"] = state.value.trim();
    payload["address"] = address.value.trim();
    payload["gst"] = gst.value.trim();

    return payload;
  }

  /// ---------------- UPDATE PROFILE ----------------
  // Future<void> updateProfile() async {
  //   if (!validateFields()) return;
  //
  //   final payload = _buildEditPayloadOnlyChanged();
  //
  //   if (payload.isEmpty) {
  //     Get.snackbar(
  //       "Info",
  //       "No changes to update",
  //       snackPosition: SnackPosition.BOTTOM,
  //     );
  //     return;
  //   }
  //
  //   isLoading.value = true;
  //
  //   // final resp = await _service.updateProfile(payload);
  //   //
  //   // isLoading.value = false;
  //   //
  //   // if (!resp.success) {
  //   //   Get.snackbar(
  //   //     "Error",
  //   //     resp.message,
  //   //     snackPosition: SnackPosition.BOTTOM,
  //   //   );
  //   //   return;
  //   // }
  //   //
  //   // Get.snackbar(
  //   //   "Success",
  //   //   resp.message,
  //   //   snackPosition: SnackPosition.BOTTOM,
  //   // );
  //
  //   Future<void> uploadSelectedProfileImage() async {
  //     final p = profileImagePath.value;
  //
  //     debugPrint("📸 Selected image path: $p");
  //
  //     if (p == null || p.isEmpty) return;
  //
  //     final file = File(p);
  //
  //     if (!file.existsSync()) {
  //       debugPrint("❌ File not exists");
  //       Get.snackbar("Error", "Image file not found",
  //           snackPosition: SnackPosition.BOTTOM);
  //       return;
  //     }
  //
  //     debugPrint("🚀 Uploading image...");
  //
  //     isLoading.value = true;
  //
  //     final resp = await _service.uploadProfileImage(file);
  //
  //     isLoading.value = false;
  //
  //     debugPrint("📩 Upload success: ${resp.success}");
  //     debugPrint("📩 Upload message: ${resp.message}");
  //     debugPrint("📩 Upload data: ${resp.data}");
  //
  //     if (!resp.success) {
  //       Get.snackbar("Error", resp.message,
  //           snackPosition: SnackPosition.BOTTOM);
  //       return;
  //     }
  //
  //     try {
  //       final data = resp.data;
  //       final img = (data is Map) ? (data["image"]?.toString() ?? "") : "";
  //
  //       debugPrint("🖼️ SERVER IMAGE URL: $img");
  //
  //       if (img.isNotEmpty) {
  //         userImageUrl.value = img;
  //       }
  //     } catch (e) {
  //       debugPrint("❌ IMAGE PARSE ERROR: $e");
  //     }
  //
  //     Get.snackbar("Success", resp.message,
  //         snackPosition: SnackPosition.BOTTOM);
  //   }
  //   await fetchProfileAndFill();
  // }

  // Future<void> updateProfile() async {
  //   if (!validateFields()) return;
  //
  //   /// 🔥 ALWAYS SEND REQUIRED DATA
  //   final payload = _buildEditPayloadOnlyChanged();
  //
  //   /// ✅ ensure id
  //   if (_originalUser?.id == null) {
  //     debugPrint("❌ USER ID NULL");
  //     Get.snackbar("Error", "User ID missing");
  //     return;
  //   }
  //
  //   payload["id"] = _originalUser!.id;
  //
  //   /// ✅ DEBUG PRINTS
  //   debugPrint("📦 PAYLOAD: $payload");
  //
  //   /// IMAGE
  //   File? imageFile;
  //   if (profileImagePath.value != null &&
  //       profileImagePath.value!.isNotEmpty) {
  //     imageFile = File(profileImagePath.value!);
  //     debugPrint("📸 IMAGE PATH: ${imageFile.path}");
  //   } else {
  //     debugPrint("⚠️ No image selected");
  //   }
  //
  //   /// SIGNATURE
  //   final signBytes = await signatureController.toPngBytes();
  //
  //   if (signBytes != null && signBytes.isNotEmpty) {
  //     debugPrint("✍️ SIGNATURE SIZE: ${signBytes.length}");
  //   } else {
  //     debugPrint("⚠️ Signature empty");
  //   }
  //
  //   isLoading.value = true;
  //
  //   final resp = await _service.updateProfileMultipart(
  //     payload: payload,
  //     imageFile: imageFile,
  //     signatureBytes: signBytes,
  //   );
  //
  //   isLoading.value = false;
  //
  //   /// 🔥 RESPONSE DEBUG
  //   debugPrint("📩 SUCCESS: ${resp.success}");
  //   debugPrint("📩 MESSAGE: ${resp.message}");
  //   debugPrint("📩 DATA: ${resp.data}");
  //
  //   if (!resp.success) {
  //     Get.snackbar("Error", resp.message);
  //     return;
  //   }
  //
  //   Get.snackbar("Success", resp.message);
  //
  //   await fetchProfileAndFill();
  // }

  Future<void> updateProfile() async {
    if (!validateFields()) return;

    /// ✅ PAYLOAD
    final payload = _buildEditPayloadOnlyChanged();

    /// ✅ USER ID CHECK
    if (_originalUser?.id == null) {
      debugPrint("❌ USER ID NULL");
      Get.snackbar("Error", "User ID missing");
      return;
    }

    payload["id"] = _originalUser!.id;

    debugPrint("📦 FINAL PAYLOAD: $payload");

    /// ✅ IMAGE FILE
    File? imageFile;
    if (profileImagePath.value != null &&
        profileImagePath.value!.isNotEmpty) {
      imageFile = File(profileImagePath.value!);
      debugPrint("📸 IMAGE PATH: ${imageFile.path}");
    } else {
      debugPrint("⚠️ No image selected");
    }

      final signBytes = await signatureController.toPngBytes();

    /// ✅ LOADING START
    isLoading.value = true;

    try {
      final resp = await _service.updateProfileMultipart(
        payload: payload,
        imageFile: imageFile,
        signatureBytes: signBytes, // 👈 null allowed
      );

      /// 🔥 RESPONSE DEBUG
      debugPrint("📩 SUCCESS: ${resp.success}");
      debugPrint("📩 MESSAGE: ${resp.message}");
      debugPrint("📩 DATA: ${resp.data}");

      if (!resp.success) {
        Get.snackbar("Error", resp.message);
        return;
      }
      /// ✅ INSTANT UI UPDATE (VERY IMPORTANT 🔥)
      if (isEditingSignature.value && signBytes != null) {
        final tempFile = File(
          "${Directory.systemTemp.path}/temp_signature.png",
        );

        await tempFile.writeAsBytes(signBytes);

        /// 👉 instant दिखाने के लिए local preview
        _originalUser = _originalUser?.copyWith(
          signature: tempFile.path,
        );

        debugPrint("⚡ SIGNATURE INSTANT UPDATED");
      }

      /// ✅ RESET EDIT MODE
      isEditingSignature.value = false;

      Get.snackbar("Success", resp.message);

      /// ✅ REFRESH PROFILE
      await fetchProfileAndFill();

    } catch (e) {
      debugPrint("❌ UPDATE ERROR: $e");
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    signatureController.dispose();
    super.onClose();
  }
}