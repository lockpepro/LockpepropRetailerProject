import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';
import 'package:zlock_smart_finance/app/routes/app_routes.dart';
import 'package:zlock_smart_finance/app/services/add_key_api_service.dart';
import 'package:zlock_smart_finance/app/services/key_details_service.dart';
import 'package:zlock_smart_finance/app/services/update_key_api_service.dart';
import 'package:zlock_smart_finance/modules/retailer/Add_new_key/new_key_controller.dart';
import 'package:zlock_smart_finance/modules/retailer/dashboard/dashboard_retailer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EditKeyController extends GetxController {
  final NewKeyEntry entry;
  final String keyId;
  final String deviceId;

  EditKeyController({
    required this.entry,
    required this.keyId,
    required this.deviceId,
  });

  /// BASIC
  final customerName = TextEditingController();
  final mobile = TextEditingController();
  final imei = TextEditingController();
  final imei2 = TextEditingController(); // ✅ NEW
  final isSignatureEditing = false.obs; // ✅ NEW

  // final brandModel = TextEditingController();

  /// COLLAPSE
  final showMore = false.obs;

  /// PAYMENT
  final paymentType = PaymentType.emi.obs;
  final emiCycle = EmiCycle.monthly.obs;
  final deviceType = DeviceType.android.obs;

  /// FINANCE
  final productPrice = TextEditingController();
  final downPayment = TextEditingController();
  final balancePayment = TextEditingController();
  final months = TextEditingController();
  final interest = TextEditingController();
  final monthlyEmi = TextEditingController();

  /// DATE
  final loanStartDate = ''.obs; // display dd/MM/yyyy
  DateTime? loanStartDateRaw;   // keep original

  // void startEditingSignature() {
  //   isSignatureEditing.value = true;
  //   signatureController.clear(); // start fresh
  // }
  /// Dropdown
  final loanProviders = <String>[
    "ICICI BANK",
    "HDFC",
    "PANJAB NATIONAL BANK",
    "STATE BANK OF INDIA",
    "HDFC BANK",
    "BANK OF INDIA",
    "YES BANK",
    "INDUSLND BANK",
    "AXIS BANK",
    "BANK OF BARODA",
    "CANARA BANK",
    "UNION BANK",
    "KOTAK MAHINDRA",
    "RBL BANK",
    "BANDHAN BANK",
    "IDFC FIRST BANK",
    "HOME CREDIT",
    "BAJAJ FINANCE",
    "PRIVATE FINANCE",
    "HDB FINANCE",
    "TVS CREDIT",
    "INDIAN BANK",
    "POONAWALA FINCORP",
  ].obs;

  final selectedLoanProvider = RxnString();

  /// IMAGE
  final ImagePicker _picker = ImagePicker();
  final existingProductImageUrl = ''.obs;
  final existingSignatureUrl = ''.obs;
  final customerProductImagePath = ''.obs;

  File? get customerProductImageFile =>
      customerProductImagePath.value.isEmpty ? null : File(customerProductImagePath.value);

  /// SIGNATURE
  final signatureController = SignatureController(
    penStrokeWidth: 3,
    penColor: const Color(0xFF000000),
    exportBackgroundColor: const Color(0xFFFFFFFF),
  );

  /// LOADING
  final isLoading = true.obs;
  final isUpdating = false.obs;

  final keyDocId = "".obs; // ✅ will store _id from key details response
  final _updateService = UpdateKeyApiService();

  // @override
  // void onInit() {
  //   super.onInit();
  //
  //
  //   final args = Get.arguments;
  //
  //   if (args != null && args["user"] != null) {
  //     final u = args["user"];
  //
  //     customerName.text = u.name ?? "";
  //     mobile.text = u.mobile ?? "";
  //     imei.text = u.imei ?? "";
  //     imei2.text = ""; // listing me nahi hai to blank
  //
  //     selectedLoanProvider.value = u.loanBy;
  //
  //     print("✅ PREFILL FROM LISTING DONE");
  //   }
  //
  //   // auto-calc (only when NOT withoutEmi)
  //   productPrice.addListener(_computeBalance);
  //   downPayment.addListener(_computeBalance);
  //
  //   months.addListener(_computeEmi);
  //   interest.addListener(_computeEmi);
  //   balancePayment.addListener(_computeEmi);
  //
  //   ever<PaymentType>(paymentType, (t) {
  //     // Without EMI => only hide UI (screen handles)
  //     if (t != PaymentType.withoutEmi) {
  //       _computeBalance();
  //       _computeEmi();
  //     }
  //   });
  //
  //   fetchAndPrefill();
  // }

  // ================= FETCH =================
  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;

    if (args != null && args["user"] != null) {
      final u = args["user"];

      /// ✅ BASIC
      customerName.text = u.name ?? "";
      mobile.text = u.mobile ?? "";
      imei.text = u.imei ?? "";
      imei2.text = u.imei2 ?? ""; // FIX

      selectedLoanProvider.value = u.loanBy;

      /// ✅ IMAGE
      if (u.productImage != null && u.productImage.isNotEmpty) {
        existingProductImageUrl.value = u.productImage.first;
      }

      /// ✅ SIGNATURE (IMPORTANT FIX)
      existingSignatureUrl.value = u.signatureImage ?? "";

      /// ✅ PAYMENT TYPE
      paymentType.value = _mapPaymentType(u.emi ?? "EMI");

      /// ✅ OPTIONAL FINANCE
      productPrice.text = u.productPrice ?? "";
      downPayment.text = u.downPayment ?? "";
      balancePayment.text = u.balancePayment ?? "";
      months.text = u.tenure ?? "";
      interest.text = u.interest ?? "";
      monthlyEmi.text = u.emiAmount ?? "";

      /// ✅ DEFAULT EXPANDED
      showMore.value = paymentType.value != PaymentType.withoutEmi;

      debugPrint("🔥 FULL PREFILL FROM LISTING DONE");
      fetchAndPrefill();

    }

    /// CALCULATIONS
    productPrice.addListener(_computeBalance);
    downPayment.addListener(_computeBalance);
    months.addListener(_computeEmi);
    interest.addListener(_computeEmi);
    balancePayment.addListener(_computeEmi);
  }

  Future<void> fetchAndPrefill() async {
    isLoading.value = true;
    try {
      final resp = await KeyDetailsService().getKeyDetails(keyId);
      if (resp == null || resp.data == null) {
        // Get.snackbar("Error", "Failed to load details",
        //     snackPosition: SnackPosition.BOTTOM);
        return;
      }
      prefillFromJson(resp.data);
    } catch (e) {
      debugPrint("❌ fetchAndPrefill error: $e");
      // Get.snackbar("Error", "Failed to load details",
      //     snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  // ================= PREFILL (your JSON structure) =================
  void prefillFromJson(dynamic data) {
    try {
      // keyInfo
      final keyInfo = data.keyInfo;
      final loan = data.loan;
      final device = data.device;
      final customer = data.customer;

      // ✅ store mongo _id for update API
      // keyDocId.value = (keyInfo?._id ?? keyInfo?.id ?? "").toString();

      keyDocId.value = data.keyInfo?.id ?? "";
      debugPrint("✅ keyDocId(_id) => ${keyDocId.value}");

      // basic
      customerName.text = (customer?.fullName ?? "").toString();
      mobile.text = (customer?.phone ?? "").toString();
      imei.text = (device?.imei1 ?? "").toString();
      imei2.text = (device?.imei2 ?? "").toString(); // ✅ NEW

      // brandModel.text = (device?.brandModel ?? "").toString();

      // loan provider + payment type (from keyInfo)
      final lp = (keyInfo?.loanProvider ?? "").toString().trim();
      selectedLoanProvider.value = lp.isEmpty ? null : lp;

      final p = (keyInfo?.paymentType ?? "").toString().trim().toUpperCase();
      paymentType.value = _mapPaymentType(p);

      // images
      final imgs = device?.productImage;
      if (imgs is List && imgs.isNotEmpty) {
        existingProductImageUrl.value = imgs.first.toString();
      } else {
        existingProductImageUrl.value = (imgs ?? "").toString();
      }
      existingSignatureUrl.value = (device?.signatureImage ?? "").toString();

      // finance fields (loan)
      productPrice.text = _numToText(loan?.productPrice);
      downPayment.text = _numToText(loan?.downPayment);
      balancePayment.text = _numToText(loan?.balancePayment);

      months.text = _numToText(loan?.tenureMonths);
      interest.text = _numToText(loan?.interestRate);
      monthlyEmi.text = _numToText(loan?.emiAmount);

      // emiType -> tabs
      final et = (loan?.emiType ?? "").toString().toUpperCase();
      emiCycle.value = _mapEmiType(et);

      // loanStartDate ISO -> dd/MM/yyyy
      final iso = (loan?.loanStartDate ?? "").toString();
      final dt = _parseIso(iso);
      loanStartDateRaw = dt;
      loanStartDate.value = dt == null ? "" : DateFormat("dd/MM/yyyy").format(dt);

      // collapse default:
      // - if WITHOUT EMI => keep collapsed (false)
      // - else showMore true so details visible
      showMore.value = paymentType.value != PaymentType.withoutEmi;

      // recalc (safe)
      _computeBalance();
      _computeEmi();
    } catch (e) {
      debugPrint("❌ prefillFromJson error: $e");
    }
  }

  PaymentType _mapPaymentType(String v) {
    final s = v.trim().toUpperCase();
    if (s == "WITHOUT EMI" || s == "WITHOUT_EMI" || s.contains("WITHOUT")) {
      return PaymentType.withoutEmi;
    }
    if (s == "ECS") return PaymentType.ecs;
    if (s == "E-MANDATE" || s == "E_MANDATE" || s == "EMANDATE" || s.contains("MANDATE")) {
      return PaymentType.eMandate;
    }
    return PaymentType.emi; // EMI
  }

  EmiCycle _mapEmiType(String v) {
    final s = v.trim().toUpperCase();
    if (s == "DAILY") return EmiCycle.daily;
    if (s == "WEEKLY") return EmiCycle.weekly;
    return EmiCycle.monthly; // MONTHLY
  }

  DateTime? _parseIso(String iso) {
    if (iso.trim().isEmpty) return null;
    try {
      return DateTime.parse(iso).toLocal();
    } catch (_) {
      return null;
    }
  }

  String _numToText(dynamic v) {
    if (v == null) return "";
    if (v is num) return v % 1 == 0 ? v.toStringAsFixed(0) : v.toString();
    return v.toString();
  }

  // ================= IMAGE PICK =================
  void showImagePickOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Camera"),
              onTap: () async {
                Navigator.pop(context);
                await pickCustomerProductImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("Gallery"),
              onTap: () async {
                Navigator.pop(context);
                await pickCustomerProductImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickCustomerProductImage(ImageSource source) async {
    try {
      final XFile? picked = await _picker.pickImage(source: source, imageQuality: 85);
      if (picked == null) return;
      customerProductImagePath.value = picked.path;
    } catch (e) {
      Get.snackbar("Error", "Image pick failed", snackPosition: SnackPosition.BOTTOM);
    }
  }

  void setLoanProvider(String? v) => selectedLoanProvider.value = v;

  void resetSignature() => signatureController.clear();

  Future<void> pickDate(BuildContext context) async {
    final initial = loanStartDateRaw ?? DateTime.now();
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
      initialDate: initial,
    );
    if (date != null) {
      loanStartDateRaw = date;
      loanStartDate.value = DateFormat("dd/MM/yyyy").format(date);
    }
  }

  // ================= CALC =================
  double _parseNum(String v) => double.tryParse(v.trim()) ?? 0.0;

  void _setText(TextEditingController c, String text) {
    if (c.text == text) return;
    c.value = TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }

  void _computeBalance() {
    if (paymentType.value == PaymentType.withoutEmi) return;

    final price = _parseNum(productPrice.text);
    final down = _parseNum(downPayment.text);
    if (price <= 0) return;

    double bal = price - down;
    if (bal < 0) bal = 0;

    final display = bal % 1 == 0 ? bal.toStringAsFixed(0) : bal.toStringAsFixed(2);
    _setText(balancePayment, display);
  }

  // void _computeEmi() {
  //   if (paymentType.value == PaymentType.withoutEmi) return;
  //
  //   final principal = _parseNum(balancePayment.text);
  //   final tenure = (_parseNum(months.text)).round();
  //   final annualRate = _parseNum(interest.text);
  //
  //   // ✅ interestRate=0 ho sakta hai, to emiAmount API se already hai.
  //   // Auto-calc only when annualRate > 0
  //   if (principal <= 0 || tenure <= 0 || annualRate <= 0) return;
  //
  //   int periods;
  //   double ratePerPeriod;
  //
  //   switch (emiCycle.value) {
  //     case EmiCycle.monthly:
  //       periods = tenure;
  //       ratePerPeriod = (annualRate / 100) / 12;
  //       break;
  //     case EmiCycle.weekly:
  //       periods = tenure * 4;
  //       ratePerPeriod = (annualRate / 100) / 52;
  //       break;
  //     case EmiCycle.daily:
  //       periods = tenure * 30;
  //       ratePerPeriod = (annualRate / 100) / 365;
  //       break;
  //   }
  //
  //   double emi;
  //   if (ratePerPeriod == 0) {
  //     emi = principal / periods;
  //   } else {
  //     final a = (1 + ratePerPeriod);
  //     final numerator = principal * ratePerPeriod * pow(a, periods).toDouble();
  //     final denominator = pow(a, periods).toDouble() - 1;
  //     emi = denominator == 0 ? 0 : (numerator / denominator);
  //   }
  //
  //   if (!emi.isFinite || emi < 0) emi = 0;
  //   _setText(monthlyEmi, emi.toStringAsFixed(2));
  // }

  // void _computeEmi() {
  //   if (paymentType.value == PaymentType.withoutEmi) return;
  //
  //   final principal = _parseNum(balancePayment.text);
  //   final tenure = (_parseNum(months.text)).round();
  //   final annualRate = _parseNum(interest.text);
  //
  //   if (principal <= 0 || tenure <= 0) {
  //     if (monthlyEmi.text.isNotEmpty) _setText(monthlyEmi, "");
  //     return;
  //   }
  //
  //   int periods;
  //   double ratePerPeriod;
  //
  //   switch (emiCycle.value) {
  //     case EmiCycle.monthly:
  //       periods = tenure;
  //       ratePerPeriod = (annualRate / 100) / 12;
  //       break;
  //     case EmiCycle.weekly:
  //       periods = tenure * 4;
  //       ratePerPeriod = (annualRate / 100) / 52;
  //       break;
  //     case EmiCycle.daily:
  //       periods = tenure * 30;
  //       ratePerPeriod = (annualRate / 100) / 365;
  //       break;
  //   }
  //
  //   double emi;
  //
  //   /// ✅ 0% INTEREST SUPPORT
  //   if (annualRate == 0) {
  //     emi = principal / periods;
  //   } else {
  //     final a = (1 + ratePerPeriod);
  //     final numerator = principal * ratePerPeriod * pow(a, periods).toDouble();
  //     final denominator = pow(a, periods).toDouble() - 1;
  //     emi = denominator == 0 ? 0 : (numerator / denominator);
  //   }
  //
  //   if (!emi.isFinite || emi < 0) emi = 0;
  //
  //   debugPrint("🔥 EMI CALCULATED => $emi");
  //
  //   _setText(monthlyEmi, emi.toStringAsFixed(2));
  // }
  void _computeEmi() {
    if (paymentType.value == PaymentType.withoutEmi) return;

    final principal = _parseNum(balancePayment.text);
    final tenure = (_parseNum(months.text)).round();
    final rateInput = _parseNum(interest.text);

    int periods;
    double ratePerPeriod;

    switch (emiCycle.value) {
      case EmiCycle.monthly:
        periods = tenure;

        // ✅ FIX: monthly interest direct use
        ratePerPeriod = rateInput / 100;
        break;

      case EmiCycle.weekly:
        periods = tenure * 4;

        // approx weekly
        ratePerPeriod = (rateInput / 100) / 4;
        break;

      case EmiCycle.daily:
        periods = tenure * 30;

        // approx daily
        ratePerPeriod = (rateInput / 100) / 30;
        break;
    }

    // ✅ auto fill 0 instead of blank
    if (principal <= 0 || periods <= 0) {
      _setText(monthlyEmi, "0");
      return;
    }

    double emi = 0;

    /// ✅ 0% interest support
    if (rateInput == 0) {
      emi = principal / periods;
    } else {
      final r = ratePerPeriod;
      final powVal = pow(1 + r, periods).toDouble();
      emi = (principal * r * powVal) / (powVal - 1);
    }

    if (!emi.isFinite || emi < 0) emi = 0;

    final display = emi % 1 == 0
        ? emi.toStringAsFixed(0)
        : emi.toStringAsFixed(2);

    debugPrint("🔥 EMI CALCULATED => $display");

    _setText(monthlyEmi, display);
  }
  // ================= BACK CONFIRM =================
  Future<bool> confirmExitAndClear() async {
    if (isUpdating.value) return false;

    final ok = await Get.dialog<bool>(
      AlertDialog(
        title: const Text("Exit?"),
        content: const Text("Do you want to exit this page?"),
        actions: [
          TextButton(onPressed: () => Get.back(result: false), child: const Text("Cancel")),
          TextButton(onPressed: () => Get.back(result: true), child: const Text("Exit")),
        ],
      ),
      barrierDismissible: false,
    );
    return ok == true;
  }

  // Future<void> updateKeyPrintAll() async {
  //   if (isUpdating.value) return;
  //   isUpdating.value = true;
  //
  //   try {
  //     final id = keyDocId.value.trim();
  //     if (id.isEmpty) {
  //       Get.snackbar("Error", "Key _id missing (update not possible)",
  //           snackPosition: SnackPosition.BOTTOM);
  //       return;
  //     }
  //
  //     // optional signature
  //     final sigBytes = signatureController.isEmpty
  //         ? null
  //         : await signatureController.toPngBytes();
  //
  //     final req = UpdateKeyRequest(
  //       imeiNumber: imei.text.trim(),
  //       loanProvider: (selectedLoanProvider.value ?? "").trim(),
  //       brandModel: brandModel.text.trim(),
  //       paymentType: paymentType.value,
  //       emiType: emiCycle.value,
  //       productPrice: productPrice.text.trim(),
  //       downPayment: downPayment.text.trim(),
  //       balancePayment: balancePayment.text.trim(),
  //       tenureMonths: months.text.trim(),
  //       interestRate: interest.text.trim(),
  //       emiAmount: monthlyEmi.text.trim(),
  //       loanStartDate: loanStartDate.value, // same as your postman
  //     );
  //
  //     debugPrint("✅ UPDATE KEY _id: $id");
  //     debugPrint("✅ UPDATE PAYLOAD: ${req.toJson()}");
  //     debugPrint("✅ newImagePath: ${customerProductImagePath.value}");
  //     debugPrint("✅ signatureBytes: ${sigBytes?.length}");
  //
  //     final res = await _updateService.updateKey(
  //       keyDocId: id,
  //       request: req,
  //       productImageFile: customerProductImageFile, // null ok
  //       signaturePngBytes: sigBytes, // null ok
  //     );
  //
  //     if (res.status == 200) {
  //       Get.snackbar("Success", res.message ?? "Key updated",
  //           snackPosition: SnackPosition.BOTTOM);
  //       Get.offAllNamed(AppRoutes.DASH_RETAILER);
  //
  //       // // ✅ refresh same screen data (no impact)
  //       // await fetchAndPrefill();
  //     } else {
  //       Get.snackbar("Error", res.message ?? "Update failed",
  //           snackPosition: SnackPosition.BOTTOM);
  //     }
  //   } catch (e) {
  //     debugPrint("❌ update error: $e");
  //     Get.snackbar("Error", "Update failed",
  //         snackPosition: SnackPosition.BOTTOM);
  //   } finally {
  //     isUpdating.value = false;
  //   }
  // }

  // Future<void> updateCustomer() async {
  //   if (isUpdating.value) return;
  //
  //   try {
  //     isUpdating.value = true;
  //
  //     print("========== CUSTOMER UPDATE START ==========");
  //
  //     /// ✅ SIGNATURE
  //     final sigBytes = signatureController.isEmpty
  //         ? null
  //         : await signatureController.toPngBytes();
  //
  //     /// ✅ EMI
  //     Map<String, dynamic>? emiFlat;
  //     final hideAll = paymentType.value == PaymentType.withoutEmi;
  //
  //     if (!hideAll) {
  //       emiFlat = {
  //         "totalAmount": productPrice.text.trim(),
  //         "downPayment": downPayment.text.trim(),
  //         "loanAmount": balancePayment.text.trim(),
  //         "interestRate": interest.text.trim(),
  //         "emiAmount": monthlyEmi.text.trim(),
  //         "tenureMonths": months.text.trim(),
  //         "loanProvider": (selectedLoanProvider.value ?? "").trim(),
  //         "emiStatus": "active",
  //       };
  //
  //       emiFlat.removeWhere((k, v) => v == null || v.toString().isEmpty);
  //     }
  //
  //     /// ✅ CALL SAME ADD API (BUT WITHOUT IMEI UPDATE)
  //     final res = await NewKeyApiService().customerAddMultipart(
  //       entry: entry,
  //       name: customerName.text.trim(),
  //       phone: mobile.text.trim(),
  //       email: "",
  //
  //       // ❌ DO NOT SEND IMEI (important)
  //       imei1: "",
  //       imei2: null,
  //
  //       loanBy: selectedLoanProvider.value,
  //
  //       profileImage: customerProductImageFile,
  //       aadhaarFront: null,
  //       aadhaarBack: null,
  //       signaturePngBytes: sigBytes ?? [],
  //
  //       emiFlat: emiFlat,
  //     );
  //
  //     if (!res.success) {
  //       Get.snackbar("Error", res.message,
  //           snackPosition: SnackPosition.BOTTOM);
  //       return;
  //     }
  //
  //     Get.snackbar("Success", res.message,
  //         snackPosition: SnackPosition.BOTTOM);
  //
  //     Get.offAllNamed(AppRoutes.DASH_RETAILER);
  //
  //     print("========== CUSTOMER UPDATE END ==========");
  //   } catch (e) {
  //     print("❌ UPDATE ERROR: $e");
  //     Get.snackbar("Error", "Update failed",
  //         snackPosition: SnackPosition.BOTTOM);
  //   } finally {
  //     isUpdating.value = false;
  //   }
  // }
  Uint8List? signatureBytes;

  void startEditingSignature() {
    isSignatureEditing.value = true;
    signatureController.clear();
    signatureBytes = null; // reset
  }

  Future<Uint8List?> getFinalSignatureBytes() async {
    try {
      /// ✅ CASE 1: user edited
      if (isSignatureEditing.value) {
        final bytes = await signatureController.toPngBytes();

        print("🖊 NEW SIGNATURE BYTES => ${bytes?.length}");

        if (bytes == null || bytes.isEmpty) {
          Get.snackbar("Error", "Signature empty");
          return null;
        }

        return bytes;
      }

      /// ✅ CASE 2: NOT edited → DOWNLOAD EXISTING
      if (existingSignatureUrl.value.isNotEmpty) {
        print("♻️ DOWNLOADING EXISTING SIGNATURE...");

        final response = await Dio().get(
          existingSignatureUrl.value,
          options: Options(responseType: ResponseType.bytes),
        );

        final bytes = Uint8List.fromList(response.data);

        print("♻️ EXISTING SIGNATURE BYTES => ${bytes.length}");

        return bytes;
      }

      return null;
    } catch (e) {
      print("❌ SIGNATURE ERROR: $e");
      return null;
    }
  }

  Future<void> updateCustomer() async {
    if (isUpdating.value) return;

    try {
      isUpdating.value = true;

      print("========== CUSTOMER UPDATE START ==========");

      /// ✅ DEBUG
      print("NAME => ${customerName.text}");
      print("PHONE => ${mobile.text}");
      print("IMEI1 => ${imei.text}");
      print("IMEI2 => ${imei2.text}");

      /// 🔥 FINAL SIGNATURE
      final sigBytes = await getFinalSignatureBytes();

      print("FINAL SIGNATURE BYTES => ${sigBytes?.length}");

      if (sigBytes == null || sigBytes.isEmpty) {
        Get.snackbar("Error", "Signature missing");
        return;
      }

      /// ✅ EMI
      Map<String, dynamic>? emiFlat;
      final hideAll = paymentType.value == PaymentType.withoutEmi;

      if (!hideAll) {
        emiFlat = {
          "totalAmount": productPrice.text.trim(),
          "downPayment": downPayment.text.trim(),
          "loanAmount": balancePayment.text.trim(),
          "interestRate": interest.text.trim(),
          "emiAmount": monthlyEmi.text.trim(),
          "tenureMonths": months.text.trim(),
          "loanProvider": (selectedLoanProvider.value ?? "").trim(),
          "emiStatus": "active",
        };

        emiFlat.removeWhere((k, v) => v == null || v.toString().isEmpty);
      }

      print("🔥 EMI DATA => $emiFlat");

      /// 🚀 API CALL
      final res = await NewKeyApiService().customerAddMultipart(
        entry: entry,
        name: customerName.text.trim(),
        phone: mobile.text.trim(),
        email: "",

        imei1: imei.text.trim(),
        imei2: imei2.text.trim().isEmpty ? null : imei2.text.trim(),

        loanBy: selectedLoanProvider.value,

        profileImage: customerProductImageFile,

        /// 🔥 FIXED (ALWAYS VALID)
        signaturePngBytes: sigBytes,

        emiFlat: emiFlat,
      );

      print("========== API RESPONSE ==========");
      print("SUCCESS => ${res.success}");
      print("MESSAGE => ${res.message}");

      if (!res.success) {
        Get.snackbar("Error", res.message);
        return;
      }

      Get.snackbar("Success", res.message);

      print("========== CUSTOMER UPDATE SUCCESS ==========");

      Get.offAllNamed(AppRoutes.DASH_RETAILER);

    } catch (e) {
      print("❌ UPDATE ERROR: $e");
      Get.snackbar("Error", "Update failed");
    } finally {
      isUpdating.value = false;
    }
  }

  @override
  void onClose() {
    customerName.dispose();
    mobile.dispose();
    imei.dispose();
    // brandModel.dispose();

    productPrice.dispose();
    downPayment.dispose();
    balancePayment.dispose();
    months.dispose();
    interest.dispose();
    monthlyEmi.dispose();

    signatureController.dispose();
    super.onClose();
  }
}
