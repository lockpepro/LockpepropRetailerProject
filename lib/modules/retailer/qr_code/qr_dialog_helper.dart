import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zlock_smart_finance/modules/retailer/qr_code/qr_code.dart';
import 'package:zlock_smart_finance/modules/retailer/qr_code/qr_controller.dart';

// class QrDialogHelper {
//   static void open({
//     required String deviceMongoId,
//     required String keyId,
//   }) {
//     // old controller cleanup (so always fresh data)
//     if (Get.isRegistered<QrController>()) {
//       Get.delete<QrController>(force: true);
//     }
//
//     // inject with params
//     Get.put(QrController(deviceMongoId: deviceMongoId, keyId: keyId));
//
//     // open dialog
//     Get.dialog(
//       const CustomerQrDialog(),
//       barrierDismissible: false,
//     );
//   }
// }

class QrDialogHelper {
  static void openFromDashboard({
    required String qrImageUrl,
    required String qrLabel,
    required String enrollmentLink,
  }) {
    if (Get.isRegistered<QrController>()) {
      Get.delete<QrController>(force: true);
    }

    Get.put(QrController.fromDashboard(
      qrImageUrl: qrImageUrl,
      qrLabel: qrLabel,
      enrollmentLink: enrollmentLink,
    ));

    // Get.dialog(
    //   const CustomerQrDialog(),
    //   barrierDismissible: false,
    // );
    Get.dialog(
      const CustomerQrDialog(),
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      useSafeArea: true,
    );
  }
}