import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:zlock_smart_finance/app/utils/common_bottom_button.dart';
import 'package:zlock_smart_finance/modules/distributor/add_retailer/add_retailer_controller.dart';

class AddRetailerPage extends StatelessWidget {
  const AddRetailerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(AddRetailerController());

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
                    "Add Retailer",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// FORM CARD
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [
                    /// IMAGE PICKER
                    GestureDetector(
                      // onTap: c.pickImage,
                      onTap: () => c.showImagePickOptions(context),
                      child: Obx(() {
                        return Container(
                          height: 110,
                          width: 110,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF2F4F8),
                            shape: BoxShape.circle,
                            image: c.selectedImage.value != null
                                ? DecorationImage(
                              image:
                              FileImage(c.selectedImage.value!),
                              fit: BoxFit.cover,
                            )
                                : null,
                          ),
                          child: c.selectedImage.value == null
                              ? Column(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/icons/camera.svg",
                                width: 30,
                              ),
                            ],
                          )
                              : null,
                        );
                      }),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "Customer + Product Image",
                      style: TextStyle(fontSize: 11),
                    ),
                    const Text(
                      "Upload photos",
                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0xFF3D5CFF),
                      ),
                    ),


                    const SizedBox(height: 20),

                    _field("Retailer Name", c.retailerName),
                    _field("Company Name", c.ownerName),
                    _field("Retailer Phone Number", c.phone,
                        keyboard: TextInputType.phone),
                    _field("Retailer Email ID", c.email,
                        keyboard: TextInputType.emailAddress),
                    // _field("Membership Plan Name", c.plan),
                    _field("State", c.state),
                    _field("City", c.city),
                    _field("Full Address", c.address, maxLines: 3),
                    _field("GST Number", c.gst),

                    const SizedBox(height: 14),

                    /// PASSWORD CARD
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFF),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Create Password",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 12),
                          // _field("Password", c.password,
                          //     obscure: true),
                          // _field("Confirm Password",
                          //     c.confirmPassword,
                          //     obscure: true),
                          _field(
                            "Password",
                            c.password,
                            isPassword: true,
                            visibility: c.isPasswordVisible,
                          ),

                          _field(
                            "Confirm Password",
                            c.confirmPassword,
                            isPassword: true,
                            visibility: c.isConfirmPasswordVisible,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 100),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CommonBottomButtonUpdate(
        title: "Submit",
        onTap: () => c.submit(), // ✅ function CALL
      ),

    );
  }

  Widget _circleBack() {
    return GestureDetector(
      onTap: Get.back,
      child: Container(
        height: 40,
        width: 40,
        decoration: const BoxDecoration(
          color: Color(0xFFF1F3F7),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.arrow_back),
      ),
    );
  }

  // Widget _field(
  //     String hint,
  //     TextEditingController controller, {
  //       bool obscure = false,
  //       int maxLines = 1,
  //       TextInputType keyboard = TextInputType.text,
  //     }) {
  //   return Padding(
  //     padding: const EdgeInsets.only(bottom: 12),
  //     child: TextField(
  //       controller: controller,
  //       obscureText: obscure,
  //       maxLines: maxLines,
  //       keyboardType: keyboard,
  //       decoration: InputDecoration(
  //         hintText: hint,
  //         filled: true,
  //         fillColor: Colors.white,
  //         contentPadding:
  //         const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  //         border: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(14),
  //           borderSide: const BorderSide(color: Color(0xFFE3E8F1)),
  //         ),
  //         enabledBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(14),
  //           borderSide: const BorderSide(color: Color(0xFFE3E8F1)),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _field(
      String hint,
      TextEditingController controller, {
        bool isPassword = false,
        RxBool? visibility,
        int maxLines = 1,
        TextInputType keyboard = TextInputType.text,
      }) {
    /// ✅ NORMAL FIELD (NO Obx)
    if (!isPassword) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboard,
          decoration: _inputDecoration(hint),
        ),
      );
    }

    /// ✅ PASSWORD FIELD ONLY (WITH Obx)
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Obx(() {
        return TextField(
          controller: controller,
          obscureText: !(visibility!.value),
          decoration: _inputDecoration(hint).copyWith(
            suffixIcon: IconButton(
              icon: Icon(
                visibility.value
                    ? Icons.visibility
                    : Icons.visibility_off,
              ),
              onPressed: () {
                visibility.value = !visibility.value;
              },
            ),
          ),
        );
      }),
    );
  }
  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding:
      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFE3E8F1)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFE3E8F1)),
      ),
    );
  }
}
