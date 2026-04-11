import 'package:get/get.dart';
import 'package:zlock_smart_finance/app/services/distributor_key_transfer_service.dart';
import 'package:zlock_smart_finance/app/services/distributor_retailer_details_service.dart';
import 'package:zlock_smart_finance/model/key_transfer_models.dart';
import 'package:zlock_smart_finance/model/retailer_details_response.dart';
import 'package:zlock_smart_finance/modules/distributor/total_retailer/retailer_model.dart';

class RetailerDetailsController extends GetxController {
  final String retailerId;
  final RetailerModel? retailer; // ✅ NEW

  RetailerDetailsController({required this.retailerId,this.retailer});

  final isLoading = true.obs;
  final error = ''.obs;

  final details = Rxn<RetailerDetailsData>();

  final _service = DistributorRetailerDetailsService();

  final isTransferring = false.obs;

  final _transferService = DistributorKeyTransferService();

  @override
  void onInit() {
    super.onInit();
    if (retailer != null) {
      details.value = RetailerDetailsData(
        retailerId: retailer!.retailerId,
        customId: retailer!.customId,
        retailerCode: retailer!.id,
        retailerName: retailer!.name,
        mobile: retailer!.mobile,
        email: retailer!.email,
        state: retailer!.state,
        balance: retailer!.balance,
        status: retailer!.isActive.value,
        ownerName: retailer!.name,
        createdAt: retailer!.createdAt,
        image: retailer!.image, // optional (already in listing if added)
      );
    }
    isLoading.value = false;

    // fetchDetails();
  }

  Future<void> fetchDetails() async {
    isLoading.value = true;
    error.value = '';

    try {
      final resp = await _service.getRetailerDetails(retailerId);

      if (resp == null || resp.status != 200 || resp.data == null) {
        error.value = "Failed to load retailer details";
        return;
      }

      details.value = resp.data!;
    } finally {
      isLoading.value = false;
    }
  }

  // Future<bool> transferKeys({
  //   required bool isCredit,
  //   required int quantity,
  //   String keyType = "ANDROID",
  // }) async {
  //   if (isTransferring.value) return false;
  //
  //   isTransferring.value = true;
  //   try {
  //     final req = KeyTransferRequest(
  //       retailerId: retailerId,
  //       type: isCredit ? "CREDIT" : "DEBIT",
  //       keyType: keyType,
  //       quantity: quantity,
  //     );
  //
  //     final resp = await _transferService.transferKeys(req);
  //
  //     if (resp == null || resp.success != true) {
  //       Get.snackbar("Error", resp?.message ?? "Transfer failed",
  //           snackPosition: SnackPosition.BOTTOM);
  //       return false;
  //     }
  //
  //     Get.snackbar("Success", resp.message,
  //         snackPosition: SnackPosition.BOTTOM);
  //
  //     // ✅ refresh details page
  //     await fetchDetails();
  //     return true;
  //   } finally {
  //     isTransferring.value = false;
  //   }
  // }
}
