import 'package:get/get.dart';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:zlock_smart_finance/app/services/qr_service.dart';

// class QrController extends GetxController {
//   final String deviceMongoId; // ✅ _id from add-key response
//   final String keyId;         // ✅ keyId from add-key response (fallback display)
//   final QrService _service = QrService();
//
//   QrController({
//     required this.deviceMongoId,
//     required this.keyId,
//   });
//
//   final isLoading = false.obs;
//   final qrBytes = Rxn<Uint8List>();
//   final deviceIdLabel = ''.obs;
//   final expiresIn = ''.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchQr();
//   }
//
//   Future<void> fetchQr() async {
//     final id = deviceMongoId.trim();
//     if (id.isEmpty) {
//       debugPrint("❌ QR: deviceMongoId empty");
//       return;
//     }
//
//     isLoading.value = true;
//     try {
//       final resp = await _service.getDeviceQr(deviceMongoId: id);
//
//       if (resp == null || resp.status != 200 || resp.data == null) {
//         qrBytes.value = null;
//         return;
//       }
//
//       deviceIdLabel.value =
//       (resp.data!.deviceId?.isNotEmpty == true) ? resp.data!.deviceId! : keyId;
//
//       expiresIn.value = resp.data!.expiresIn ?? "";
//
//       final raw = resp.data!.qrCode ?? "";
//       final base64Part = raw.contains(",") ? raw.split(",").last : raw;
//
//       qrBytes.value = base64Decode(base64Part);
//     } catch (e) {
//       qrBytes.value = null;
//       debugPrint("❌ QR decode error: $e");
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }

class QrController extends GetxController {
  final String? deviceMongoId;
  final String? keyId;

  final String? qrImageUrl;
  final String? qrLabel;
  final String? enrollmentLink;

  QrController({
    required this.deviceMongoId,
    required this.keyId,
  })  : qrImageUrl = null,
        qrLabel = null,
        enrollmentLink = null;

  QrController.fromDashboard({
    required String qrImageUrl,
    required String qrLabel,
    required String enrollmentLink,
  })  : deviceMongoId = null,
        keyId = null,
        qrImageUrl = qrImageUrl,
        qrLabel = qrLabel,
        enrollmentLink = enrollmentLink;

  final isLoading = false.obs;

  final qrBytes = Rxn<Uint8List>();

  // ✅ for dashboard URL show
  final qrUrl = ''.obs;
  final deviceIdLabel = ''.obs;   // ✅ add
  final expiresIn = ''.obs;       // ✅ add (dashboard me nahi hai, so blank ok)
  final link = ''.obs;

  @override
  void onInit() {
    super.onInit();

    // ✅ dashboard mode
    if ((qrImageUrl ?? '').isNotEmpty) {
      qrUrl.value = qrImageUrl!;
      deviceIdLabel.value = (qrLabel ?? '').isNotEmpty ? qrLabel! : (keyId ?? "-");
      link.value = enrollmentLink ?? "";
      expiresIn.value = ""; // dashboard me expiresIn nahi aa raha
      return;
    }

    // old api mode
    // fetchQr();
  }

  // ✅ keep retry safe: if url exists, just re-assign (no crash)
  Future<void> fetchQr() async {
    if (qrUrl.value.isNotEmpty) return; // dashboard mode -> nothing to fetch
    // old flow code here if needed
  }
}