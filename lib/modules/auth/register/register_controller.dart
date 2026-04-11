import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zlock_smart_finance/app/services/dio_client.dart';
import 'package:zlock_smart_finance/app/services/retailer_api.dart';

class RegisterController extends GetxController {
  // controllers
  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final state = TextEditingController();
  final city = TextEditingController();
  final address = TextEditingController();
  final company = TextEditingController();
  final password = TextEditingController();

  final selectedType = "".obs;
  final isLoading = false.obs;
  final isObscure = true.obs;

  File? profileImage;

  // dropdown mapping
  final Map<String, String> typeMap = {
    "Super Distributor": "super distributor",
    "Distributor": "distributor",
    "Sub Distributor": "sub distributor",
    "Retailer": "vendor",
    "SubRetailer": "subretailer",
  };

  // ================= VALIDATION =================
  bool validate() {
    if (name.text.trim().isEmpty) {
      Get.snackbar("Error", "Name min required");
      return false;
    }
    if (!GetUtils.isEmail(email.text.trim())) {
      Get.snackbar("Error", "Invalid email");
      return false;
    }
    if (phone.text.trim().length < 10) {
      Get.snackbar("Error", "Phone min 10 digits");
      return false;
    }
    if (state.text.trim().length < 3) {
      Get.snackbar("Error", "Enter valid state");
      return false;
    }
    if (city.text.trim().isEmpty) {
      Get.snackbar("Error", "City Required");
      return false;
    }
    if (address.text.trim().length < 10) {
      Get.snackbar("Error", "Address min 10 characters");
      return false;
    }
    if (company.text.trim().length < 3) {
      Get.snackbar("Error", "Company required");
      return false;
    }
    if (password.text.trim().length < 6) {
      Get.snackbar("Error", "Password min 6 chars");
      return false;
    }
    if (selectedType.value.isEmpty) {
      Get.snackbar("Error", "Select type");
      return false;
    }
    return true;
  }

  // ================= IMAGE PICK =================
  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      profileImage = File(picked.path);
      print("📸 Image selected: ${profileImage!.path}");
    }
  }

  void clearForm() {
    name.clear();
    email.clear();
    phone.clear();
    state.clear();
    city.clear();
    address.clear();
    company.clear();
    password.clear();
    selectedType.value = "";
    profileImage = null;

    print("🧹 FORM CLEARED");
  }
  // ================= REGISTER =================
  Future<void> register() async {
    if (!validate()) return;

    try {
      isLoading.value = true;

      print("========== REGISTER START ==========");

      final form = FormData();

      // fields
      form.fields.addAll([
        MapEntry("name", name.text.trim()),
        MapEntry("email", email.text.trim()),
        MapEntry("phone", phone.text.trim()),
        MapEntry("company", company.text.trim()),
        MapEntry("state", state.text.trim()),
        MapEntry("city", city.text.trim()),
        MapEntry("address", address.text.trim()),
        MapEntry("password", password.text.trim()),
        MapEntry("type", typeMap[selectedType.value]!),
        MapEntry("keyType", "form"),
      ]);

      // image optional
      if (profileImage != null) {
        form.files.add(
          MapEntry(
            "profileImage",
            await MultipartFile.fromFile(
              profileImage!.path,
              filename: profileImage!.path.split('/').last,
            ),
          ),
        );
      }

      // debug
      for (var f in form.fields) {
        print("FIELD => ${f.key}: ${f.value}");
      }
      for (var f in form.files) {
        print("FILE => ${f.key}: ${f.value.filename}");
      }

      final res = await ApiClient.dio.post(
        RetailerAPI.registerVendor,
        data: form,
        options: Options(
          contentType: "multipart/form-data",
          validateStatus: (_) => true,
        ),
      );

      print("STATUS => ${res.statusCode}");
      print("RESPONSE => ${res.data}");

      // if (res.data["success"] == true) {
      //
      //   print("✅ REGISTER SUCCESS FLOW START");
      //
      //   final message = res.data["message"] ?? "Registered successfully";
      //
      //   // ✅ Show proper snackbar
      //   Get.snackbar(
      //     "Success",
      //     message,
      //     snackPosition: SnackPosition.BOTTOM,
      //     backgroundColor: const Color(0xFF16A34A),
      //     colorText: Colors.white,
      //     duration: const Duration(seconds: 2),
      //   );
      //
      //   // ✅ Save token
      //   final token = res.data["token"];
      //   if (token != null) {
      //     print("🔑 SAVING TOKEN");
      //     GetStorage().write("token", token);
      //     ApiClient.attachToken();
      //   }
      //
      //   // ✅ WAIT then navigate
      //   await Future.delayed(const Duration(milliseconds: 1200));
      //
      //   print("🔙 NAVIGATING BACK TO LOGIN");
      //
      //   if (Get.isOverlaysOpen) Get.back(); // snackbar safe
      //   Get.back(); // screen pop
      //
      // }
      if (res.data["success"] == true) {

        print("✅ REGISTER SUCCESS FLOW START");

        final message = res.data["message"] ?? "Registered successfully";

        Get.snackbar(
          "Success",
          message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF16A34A),
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );

        final token = res.data["token"];
        if (token != null) {
          print("🔑 SAVING TOKEN");
          GetStorage().write("token", token);
          ApiClient.attachToken();
        }

        // ✅ clear form
        clearForm();

        await Future.delayed(const Duration(seconds: 2));

        print("🔙 NAVIGATING BACK TO LOGIN");

        if (Get.context != null && Navigator.canPop(Get.context!)) {
          Get.back(result: {
            "email": email.text.trim(),
            "password": password.text.trim(),
          });
        }
      }
      else {
        Get.snackbar("Error", res.data["message"]);
      }

      print("========== REGISTER END ==========");
    } catch (e) {
      print("❌ REGISTER ERROR: $e");
      Get.snackbar("Error", "Registration failed");
    } finally {
      isLoading.value = false;
    }
  }
}