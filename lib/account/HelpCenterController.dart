import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zlock_smart_finance/account/faq_page.dart';

class HelpCenterController extends GetxController {
  // API / constants
  final supportEmail  = "Ceo@lockontechventure.com";
  final supportPhone  = "+918810422690";
  final supportPhone2 = "+918810422689";

  // Navigation actions
  void onFAQs() {
    Get.to(FAQPage());
  }

  void onAccountSupport() {
    // Get.snackbar("Account Support", "Navigate to account support",
    //     snackPosition: SnackPosition.BOTTOM);
  }

  // void onContactSupport() {
  //   // Get.snackbar("Contact Support", "Navigate to contact support",
  //   //     snackPosition: SnackPosition.BOTTOM);
  // }

  // Email click
  // void onEmailTap() {
  //   Get.snackbar("Email", supportEmail,
  //       snackPosition: SnackPosition.BOTTOM);
  // }


  // void onEmailTap() async {
  //   final String email = supportEmail;
  //
  //   final Uri emailUri = Uri(
  //     scheme: 'mailto',
  //     path: email,
  //     query: Uri.encodeFull('subject=Support Request&body=Hello Team,'),
  //   );
  //
  //   if (await canLaunchUrl(emailUri)) {
  //     await launchUrl(emailUri);
  //   } else {
  //     Get.snackbar("Error", "Could not open email app");
  //   }
  // }
  // void onEmailTap() async {
  //   final Uri emailUri = Uri(
  //     scheme: 'mailto',
  //     path: supportEmail,
  //     query: Uri.encodeFull(
  //       'subject=Support Request&body=Hello Team,',
  //     ),
  //   );
  //
  //   try {
  //     if (await canLaunchUrl(emailUri)) {
  //       await launchUrl(emailUri);
  //     } else {
  //       // Fallback
  //       Get.snackbar(
  //         "No Email App",
  //         "Please install Gmail or any email app",
  //       );
  //     }
  //   } catch (e) {
  //     Get.snackbar("Error", "Something went wrong");
  //   }
  // }
  void onEmailTap() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: supportEmail,
      query: Uri.encodeFull(
        'subject=Support Request&body=Hello Team,',
      ),
    );

    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(
          emailUri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        // 👉 Fallback: Open Gmail Web
        final Uri gmailWeb = Uri.parse(
          "https://mail.google.com/mail/?view=cm&to=$supportEmail&su=Support%20Request&body=Hello%20Team",
        );

        await launchUrl(
          gmailWeb,
          mode: LaunchMode.externalApplication,
        );
      }
    } catch (e) {
      Get.snackbar("Error", "Unable to open email");
    }
  }
  // Phone click
  // void onPhoneTap() {
  //   Get.snackbar("Phone", supportPhone,
  //       snackPosition: SnackPosition.BOTTOM);
  // }
  // void onPhoneTap() async {
  //   final phoneNumber = supportPhone; // yaha tumhara number hoga
  //
  //   final Uri url = Uri.parse("tel:+91$phoneNumber");
  //
  //   if (await canLaunchUrl(url)) {
  //     await launchUrl(url);
  //   } else {
  //     Get.snackbar("Error", "Could not open dialer");
  //   }
  // }
  void onPhoneTap(String phoneNumber) async {
    String formattedNumber = phoneNumber.startsWith("+91")
        ? phoneNumber
        : "+91$phoneNumber";

    final Uri url = Uri.parse("tel:$formattedNumber");

    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        Get.snackbar("Error", "Could not open dialer");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    }
  }
  // void onContactSupport(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  //     ),
  //     builder: (_) {
  //       return SafeArea(
  //         child: Padding(
  //           padding: const EdgeInsets.all(16),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //
  //               // CALL
  //               ListTile(
  //                 leading: const Icon(Icons.call),
  //                 title: const Text("Call"),
  //                 onTap: () async {
  //                   Get.back();
  //
  //                   String formattedNumber = supportPhone.startsWith("+91")
  //                       ? supportPhone
  //                       : "+91$supportPhone";
  //
  //                   final Uri url = Uri.parse("tel:$formattedNumber");
  //
  //                   if (await canLaunchUrl(url)) {
  //                     await launchUrl(url);
  //                   }
  //                 },
  //               ),
  //
  //               // MESSAGE (SMS)
  //               ListTile(
  //                 leading: const Icon(Icons.message),
  //                 title: const Text("Message"),
  //                 onTap: () async {
  //                   Get.back();
  //
  //                   String formattedNumber = supportPhone.startsWith("+91")
  //                       ? supportPhone
  //                       : "+91$supportPhone";
  //
  //                   final Uri smsUri = Uri.parse(
  //                       "sms:$formattedNumber?body=Hello Support Team");
  //
  //                   if (await canLaunchUrl(smsUri)) {
  //                     await launchUrl(smsUri);
  //                   }
  //                 },
  //               ),
  //
  //               // EMAIL
  //               // ListTile(
  //               //   leading: const Icon(Icons.email),
  //               //   title: const Text("Email"),
  //               //   onTap: () async {
  //               //     Get.back();
  //               //
  //               //     final Uri emailUri = Uri(
  //               //       scheme: 'mailto',
  //               //       path: supportEmail,
  //               //       query: Uri.encodeFull(
  //               //           'subject=Support Request&body=Hello Team,'),
  //               //     );
  //               //
  //               //     if (await canLaunchUrl(emailUri)) {
  //               //       await launchUrl(emailUri);
  //               //     }
  //               //   },
  //               // ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  void onContactSupport(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                /// -------- CALL NUMBER 1 --------
                ListTile(
                  leading: const Icon(Icons.call),
                  title: Text("Call ${supportPhone}"),
                  onTap: () async {
                    Get.back();
                    onPhoneTap(supportPhone);
                  },
                ),

                /// -------- CALL NUMBER 2 --------
                ListTile(
                  leading: const Icon(Icons.call),
                  title: Text("Call ${supportPhone2}"),
                  onTap: () async {
                    Get.back();
                    onPhoneTap(supportPhone2);
                  },
                ),

                const Divider(),

                /// -------- MESSAGE NUMBER 1 --------
                ListTile(
                  leading: const Icon(Icons.message),
                  title: Text("Message ${supportPhone}"),
                  onTap: () async {
                    Get.back();

                    final Uri smsUri = Uri.parse(
                      "sms:$supportPhone?body=Hello Support Team",
                    );

                    if (await canLaunchUrl(smsUri)) {
                      await launchUrl(smsUri);
                    }
                  },
                ),

                /// -------- MESSAGE NUMBER 2 --------
                ListTile(
                  leading: const Icon(Icons.message),
                  title: Text("Message ${supportPhone2}"),
                  onTap: () async {
                    Get.back();

                    final Uri smsUri = Uri.parse(
                      "sms:$supportPhone2?body=Hello Support Team",
                    );

                    if (await canLaunchUrl(smsUri)) {
                      await launchUrl(smsUri);
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}
