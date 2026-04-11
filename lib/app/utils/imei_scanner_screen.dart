import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ImeiScannerScreen extends StatelessWidget {
  const ImeiScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        // backgroundColor: Colors.black,
        title: const Text("Scan IMEI"),
      ),
      body: MobileScanner(
        controller: MobileScannerController(
          detectionSpeed: DetectionSpeed.noDuplicates,
          facing: CameraFacing.back,
        ),
        onDetect: (barcode) {
          final String? code = barcode.barcodes.first.rawValue;

          if (code != null && code.length >= 14) {
            Get.back(result: code); // ✅ return scanned IMEI
          }
        },
      ),
    );
  }
}
