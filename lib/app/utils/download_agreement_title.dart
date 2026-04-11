import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zlock_smart_finance/modules/retailer/Add_new_key/download_agreement_controller.dart';
// import 'agreement_download_controller.dart';

class DownloadAgreementTile extends StatelessWidget {
  final String agreementUrl; // ✅ your backend file url

  DownloadAgreementTile({
    super.key,
    required this.agreementUrl,
  });

  final AgreementDownloadController d = Get.put(AgreementDownloadController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final downloading = d.isDownloading.value;
      final p = (d.progress.value * 100).clamp(0, 100).toStringAsFixed(0);

      return InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: downloading
            ? null
            : () => d.downloadAgreement(
          url: agreementUrl,
          fileName: "EMI_Agreement.docx",
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: const LinearGradient(
              colors: [Color(0xff4F6BED), Color(0xff6F7CFF)],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 14,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  downloading ? Icons.downloading_rounded : Icons.description_rounded,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Download Agreement",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      downloading ? "Downloading... $p%" : "DOCX • Tap to download & open",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.85),
                        fontSize: 12.5,
                        height: 1.2,
                      ),
                    ),
                    if (downloading) ...[
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: LinearProgressIndicator(
                          value: d.progress.value,
                          minHeight: 6,
                          backgroundColor: Colors.white.withOpacity(0.25),
                          valueColor: const AlwaysStoppedAnimation(Colors.white),
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  downloading ? "..." : "GET",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
