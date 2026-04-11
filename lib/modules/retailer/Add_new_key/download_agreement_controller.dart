import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

class AgreementDownloadController extends GetxController {
  final RxBool isDownloading = false.obs;
  final RxDouble progress = 0.0.obs; // 0..1
  final RxString savedPath = "".obs;

  final Dio _dio = Dio();

  /// ✅ Call this with your real file url
  Future<void> downloadAgreement({
    required String url,
    String fileName = "EMI_Agreement.docx",
  }) async {
    if (isDownloading.value) return;

    try {
      isDownloading.value = true;
      progress.value = 0;

      final dir = await getApplicationDocumentsDirectory();
      final filePath = "${dir.path}/$fileName";

      await _dio.download(
        url,
        filePath,
        onReceiveProgress: (received, total) {
          if (total > 0) {
            progress.value = received / total;
          }
        },
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: true,
          receiveTimeout: const Duration(minutes: 2),
        ),
      );

      savedPath.value = filePath;

      Get.snackbar(
        "Downloaded",
        "Agreement saved successfully",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );

      // Auto open (optional)
      await OpenFilex.open(filePath);
    } catch (e) {
      Get.snackbar(
        "Download failed",
        "Please try again",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isDownloading.value = false;
    }
  }
}
