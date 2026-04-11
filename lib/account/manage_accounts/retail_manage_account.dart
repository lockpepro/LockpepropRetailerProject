import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:signature/signature.dart';
import 'package:zlock_smart_finance/account/manage_accounts/manage_account_controlller.dart';
import 'package:zlock_smart_finance/account/widget/rounded_field.dart';

class ManageAccountScreen extends GetView<ManageAccountController> {

  const ManageAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = controller;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFEAF0FF), // light gradient color imitation
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back, color: Colors.black),
          ),
        ),
        title: const Text(
          'Manage Account',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: Obx(
            () => SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Column(
            children: [
              const SizedBox(height: 8),

              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 48,
                      backgroundColor: Colors.grey.shade200,

                      child: ClipOval(
                        child: controller.profileImagePath.value != null &&
                            controller.profileImagePath.value!.isNotEmpty
                            ? Image.file(
                          File(controller.profileImagePath.value!),
                          width: 96,
                          height: 96,
                          fit: BoxFit.cover,
                        )
                            : (controller.userImageUrl.value.isNotEmpty
                            ? Image.network(
                          controller.userImageUrl.value,
                          width: 96,
                          height: 96,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => SvgPicture.asset(
                            'assets/accounts/name.svg',
                            width: 86,
                            height: 86,
                            fit: BoxFit.cover,
                          ),
                        )
                            : SvgPicture.asset(
                          'assets/accounts/name.svg',
                          width: 86,
                          height: 86,
                          fit: BoxFit.cover,
                        )),
                      ),

                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () => _showImagePickOptions(context),
                      child: const Text(
                        'Edit Photo',
                        style: TextStyle(
                            color: Colors.black54, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // Fields
              RoundedField(
                iconPath: 'assets/accounts/building.svg',
                text: ctrl.company.value.isEmpty
                    ? 'Company Name'
                    : ctrl.company.value,
                onTap: () => _showEditFieldDialog(context, 'Company', ctrl.company),
              ),

              RoundedField(
                iconPath: 'assets/accounts/name.svg',
                text:
                ctrl.fullName.value.isEmpty ? 'Full name' : ctrl.fullName.value,
                onTap: () => _showEditFieldDialog(context, 'Full Name', ctrl.fullName),
              ),

              RoundedField(
                iconPath: 'assets/accounts/sms.svg',
                text: ctrl.email.value.isEmpty ? 'Email' : ctrl.email.value,
                onTap: () => _showEditFieldDialog(context, 'Email', ctrl.email),
              ),

              RoundedField(
                iconPath: 'assets/accounts/call.svg',
                text: ctrl.phone.value.isEmpty ? '+1 234 567 890' : ctrl.phone.value,
                onTap: () => _showEditFieldDialog(context, 'Phone', ctrl.phone),
              ),

              RoundedField(
                iconPath: 'assets/accounts/calendar.svg',
                text: ctrl.dob.value.isEmpty ? 'DOB' : ctrl.dob.value,
                onTap: () => ctrl.showDobPicker(context),
              ),

              RoundedField(
                iconPath: 'assets/accounts/address.svg',
                text: ctrl.address.value.isEmpty ? 'Address' : ctrl.address.value,
                onTap: () => _showEditFieldDialog(context, 'Address', ctrl.address,
                    multiline: true),
              ),

              RoundedField(
                iconPath: 'assets/accounts/location.svg',
                text: ctrl.city.value.isEmpty ? 'City' : ctrl.city.value,
                onTap: () => _showEditFieldDialog(context, 'City', ctrl.city),
              ),

              RoundedField(
                iconPath: 'assets/accounts/gst.svg',
                text: ctrl.gst.value.isEmpty ? 'GST No' : ctrl.gst.value,
                onTap: () => _showEditFieldDialog(context, 'GST', ctrl.gst),
              ),

              const SizedBox(height: 12),

              // Signature block
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14,vertical: 14),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.grey.shade200),

                    color: Colors.white
                ),
                  child: _buildSignatureBlock(context)),

              const SizedBox(height: 24),

              // Save changes button

              // SafeArea(
              //   top: false,
              //   child: SizedBox(
              //     width: double.infinity,
              //     child: ElevatedButton(
              //       onPressed: ctrl.isLoading.value ? null : () => ctrl.updateProfile(),
              //       style: ElevatedButton.styleFrom(
              //         backgroundColor: const Color(0xFF3B5AF6),
              //         padding: const EdgeInsets.symmetric(vertical: 18),
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(30),
              //         ),
              //         elevation: 6,
              //       ),
              //       child: ctrl.isLoading.value
              //           ? const SizedBox(
              //         height: 20,
              //         width: 20,
              //         child: CircularProgressIndicator(
              //           valueColor: AlwaysStoppedAnimation(Colors.white),
              //           strokeWidth: 2,
              //         ),
              //       )
              //           : const Text(
              //         'Save Changes',
              //         style: TextStyle(
              //           color: Colors.white,
              //           fontSize: 16,
              //           fontWeight: FontWeight.w600,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),

              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Obx(() {     // ← HERE
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Color(0xFFDFE1E7),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 13),
                child: ElevatedButton(
                  onPressed: ctrl.isLoading.value
                      ? null
                      : () => ctrl.updateProfile(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B5AF6),
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 6,
                  ),
                  child: ctrl.isLoading.value
                      ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                      strokeWidth: 2,
                    ),
                  )
                      : const Text(
                    'Save Changes',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );

  }

  // Widget _buildSignatureBlock(BuildContext context) {
  //   final ctrl = controller;
  //   final height = 150.0;
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Row(
  //         children: [
  //           const Expanded(
  //             child: Text(
  //               'Customer Signature*',
  //               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  //             ),
  //           ),
  //           GestureDetector(
  //             onTap: () => ctrl.resetSignature(),
  //             child: const Text(
  //               'Reset',
  //               style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
  //             ),
  //           ),
  //         ],
  //       ),
  //       const SizedBox(height: 10),
  //       Container(
  //         height: height,
  //         padding: const EdgeInsets.all(12),
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.circular(14),
  //           border: Border.all(color: Colors.grey.shade200),
  //         ),
  //         child: Signature(
  //           controller: ctrl.signatureController,
  //           backgroundColor: Colors.white,
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildSignatureBlock(BuildContext context) {
  //   final ctrl = controller;
  //   final height = 150.0;
  //
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Row(
  //         children: [
  //           const Expanded(
  //             child: Text(
  //               'Customer Signature*',
  //               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  //             ),
  //           ),
  //           GestureDetector(
  //             onTap: () => ctrl.resetSignature(),
  //             child: const Text(
  //               'Reset',
  //               style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
  //             ),
  //           ),
  //         ],
  //       ),
  //       const SizedBox(height: 10),
  //
  //       Container(
  //         height: height,
  //         padding: const EdgeInsets.all(12),
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.circular(14),
  //           border: Border.all(color: Colors.grey.shade200),
  //         ),
  //
  //         /// 🔥 MAIN FIX
  //         child: Obx(() {
  //           final signatureUrl = ctrl.signatureUrl;
  //           /// ✅ अगर user ने नया draw किया
  //           if (ctrl.signatureController.isNotEmpty) {
  //             return Signature(
  //               controller: ctrl.signatureController,
  //               backgroundColor: Colors.white,
  //             );
  //           }
  //
  //           /// ✅ अगर backend से signature आया
  //           if (signatureUrl != null && signatureUrl.isNotEmpty) {
  //             return Image.network(
  //               signatureUrl,
  //               fit: BoxFit.contain,
  //             );
  //           }
  //
  //           /// ❌ fallback (blank pad)
  //           return Signature(
  //             controller: ctrl.signatureController,
  //             backgroundColor: Colors.white,
  //           );
  //         }),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildSignatureBlock(BuildContext context) {
    final ctrl = controller;
    final height = 150.0;

    return Obx(() {
      final signatureUrl = ctrl.signatureUrl;
      final isEditing = ctrl.isEditingSignature.value;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Customer Signature*',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),

              /// ✏️ EDIT BUTTON
              GestureDetector(
                onTap: () {
                  ctrl.startSignatureEdit();
                },
                child: Text(
                  isEditing ? 'Editing...' : 'Edit',
                  style: const TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.w600),
                ),
              ),

              const SizedBox(width: 12),

              /// 🔴 RESET
              GestureDetector(
                onTap: () {
                  ctrl.resetSignature();
                },
                child: const Text(
                  'Reset',
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Container(
            height: height,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.grey.shade200),
            ),

            /// 🔥 MAIN LOGIC (FIXED)
            child: () {

              /// ✅ EDIT MODE → draw
              if (isEditing) {
                return Signature(
                  controller: ctrl.signatureController,
                  backgroundColor: Colors.white,
                );
              }

              /// ✅ VIEW MODE → show image (LOCAL + NETWORK FIX)
              if (signatureUrl.isNotEmpty) {

                /// 🔥 LOCAL FILE (instant update)
                if (signatureUrl.startsWith('/')) {
                  return GestureDetector(
                    onTap: () => ctrl.startSignatureEdit(),
                    child: Image.file(
                      File(signatureUrl),
                      fit: BoxFit.contain,
                    ),
                  );
                }

                /// 🌐 NETWORK IMAGE
                return GestureDetector(
                  onTap: () => ctrl.startSignatureEdit(),
                  child: Image.network(
                    signatureUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) {
                      return const Center(child: Text("Failed to load signature"));
                    },
                  ),
                );
              }

              /// fallback → draw
              return Signature(
                controller: ctrl.signatureController,
                backgroundColor: Colors.white,
              );
            }(),
          ),
        ],
      );
    });
  }
  void _showImagePickOptions(BuildContext context) {
    final ctrl = controller;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape:
      const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  ctrl.pickProfileImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  ctrl.pickProfileImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.close),
                title: const Text('Cancel'),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }

  // Generic edit dialog for text fields
  void _showEditFieldDialog(
      BuildContext context, String label, RxString target,
      {bool multiline = false}) {
    final textController = TextEditingController(text: target.value);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Edit $label'),
        content: TextField(
          controller: textController,
          maxLines: multiline ? 4 : 1,
          keyboardType: multiline ? TextInputType.multiline : TextInputType.text,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              target.value = textController.text.trim();
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
