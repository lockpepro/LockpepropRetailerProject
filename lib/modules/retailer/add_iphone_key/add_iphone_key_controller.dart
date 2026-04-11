import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'loan_zone_model.dart';

class AddIphoneKeyController extends GetxController {
  final searchCtrl = TextEditingController();

  final customerCtrl = TextEditingController();
  final mobileCtrl = TextEditingController();

  RxList<LoanZoneModel> allList = <LoanZoneModel>[
    LoanZoneModel(keyId: "158567", name: "Faruk K.", mobile: "885192733"),
    LoanZoneModel(keyId: "269411", name: "Pratima", mobile: "9602262233"),
    LoanZoneModel(keyId: "158567", name: "Faruk K.", mobile: "885192733"),
    LoanZoneModel(keyId: "269186", name: "Shivam Kashyap", mobile: "8130047688"),
  ].obs;

  RxList<LoanZoneModel> filteredList = <LoanZoneModel>[].obs;

  @override
  void onInit() {
    filteredList.assignAll(allList);
    super.onInit();
  }

  void onSearch(String value) {
    if (value.isEmpty) {
      filteredList.assignAll(allList);
    } else {
      filteredList.assignAll(
        allList.where(
              (e) =>
          e.name.toLowerCase().contains(value.toLowerCase()) ||
              e.keyId.contains(value) ||
              e.mobile.contains(value),
        ),
      );
    }
  }

  void addLoanZone() {
    if (customerCtrl.text.isEmpty || mobileCtrl.text.isEmpty) return;

    allList.insert(
      0,
      LoanZoneModel(
        keyId: DateTime.now().millisecondsSinceEpoch.toString().substring(7),
        name: customerCtrl.text,
        mobile: mobileCtrl.text,
      ),
    );

    filteredList.assignAll(allList);
    customerCtrl.clear();
    mobileCtrl.clear();
    Get.back();
  }
}
