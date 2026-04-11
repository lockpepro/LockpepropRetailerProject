import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:zlock_smart_finance/app/routes/app_routes.dart';
import 'package:zlock_smart_finance/app/services/add_retailer_service.dart';
import 'package:zlock_smart_finance/model/add_retailer_models.dart';
import 'package:zlock_smart_finance/modules/distributor/dashboard/distributor_dash_controller.dart';

import '../../retailer/dashboard/retailer_dashboard_controller.dart';

class AddRetailerController extends GetxController {
  final ImagePicker _picker = ImagePicker();


  final Rx<File?> selectedImage = Rx<File?>(null);
  final isSubmitting = false.obs;

  final retailerName = TextEditingController();
  final ownerName = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final plan = TextEditingController();
  final state = TextEditingController();
  final city = TextEditingController();
  final address = TextEditingController();
  final gst = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;

  final _service = DistributorAddRetailerService();

  final DistributorDashController distributorController = Get.find();

  // String userId = retailerController.userId.value ??'';


  // ✅ bottom sheet like NewKeyController
  void showImagePickOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Camera"),
                onTap: () async {
                  Navigator.pop(context);
                  await pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Gallery"),
                onTap: () async {
                  Navigator.pop(context);
                  await pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.close),
                title: const Text("Cancel"),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 1200,
        maxHeight: 1200,
      );
      if (image == null) return;
      selectedImage.value = File(image.path);
      debugPrint("✅ Selected Image: ${image.path}");
    } catch (e) {
      debugPrint("❌ Image pick error: $e");
      Get.snackbar("Error", "Could not pick image", snackPosition: SnackPosition.BOTTOM);
    }
  }

  bool _isValidEmail(String v) => RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v.trim());
  bool _isValidMobile(String v) => RegExp(r'^\d{10}$').hasMatch(v.trim());

  bool validate() {
    if (retailerName.text.trim().isEmpty) {
      Get.snackbar("Required", "Retailer Name is required", snackPosition: SnackPosition.BOTTOM);
      return false;
    }
    if (ownerName.text.trim().isEmpty) {
      Get.snackbar("Required", "Owner Name is required", snackPosition: SnackPosition.BOTTOM);
      return false;
    }
    if (!_isValidMobile(phone.text)) {
      Get.snackbar("Invalid", "Enter valid 10-digit phone number", snackPosition: SnackPosition.BOTTOM);
      return false;
    }
    if (!_isValidEmail(email.text)) {
      Get.snackbar("Invalid", "Enter valid email", snackPosition: SnackPosition.BOTTOM);
      return false;
    }
    // if (plan.text.trim().isEmpty) {
    //   Get.snackbar("Required", "Membership Plan is required", snackPosition: SnackPosition.BOTTOM);
    //   return false;
    // }
    if (state.text.trim().isEmpty) {
      Get.snackbar("Required", "State is required", snackPosition: SnackPosition.BOTTOM);
      return false;
    }
    if (city.text.trim().isEmpty) {
      Get.snackbar("Required", "City is required", snackPosition: SnackPosition.BOTTOM);
      return false;
    }
    if (address.text.trim().isEmpty) {
      Get.snackbar("Required", "Address is required", snackPosition: SnackPosition.BOTTOM);
      return false;
    }
    if (gst.text.trim().isEmpty) {
      Get.snackbar("Required", "GST Number is required", snackPosition: SnackPosition.BOTTOM);
      return false;
    }
    if (password.text.trim().length < 4) {
      Get.snackbar("Invalid", "Password too short", snackPosition: SnackPosition.BOTTOM);
      return false;
    }
    if (password.text.trim() != confirmPassword.text.trim()) {
      Get.snackbar("Mismatch", "Password and Confirm Password must match",
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }
    // image optional (Postman me hai, but backend may allow null)
    return true;
  }

  Future<void> submit() async {
    if (isSubmitting.value) return;

    Get.focusScope?.unfocus();

    if (!validate()) return;

    // final req = AddRetailerRequest(
    //   retailerName: retailerName.text.trim(),
    //   ownerName: ownerName.text.trim(),
    //   phone: phone.text.trim(),
    //   email: email.text.trim(),
    //   membershipPlan: plan.text.trim(),
    //   state: state.text.trim(),
    //   address: address.text.trim(),
    //   gstNumber: gst.text.trim(),
    //   password: password.text.trim(),
    //   confirmPassword: confirmPassword.text.trim(),
    // );

    print("parent Id>>>>>>>>${distributorController.userId.value}");
    final req = AddRetailerRequest(
      email: email.text.trim(),
      password: password.text.trim(),
      name: retailerName.text.trim(), // name = retailerName
      phone: phone.text.trim(),
      company: ownerName.text.trim(), // company = ownerName
      city: city.text.trim(), // 🔥 ya field add karo UI me
      state: state.text.trim(),
      address: address.text.trim(),
      gst: gst.text.trim(),
      parent: distributorController.userId.value,

    );
    try {
      isSubmitting.value = true;

      final resp = await _service.addRetailer(
        request: req,
        imageFile: selectedImage.value, // can be null
      );

      if (resp == null) {
        Get.snackbar("Error", "No response from server", snackPosition: SnackPosition.BOTTOM);
        return;
      }

      if (resp.success == true || resp.success == true) {
        Get.snackbar(
          "Success",
          resp.message ?? "Retailer added successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF16A34A),
          colorText: Colors.white,
          margin: const EdgeInsets.all(12),
          borderRadius: 12,
          duration: const Duration(seconds: 2),
        );
        Get.offAllNamed(AppRoutes.DASH_DISTRIBUTOR);

        // ✅ return success data to previous page if needed
        // Get.back(result: resp.data);
      } else {
        Get.snackbar(
          "Error",
          resp.message ?? "Add retailer failed",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar("Error", "Add retailer failed", snackPosition: SnackPosition.BOTTOM);
    } finally {
      isSubmitting.value = false;
    }
  }

  @override
  void onClose() {
    retailerName.dispose();
    ownerName.dispose();
    phone.dispose();
    email.dispose();
    plan.dispose();
    state.dispose();
    city.dispose();
    address.dispose();
    gst.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.onClose();
  }
}

