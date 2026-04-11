
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zlock_smart_finance/modules/auth/register/register_controller.dart';
import '../../../app/constants/app_colors.dart';

// class RegisterScreen extends GetView<RegisterController> {
//   const RegisterScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: AppColors.bgGradient,
//         ),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               children: [
//
//                 const SizedBox(height: 20),
//
//                 const Text(
//                   "Create Account",
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 _field(controller.name, "Name"),
//                 _field(controller.company, "Company"),
//                 _field(controller.email, "Email"),
//                 _passwordField(),
//                 _field(controller.phone, "Phone"),
//                 _dropdown(),
//                 _field(controller.state, "State"),
//                 _imagePicker(),
//                 _field(controller.address, "Address"),
//
//                 const SizedBox(height: 20),
//
//                 Obx(() => ElevatedButton(
//                   onPressed: controller.isLoading.value
//                       ? null
//                       : controller.register,
//                   child: controller.isLoading.value
//                       ? const CircularProgressIndicator()
//                       : const Text("Register"),
//                 ))
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _field(TextEditingController c, String label) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: TextField(
//         controller: c,
//         decoration: InputDecoration(
//           labelText: label,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _passwordField() {
//     return Obx(() => TextField(
//       controller: controller.password,
//       obscureText: controller.isObscure.value,
//       decoration: InputDecoration(
//         labelText: "Password",
//         suffixIcon: IconButton(
//           icon: Icon(controller.isObscure.value
//               ? Icons.visibility_off
//               : Icons.visibility),
//           onPressed: () =>
//           controller.isObscure.value =
//           !controller.isObscure.value,
//         ),
//       ),
//     ));
//   }
//
//   Widget _dropdown() {
//     return Obx(() => DropdownButtonFormField<String>(
//       value: controller.selectedType.value.isEmpty
//           ? null
//           : controller.selectedType.value,
//       hint: const Text("Select Type"),
//       items: controller.typeMap.keys.map((e) {
//         return DropdownMenuItem(value: e, child: Text(e));
//       }).toList(),
//       onChanged: (v) => controller.selectedType.value = v!,
//     ));
//   }
//
//   Widget _imagePicker() {
//     return Row(
//       children: [
//         ElevatedButton(
//           onPressed: controller.pickImage,
//           child: const Text("Choose File"),
//         ),
//         const SizedBox(width: 10),
//         const Text("Optional"),
//       ],
//     );
//   }
// }
class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              keyboardDismissBehavior:
              ScrollViewKeyboardDismissBehavior.onDrag,
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
                        const SizedBox(height: 70),

                        /// 🔥 LOGO
                        Image.asset(
                          "assets/images/logo.png",
                          height: 120,
                        ),

                        const Spacer(),

                        /// 🔥 WHITE CARD (LIKE LOGIN)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 25),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(35),
                              topRight: Radius.circular(35),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              /// TITLE
                              const Text(
                                "Create Account 🚀",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                "Register to continue",
                                style: TextStyle(color: Colors.grey),
                              ),

                              const SizedBox(height: 20),

                              _input(controller.name, "Name", Icons.person),
                              _input(controller.company, "Company", Icons.business),
                              _input(controller.email, "Email", Icons.email),

                              /// PASSWORD
                              Obx(() => _input(
                                controller.password,
                                "Password",
                                Icons.lock,
                                isPassword: true,
                                isObscure: controller.isObscure.value,
                                onToggle: () =>
                                controller.isObscure.value =
                                !controller.isObscure.value,
                              )),

                              _input(controller.phone, "Phone", Icons.phone),

                              /// DROPDOWN
                              Obx(() => Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: AppColors.grey.withOpacity(0.4)),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: controller.selectedType.value.isEmpty
                                        ? null
                                        : controller.selectedType.value,
                                    hint: const Text("Select Type"),
                                    isExpanded: true,
                                    items: controller.typeMap.keys.map((e) {
                                      return DropdownMenuItem(
                                        value: e,
                                        child: Text(e),
                                      );
                                    }).toList(),
                                    onChanged: (v) =>
                                    controller.selectedType.value = v!,
                                  ),
                                ),
                              )),

                              _input(controller.state, "State", Icons.map),
                              _input(controller.city, "City", Icons.location_city),
                              _input(controller.address, "Address", Icons.location_on),

                              /// IMAGE PICK
                              Row(
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    onPressed: controller.pickImage,
                                    child: const Text("Choose File"),
                                  ),
                                  const SizedBox(width: 10),
                                  const Text("Optional"),
                                ],
                              ),

                              const SizedBox(height: 20),

                              /// REGISTER BUTTON
                              Obx(() => SizedBox(
                                width: double.infinity,
                                height: 55,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryDark,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                  onPressed: controller.isLoading.value
                                      ? null
                                      : controller.register,
                                  child: controller.isLoading.value
                                      ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                      : const Text(
                                    "Register",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                              )),

                              const SizedBox(height: 15),

                              /// BACK TO LOGIN
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Already have account? "),
                                  GestureDetector(
                                    onTap: () => Get.back(),
                                    child: const Text(
                                      "Login",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                ],
                              ),

                              SizedBox(
                                height: MediaQuery.of(context).viewInsets.bottom > 0 ? 10 : 0,
                              ),
                            ],
                          ),
                        )
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

  /// 🔥 COMMON INPUT (LOGIN STYLE)
  Widget _input(
      TextEditingController c,
      String label,
      IconData icon, {
        bool isPassword = false,
        bool isObscure = false,
        VoidCallback? onToggle,
      }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: AppColors.grey.withOpacity(0.4)),
      ),
      child: TextField(
        controller: c,
        obscureText: isPassword ? isObscure : false,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: AppColors.grey),
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