import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:image_picker/image_picker.dart';
import 'package:signature/signature.dart';
import 'package:zlock_smart_finance/app/request/add_key_request.dart';
import 'package:zlock_smart_finance/app/services/add_key_api_service.dart';

import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:zlock_smart_finance/app/services/upload_doc_service.dart';
import 'package:zlock_smart_finance/app/utils/imei_scanner_screen.dart';
import 'package:zlock_smart_finance/modules/retailer/dashboard/dashboard_retailer.dart';
import '../../../app/routes/app_routes.dart';
import 'show_custom_qr.dart';

enum EmiCycle { daily, weekly, monthly }

extension EmiCycleX on EmiCycle {
  String get apiValue => name.toUpperCase(); // DAILY/WEEKLY/MONTHLY
}

enum KeyType { running, android, iphone }

extension KeyTypeX on KeyType {
  String get apiValue {
    switch (this) {
      case KeyType.running:
        return "RUNNING";
      case KeyType.android:
        return "ANDROID";
      case KeyType.iphone:
        return "IPHONE";
    }
  }
}


enum PaymentType { emi, withoutEmi, ecs, eMandate }
extension PaymentTypeX on PaymentType {
  String get apiValue {
    switch (this) {
      case PaymentType.emi:
        return "EMI";
      case PaymentType.withoutEmi:
        return "WITHOUT_EMI";
      case PaymentType.ecs:
        return "ECS";
      case PaymentType.eMandate:
        return "E_MANDATE";
    }
  }
}

enum DeviceType { android, iphone }
extension DeviceTypeX on DeviceType {
  String get apiValue {
    switch (this) {
      case DeviceType.android:
        return "ANDROID";
      case DeviceType.iphone:
        return "IPHONE";
    }
  }
}

enum AadharSide { front, back }

class NewKeyController extends GetxController {
  final NewKeyEntry entry;
  NewKeyController({required this.entry});

  /// BASIC DETAILS
  final customerName = TextEditingController();
  final scheme = TextEditingController();
  final mobile = TextEditingController();
  final imei = TextEditingController();
  final imei2 = TextEditingController();
  final brandModel = TextEditingController();

  /// AADHAAR IMAGES (Front/Back)
  final RxString aadharFrontPath = ''.obs;
  final RxString aadharBackPath = ''.obs;

  File? get aadharFrontFile =>
      aadharFrontPath.value.isEmpty ? null : File(aadharFrontPath.value);

  File? get aadharBackFile =>
      aadharBackPath.value.isEmpty ? null : File(aadharBackPath.value);

  /// ✅ Uploaded URLs (API me bhejne ke liye)
  final RxString aadharFrontUrl = ''.obs;
  final RxString aadharBackUrl = ''.obs;

  final loanProvider = ''.obs;
  // final brandModel = ''.obs;

  /// COLLAPSE
  final showMore = false.obs;

  final keyType = KeyType.running.obs;

  /// PAYMENT
  final paymentType = PaymentType.emi.obs;
  final emiCycle = EmiCycle.monthly.obs;
  final deviceType = DeviceType.android.obs;

  final productPrice = TextEditingController();
  final downPayment = TextEditingController();
  final balancePayment = TextEditingController();

  final months = TextEditingController();
  final interest = TextEditingController();
  final monthlyEmi = TextEditingController();

  /// DATE
  final loanStartDate = ''.obs;

  /// IMAGE
  final ImagePicker _picker = ImagePicker();

  final RxString customerProductImagePath = ''.obs; // local preview path
  File? get customerProductImageFile =>
      customerProductImagePath.value.isEmpty ? null : File(customerProductImagePath.value);


  final isSubmitting = false.obs;

  RxBool hasSignature = false.obs;
  Uint8List? signatureBytes;

  void setSignature(Uint8List bytes) {
    signatureBytes = bytes;
    hasSignature.value = true;
  }

  void resetSignature() {
    signatureBytes = null;
    hasSignature.value = false;
    signatureController.clear();
  }

  //  Static list (future me API se replace kar dena)
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

  //  selected value
  final selectedLoanProvider = RxnString(); // null allowed

  final signatureController = SignatureController(
    penStrokeWidth: 3,
    penColor: const Color(0xFF000000),
    exportBackgroundColor: const Color(0xFFFFFFFF),
  );


  final agreeTerms = false.obs;

  void pickDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
      initialDate: DateTime.now(),
    );
    if (date != null) {
      loanStartDate.value =
      "${date.month}/${date.day}/${date.year}";
    }
  }

  /// Bottom sheet (inside controller as you asked)
  void showImagePickOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () async {
                  Navigator.pop(context);
                  await pickCustomerProductImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  await pickCustomerProductImage(ImageSource.gallery);
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

  Future<void> pickCustomerProductImage(ImageSource source) async {
    try {
      final XFile? picked = await _picker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 1200,
        maxHeight: 1200,
      );

      if (picked == null) return;

      // ✅ UI instant preview
      customerProductImagePath.value = picked.path;

      // ✅ Debug prints (path + exists + size)
      print("✅ Product Image local path: ${picked.path}");
      print("✅ Product Image file exists: ${File(picked.path).existsSync()}");
      if (File(picked.path).existsSync()) {
        print(
          "✅ Product Image size (KB): ${(File(picked.path).lengthSync() / 1024).toStringAsFixed(2)} KB",
        );
      }

      // ✅ No upload here (direct file will go in Add New Key API)
      Get.snackbar(
        "Selected",
        "Product image selected",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      debugPrint("❌ Image pick error: $e");
      Get.snackbar("Error", "Could not pick image",
          snackPosition: SnackPosition.BOTTOM);
    }
  }
  Future<void> scanImei() async {
    final result = await Get.to(() => const ImeiScannerScreen());

    if (result != null && result is String) {
      imei.text = result;
      imei.selection = TextSelection.fromPosition(
        TextPosition(offset: imei.text.length),
      );

      Get.snackbar(
        "Scanned",
        "IMEI captured successfully",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
  Future<void> scanImei2() async {
    final result = await Get.to(() => const ImeiScannerScreen());

    if (result != null && result is String) {
      imei2.text = result;
      imei2.selection = TextSelection.fromPosition(
        TextPosition(offset: imei2.text.length),
      );

      Get.snackbar(
        "Scanned",
        "IMEI 2 captured successfully",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void setLoanProvider(String? value) {
    selectedLoanProvider.value = value;
    print("✅ Loan Provider Selected: $value");
  }

  // void resetSignature() {
  //   signatureController.clear();
  // }


  bool _isValidMobile(String v) => RegExp(r'^\d{10}$').hasMatch(v);
  // bool _isValidImei(String v) => RegExp(r'^\d{14,17}$').hasMatch(v); // flexible
  bool _isValidImei(String v) => RegExp(r'^\d{15}$').hasMatch(v);


  bool validateForm() {
    if (customerProductImageFile == null) {
      Get.snackbar("Required", "Please upload product image",
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }
    if (customerName.text.trim().isEmpty) {
      Get.snackbar("Required", "Customer Name is required",
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }
    if (!_isValidMobile(mobile.text.trim())) {
      Get.snackbar("Invalid", "Enter valid 10-digit Mobile Number",
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }
    // if (!_isValidImei(imei.text.trim())) {
    //   Get.snackbar("Invalid", "Enter valid IMEI Number",
    //       snackPosition: SnackPosition.BOTTOM);
    //   return false;
    // }
    //
    // if (imei2.text.trim().isNotEmpty &&
    //     !_isValidImei(imei2.text.trim())) {
    //   Get.snackbar("Invalid", "Enter valid IMEI 2");
    //   return false;
    // }
    if (!_isValidImei(imei.text.trim())) {
      Get.snackbar("Invalid", "IMEI must be exactly 15 digits",
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }

    if (imei2.text.trim().isNotEmpty &&
        !_isValidImei(imei2.text.trim())) {
      Get.snackbar("Invalid", "IMEI 2 must be exactly 15 digits");
      return false;
    }

    if (signatureBytes ==null) {
      Get.snackbar("Required", "Customer Signature is required",
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }
    return true;
  }

  bool _hasAnyEmiValue() {
    final hasNumbers =
        _toInt(productPrice.text) > 0 ||
            _toInt(downPayment.text) > 0 ||
            _toInt(balancePayment.text) > 0 ||
            _toInt(interest.text) > 0 ||
            _toInt(monthlyEmi.text) > 0 ||
            _toInt(months.text) > 0;

    final hasDate = loanStartDate.value.trim().isNotEmpty;
    return hasNumbers || hasDate;
  }


  Future<void> submitAddKey() async {
    if (!validateForm()) return;

    try {
      isSubmitting.value = true;

      print("========== CUSTOMER ADD START ==========");

      // final sigBytes = await signatureController.toPngBytes();
      // print("signatureBytesLength: ${sigBytes?.length}");
      //
      // if (sigBytes == null || sigBytes.isEmpty) {
      //   Get.snackbar("Error", "Signature export failed", snackPosition: SnackPosition.BOTTOM);
      //   return;
      // }
      final sigBytes = signatureBytes; // ✅ use stored bytes

      print("signatureBytesLength: ${sigBytes?.length}");

      if (sigBytes == null || sigBytes.isEmpty) {
        Get.snackbar("Error", "Signature export failed",
            snackPosition: SnackPosition.BOTTOM);
        return;
      }

      Map<String, dynamic>? emiFlat;
      final hideAll = paymentType.value == PaymentType.withoutEmi;

      if (!hideAll && _hasAnyEmiValue()) {
        emiFlat = {
          "totalAmount": _toInt(productPrice.text),
          "downPayment": _toInt(downPayment.text),
          "loanAmount": _toInt(balancePayment.text),
          "interestRate": _toInt(interest.text),
          "emiAmount": _toInt(monthlyEmi.text),
          "tenureMonths": _toInt(months.text),
          "loanProvider": (selectedLoanProvider.value ?? "").trim(),
          "emiStatus": "active",
        };

        emiFlat.removeWhere((k, v) => v == null || v.toString().trim().isEmpty);
      }

      final res = await NewKeyApiService().customerAddMultipart(
        entry: entry,
        name: customerName.text.trim(),
        phone: mobile.text.trim(),
        email: "",
        imei1: imei.text.trim(),
        imei2: imei2.text.trim().isEmpty ? null : imei2.text.trim(), // ✅ NEW
        loanBy: (selectedLoanProvider.value ?? "").trim().isEmpty
            ? null
            : selectedLoanProvider.value!.trim(),
        // loanBy: selectedLoanProvider.value!.trim().isEmpty ? null : selectedLoanProvider.value!.trim(), // ✅ NEW
        profileImage: customerProductImageFile,
        aadhaarFront: aadharFrontFile,
        aadhaarBack: aadharBackFile,
        signaturePngBytes: sigBytes,
        emiFlat: emiFlat,
      );

      print("✅ CUSTOMER ADD success: ${res.success}");
      print("✅ CUSTOMER ADD message: ${res.message}");
      print("✅ CUSTOMER ADD data: ${res.data}");

      if (!res.success) {
        Get.snackbar("Error", res.message, snackPosition: SnackPosition.BOTTOM);
        return;
      }

      Get.snackbar(
        "Success",
        res.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF16A34A),
        colorText: Colors.white,
      );

      clearAll();

      /// 🔑 decide QR source
      String sourceType = "afterAddKey";

      if (entry == NewKeyEntry.running) {
        sourceType = "runningKey";
      }

      print("🚀 REDIRECT DASHBOARD");
      print("SOURCE TYPE: $sourceType");
      final createdUserId = res.data?["customer"]?["userId"] ?? "";
      print("✅ CUSTOMER ADD success and QR ID ===========>: ${createdUserId}");


      Get.offAllNamed(
        AppRoutes.DASH_RETAILER,
        arguments: {
          "showQrAfterDashboard": true,
          "source": sourceType,
          "qrUserId": createdUserId, // ✅ ADD THIS
        },
      );

      print("========== CUSTOMER ADD END ==========");

    } catch (e) {
      print("❌ CUSTOMER ADD EXCEPTION: $e");
      Get.snackbar("Error", "Add key failed", snackPosition: SnackPosition.BOTTOM);
    } finally {
      isSubmitting.value = false;
    }
  }
  int _toInt(String v) => int.tryParse(v.trim()) ?? 0;

  void pickAadharImage(BuildContext context, AadharSide side) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () async {
                  Navigator.pop(context);
                  await _pickAadhar(side, ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  await _pickAadhar(side, ImageSource.gallery);
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

  Future<void> _pickAadhar(AadharSide side, ImageSource source) async {
    try {
      final XFile? picked = await _picker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 1200,
        maxHeight: 1200,
      );

      if (picked == null) return;

      if (side == AadharSide.front) {
        aadharFrontPath.value = picked.path;
        print("✅ Aadhaar FRONT local path: ${picked.path}");
        print("✅ Aadhaar FRONT file exists: ${File(picked.path).existsSync()}");
      } else {
        aadharBackPath.value = picked.path;
        print("✅ Aadhaar BACK local path: ${picked.path}");
        print("✅ Aadhaar BACK file exists: ${File(picked.path).existsSync()}");
      }

      print("========== AADHAAR FILE DEBUG ==========");

      if (aadharFrontFile != null) {
        print("📄 Aadhaar FRONT path      : ${aadharFrontFile!.path}");
        print("📄 Aadhaar FRONT exists    : ${aadharFrontFile!.existsSync()}");
        print("📄 Aadhaar FRONT size (KB) : ${(aadharFrontFile!.lengthSync() / 1024).toStringAsFixed(2)} KB");
      } else {
        print("❌ Aadhaar FRONT is NULL");
      }

      if (aadharBackFile != null) {
        print("📄 Aadhaar BACK path       : ${aadharBackFile!.path}");
        print("📄 Aadhaar BACK exists     : ${aadharBackFile!.existsSync()}");
        print("📄 Aadhaar BACK size (KB)  : ${(aadharBackFile!.lengthSync() / 1024).toStringAsFixed(2)} KB");
      } else {
        print("❌ Aadhaar BACK is NULL");
      }

      print("=========================================");
      // ✅ No upload here
      Get.snackbar(
        "Selected",
        "Aadhaar ${side == AadharSide.front ? "Front" : "Back"} selected",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      debugPrint("❌ Aadhaar pick error: $e");
      Get.snackbar("Error", "Could not pick Aadhaar image",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void onClose() {
    customerName.dispose();
    mobile.dispose();
    imei.dispose();
    imei2.dispose();
    brandModel.dispose();
    signatureController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();

    // ✅ Auto calculate Balance
    productPrice.addListener(_computeBalance);
    downPayment.addListener(_computeBalance);

    // ✅ Auto calculate EMI
    months.addListener(_computeEmi);
    interest.addListener(_computeEmi);
    balancePayment.addListener(_computeEmi);

    // ✅ If Without EMI selected -> clear & hide values
    ever<PaymentType>(paymentType, (type) {
      if (type == PaymentType.withoutEmi) {
        _clearFinanceFields();
      } else {
        // if user came back from withoutEmi, recalc
        _computeBalance();
        _computeEmi();
      }
    });
  }

  void _clearFinanceFields() {
    productPrice.clear();
    downPayment.clear();
    balancePayment.clear();
    months.clear();
    interest.clear();
    monthlyEmi.clear();
    loanStartDate.value = '';
  }

  double _parseNum(String v) {
    final x = double.tryParse(v.trim()) ?? 0.0;
    return x.isFinite ? x : 0.0;
  }

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

    if (price <= 0) {
      // if price empty/0, don't force anything
      if (balancePayment.text.isNotEmpty) _setText(balancePayment, "");
      return;
    }

    double bal = price - down;
    if (bal < 0) bal = 0;

    // ✅ Prefill balance
    final display = bal % 1 == 0 ? bal.toStringAsFixed(0) : bal.toStringAsFixed(2);
    _setText(balancePayment, display);

    // EMI depends on balance
    _computeEmi();
  }

  // void _computeEmi() {
  //   if (paymentType.value == PaymentType.withoutEmi) return;
  //
  //   final principal = _parseNum(balancePayment.text);
  //   final m = (_parseNum(months.text)).round();
  //   final annualRate = _parseNum(interest.text);
  //
  //   // if (principal <= 0 || m <= 0 || annualRate <= 0) {
  //   //   if (monthlyEmi.text.isNotEmpty) _setText(monthlyEmi, "");
  //   //   return;
  //   // }
  //   if (principal <= 0 || m <= 0) {
  //     if (monthlyEmi.text.isNotEmpty) _setText(monthlyEmi, "");
  //     return;
  //   }
  //
  //   // ✅ Convert cycle -> number of periods + rate per period
  //   int periods;
  //   double ratePerPeriod;
  //
  //   switch (emiCycle.value) {
  //     case EmiCycle.monthly:
  //       periods = m; // months
  //       ratePerPeriod = (annualRate / 100) / 12;
  //       break;
  //
  //     case EmiCycle.weekly:
  //       periods = m * 4; // approx 4 weeks per month
  //       ratePerPeriod = (annualRate / 100) / 52;
  //       break;
  //
  //     case EmiCycle.daily:
  //       periods = m * 30; // approx 30 days per month
  //       ratePerPeriod = (annualRate / 100) / 365;
  //       break;
  //   }
  //
  //   if (periods <= 0) return;
  //
  //   // ✅ EMI formula: P*r*(1+r)^n / ((1+r)^n - 1)
  //   double emi;
  //   if (ratePerPeriod == 0) {
  //     emi = principal / periods;
  //   } else {
  //     final powVal = (1 + ratePerPeriod);
  //     final factor = powVal == 0 ? 0 : (powVal);
  //     // use dart pow:
  //     final a = (powVal);
  //     final numerator = principal * ratePerPeriod * (pow(a, periods).toDouble());
  //     final denominator = (pow(a, periods).toDouble()) - 1;
  //     emi = denominator == 0 ? 0 : (numerator / denominator);
  //   }
  //
  //   if (!emi.isFinite || emi < 0) emi = 0;
  //
  //   final display = emi.toStringAsFixed(2);
  //   _setText(monthlyEmi, display);
  // }


  // void _computeEmi() {
  //   if (paymentType.value == PaymentType.withoutEmi) return;
  //
  //   final principal = _parseNum(balancePayment.text);
  //   final m = _parseNum(months.text).round();
  //
  //   final interestText = interest.text.trim();
  //   final isInterestEmpty = interestText.isEmpty;
  //
  //   final annualRate = _parseNum(interestText);
  //
  //   // ✅ agar required fields empty hain → EMI clear
  //   if (principal <= 0 || m <= 0 || isInterestEmpty) {
  //     if (monthlyEmi.text.isNotEmpty) {
  //       _setText(monthlyEmi, "");
  //     }
  //     return;
  //   }
  //
  //   int periods;
  //   double ratePerPeriod;
  //
  //   switch (emiCycle.value) {
  //     case EmiCycle.monthly:
  //       periods = m;
  //       ratePerPeriod = (annualRate / 100) / 12;
  //       break;
  //
  //     case EmiCycle.weekly:
  //       periods = m * 4;
  //       ratePerPeriod = (annualRate / 100) / 52;
  //       break;
  //
  //     case EmiCycle.daily:
  //       periods = m * 30;
  //       ratePerPeriod = (annualRate / 100) / 365;
  //       break;
  //   }
  //
  //   if (periods <= 0) return;
  //
  //   double emi = 0;
  //
  //   // ✅ 0% interest → calculate
  //   if (annualRate == 0) {
  //     emi = principal / periods;
  //   } else {
  //     final r = ratePerPeriod;
  //     final powVal = pow(1 + r, periods).toDouble();
  //     emi = (principal * r * powVal) / (powVal - 1);
  //   }
  //
  //   if (!emi.isFinite || emi < 0) emi = 0;
  //
  //   final display = emi % 1 == 0
  //       ? emi.toStringAsFixed(0)
  //       : emi.toStringAsFixed(2);
  //
  //   _setText(monthlyEmi, display);
  // }

  void _computeEmi() {
    if (paymentType.value == PaymentType.withoutEmi) return;

    final principal = _parseNum(balancePayment.text);
    final m = _parseNum(months.text).round();
    final interestText = interest.text.trim();

    final rateInput = _parseNum(interestText);

    int periods;
    double ratePerPeriod;

    switch (emiCycle.value) {
      case EmiCycle.monthly:
        periods = m;

        // ✅ FIX: interest ko direct monthly treat karo
        ratePerPeriod = rateInput / 100;
        break;

      case EmiCycle.weekly:
        periods = m * 4;

        // approx weekly conversion
        ratePerPeriod = (rateInput / 100) / 4;
        break;

      case EmiCycle.daily:
        periods = m * 30;

        // approx daily conversion
        ratePerPeriod = (rateInput / 100) / 30;
        break;
    }

    // ✅ handle empty / 0 case → auto fill 0
    if (principal <= 0 || periods <= 0) {
      _setText(monthlyEmi, "0");
      return;
    }

    double emi = 0;

    // ✅ 0 interest case
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

    _setText(monthlyEmi, display);
  }
  void recalcEmi() => _computeEmi();

  void clearAll() {
    // basic
    customerName.clear();
    scheme.clear();
    mobile.clear();
    imei.clear();
    brandModel.clear();

    // dropdown
    selectedLoanProvider.value = null;

    // payment/emi fields
    productPrice.clear();
    downPayment.clear();
    balancePayment.clear();
    months.clear();
    interest.clear();
    monthlyEmi.clear();

    // date
    loanStartDate.value = '';

    // image
    customerProductImagePath.value = '';

    // signature
    resetSignature();

    // reset toggles/enums (optional but best UX)
    showMore.value = false;
    keyType.value = KeyType.running;
    paymentType.value = PaymentType.emi;
    emiCycle.value = EmiCycle.monthly;
    deviceType.value = DeviceType.android;
    agreeTerms.value = false;
    aadharFrontPath.value ="" ;
    aadharBackPath.value = "";

  }

  Future<bool> confirmExitAndClear() async {
    if (isSubmitting.value) {
      Get.snackbar("Please wait", "Submitting in progress...",
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }

    // agar form blank hai to direct allow
    final hasAnyData = _hasUnsavedData();
    if (!hasAnyData) return true;

    final bool? ok = await Get.dialog<bool>(
      AlertDialog(
        title: const Text("Exit?"),
        content: const Text("Filled data will be cleared. Do you want to exit?"),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text("Yes, Exit"),
          ),
        ],
      ),
      barrierDismissible: false,
    );

    if (ok == true) {
      clearAll();
      return true;
    }
    return false;
  }

  bool _hasUnsavedData() {
    return customerName.text.trim().isNotEmpty ||
        scheme.text.trim().isNotEmpty ||
        mobile.text.trim().isNotEmpty ||
        imei.text.trim().isNotEmpty ||
        brandModel.text.trim().isNotEmpty ||
        (selectedLoanProvider.value != null && selectedLoanProvider.value!.isNotEmpty) ||
        productPrice.text.trim().isNotEmpty ||
        downPayment.text.trim().isNotEmpty ||
        balancePayment.text.trim().isNotEmpty ||
        months.text.trim().isNotEmpty ||
        interest.text.trim().isNotEmpty ||
        monthlyEmi.text.trim().isNotEmpty ||
        loanStartDate.value.trim().isNotEmpty ||
        customerProductImagePath.value.isNotEmpty ||
        // ✅ Aadhaar (NEW)
        aadharFrontPath.value.isNotEmpty ||
        aadharBackPath.value.isNotEmpty ||

        signatureController.isNotEmpty;

  }

  // ✅ Agreement download states
  final isGeneratingAgreement = false.obs;
  final agreementPath = "".obs;

  // bool get hasSignature => signatureController.isNotEmpty;

  Future<Uint8List?> buildAgreementPdfBytes() async {
    try {
      final Uint8List? signBytes = await signatureController.toPngBytes();
      if (signBytes == null || signBytes.isEmpty) {
        Get.snackbar("Error", "Signature required",
            snackPosition: SnackPosition.BOTTOM);
        return null;
      }

      final pdf = pw.Document();

      String line(String v, {int len = 30}) {
        if (v.trim().isEmpty) return "_" * len;
        return v;
      }

      final now = DateTime.now();
      final dateStr =
          "${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}";

      final logo = pw.MemoryImage(
        (await rootBundle.load('assets/images/lock_pe.png'))
            .buffer
            .asUint8List(),
      );

      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.fromLTRB(28, 30, 28, 30),
          build: (context) => [
            pw.Center(
              child: pw.Column(
                children: [
                  pw.Image(logo, height: 70),
                  pw.SizedBox(height: 10),
                ],
              ),
            ),

            pw.Text(
              "EMI Device Purchase – Short Terms & Conditions (Locker App Enabled)",
              style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 10),

            // ✅ Keep same fields (no impact)
            pw.Text("Retailer (Shop Name & Address): ${line(selectedLoanProvider.value ?? '')}"),
            pw.SizedBox(height: 4),
            pw.Text("Customer Name: ${line(customerName.text)}"),
            pw.SizedBox(height: 4),
            pw.Text("Customer Contact No.: ${line(mobile.text)}"),

            pw.SizedBox(height: 12),

            _sectionTitle("1. EMI Agreement"),
            _para("The customer is purchasing the device on an EMI basis and agrees to make all EMI payments on time as per the agreed payment schedule."),

            _sectionTitle("2. Ownership"),
            _para("Ownership of the device shall remain with the retailer until the full EMI amount is paid. Ownership will be transferred to the customer only after complete payment."),

            _sectionTitle("3. Locker App & Device Lock"),
            _para("The device comes with a pre-installed Locker App.\nIn case of late or unpaid EMI, the retailer has the right to lock the device. The device will be unlocked only after pending payments are cleared."),

            _sectionTitle("4. App Permissions"),
            _para("The customer agrees to allow the following permissions required by the Locker App:\n\n"
                "1. Location Access     2. SIM Card Information     3. IMEI / Device ID Access\n\n"
                "These permissions will be used only for payment security, device tracking, and recovery purposes."),

            _sectionTitle("5. App Removal / Tampering"),
            _para("The customer shall not remove, disable, reset, or tamper with the Locker App.\n"
                "Any such action will be treated as a serious violation of this agreement and may result in legal action."),

            _sectionTitle("6. Device Usage Responsibility"),
            _para("Proper use and safety of the device are the customer’s responsibility.\n"
                "The retailer will not be responsible for any damage, misuse, or illegal activity involving the device."),

            _sectionTitle("7. Data, Theft & Reset"),
            _para("The retailer, company, and app developer shall not be responsible for data loss, theft, factory reset, technical issues, or third-party interference."),

            _sectionTitle("8. Repeated Default"),
            _para("In case of repeated EMI defaults, the retailer may:\n"
                "(1) Permanently lock the Device   (2) Repossess the Device   (3) Initiate legal recovery proceedings"),

            _sectionTitle("9. EMI Completion"),
            _para("After full EMI payment:\n"
                "• The device will be fully unlocked\n"
                "• Ownership will be transferred to the customer\n"
                "• The Locker App will be removed upon request"),

            _sectionTitle("10. Legal & Jurisdiction"),
            _para("This agreement shall be governed by the applicable local laws.\n"
                "In case of any dispute, both parties shall first attempt mutual resolution before proceeding with legal action."),

            pw.SizedBox(height: 14),

            pw.Text("Model & OS: __________ (Android 15)\nActivated On: $dateStr     Time: ________"),
            pw.SizedBox(height: 10),
            pw.Text("IMEI No: ${line(imei.text, len: 20)}"),

            pw.SizedBox(height: 24),

            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text("Powered By:"),
                    pw.Image(logo, height: 45),
                  ],
                ),
                pw.Spacer(),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text("Customer Signature:"),
                    pw.SizedBox(height: 6),
                    pw.Container(
                      width: 160,
                      height: 60,
                      decoration: pw.BoxDecoration(border: pw.Border.all()),
                      child: pw.Image(pw.MemoryImage(signBytes), fit: pw.BoxFit.contain),
                    ),
                  ],
                ),
              ],
            ),

            pw.SizedBox(height: 20),
            pw.Text("Retailers Signature: _________________________"),
            pw.SizedBox(height: 20),

            pw.Center(
              child: pw.Text(
                "For any queries or support kindly call: 8810422690",
                style: const pw.TextStyle(fontSize: 11),
              ),
            ),
          ],
        ),
      );

      final bytes = await pdf.save();

      // ✅ prints
      debugPrint("✅ Agreement PDF Bytes generated: ${bytes.length}");
      print("✅ Agreement PDF Bytes generated: ${bytes.length}");

      return bytes;
    } catch (e) {
      debugPrint("❌ buildAgreementPdfBytes error: $e");
      return null;
    }
  }

  Future<void> generateAndDownloadAgreementPdf() async {
    if (isGeneratingAgreement.value) return;

    try {
      isGeneratingAgreement.value = true;

      final Uint8List? signBytes = await signatureController.toPngBytes();
      if (signBytes == null) {
        Get.snackbar("Error", "Signature required",
            snackPosition: SnackPosition.BOTTOM);
        return;
      }

      final pdf = pw.Document();

      String line(String v, {int len = 30}) {
        if (v.trim().isEmpty) {
          return "_" * len;
        }
        return v;
      }

      final now = DateTime.now();
      final dateStr =
          "${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}";

      final logo = pw.MemoryImage(
        (await rootBundle.load('assets/images/lock_pe.png'))
            .buffer
            .asUint8List(),
      );

      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.fromLTRB(28, 30, 28, 30),
          build: (context) => [
            // LOGO
            pw.Center(
              child: pw.Column(
                children: [
                  pw.Image(logo, height: 70),
                  pw.SizedBox(height: 10),
                ],
              ),
            ),

            pw.Text(
              "EMI Device Purchase – Short Terms & Conditions (Locker App Enabled)",
              style: pw.TextStyle(
                fontSize: 13,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 10),

            pw.Text(
                "Retailer (Shop Name & Address): ${line(selectedLoanProvider.value ?? '')}"),
            pw.SizedBox(height: 4),
            pw.Text("Customer Name: ${line(customerName.text)}"),
            pw.SizedBox(height: 4),
            pw.Text("Customer Contact No.: ${line(mobile.text)}"),

            pw.SizedBox(height: 12),

            _sectionTitle("1. EMI Agreement"),
            _para(
                "The customer is purchasing the device on an EMI basis and agrees to make all EMI payments on time as per the agreed payment schedule."),

            _sectionTitle("2. Ownership"),
            _para(
                "Ownership of the device shall remain with the retailer until the full EMI amount is paid. Ownership will be transferred to the customer only after complete payment."),

            _sectionTitle("3. Locker App & Device Lock"),
            _para(
                "The device comes with a pre-installed Locker App.\nIn case of late or unpaid EMI, the retailer has the right to lock the device. The device will be unlocked only after pending payments are cleared."),

            _sectionTitle("4. App Permissions"),
            _para(
                "The customer agrees to allow the following permissions required by the Locker App:\n\n"
                    "1. Location Access     2. SIM Card Information     3. IMEI / Device ID Access\n\n"
                    "These permissions will be used only for payment security, device tracking, and recovery purposes."),

            _sectionTitle("5. App Removal / Tampering"),
            _para(
                "The customer shall not remove, disable, reset, or tamper with the Locker App.\n"
                    "Any such action will be treated as a serious violation of this agreement and may result in legal action."),

            _sectionTitle("6. Device Usage Responsibility"),
            _para(
                "Proper use and safety of the device are the customer’s responsibility.\n"
                    "The retailer will not be responsible for any damage, misuse, or illegal activity involving the device."),

            _sectionTitle("7. Data, Theft & Reset"),
            _para(
                "The retailer, company, and app developer shall not be responsible for data loss, theft, factory reset, technical issues, or third-party interference."),

            _sectionTitle("8. Repeated Default"),
            _para(
                "In case of repeated EMI defaults, the retailer may:\n"
                    "(1) Permanently lock the Device   (2) Repossess the Device   (3) Initiate legal recovery proceedings"),

            _sectionTitle("9. EMI Completion"),
            _para(
                "After full EMI payment:\n"
                    "• The device will be fully unlocked\n"
                    "• Ownership will be transferred to the customer\n"
                    "• The Locker App will be removed upon request"),

            _sectionTitle("10. Legal & Jurisdiction"),
            _para(
                "This agreement shall be governed by the applicable local laws.\n"
                    "In case of any dispute, both parties shall first attempt mutual resolution before proceeding with legal action."),

            pw.SizedBox(height: 14),

            pw.Text(
                "Model & OS: __________ (Android 15)\nActivated On: $dateStr     Time: ________"),
            pw.SizedBox(height: 10),
            pw.Text("IMEI No: ${line(imei.text, len: 20)}"),

            pw.SizedBox(height: 24),

            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text("Powered By:"),
                    pw.Image(logo, height: 45),
                  ],
                ),
                pw.Spacer(),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text("Customer Signature:"),
                    pw.SizedBox(height: 6),
                    pw.Container(
                      width: 160,
                      height: 60,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(),
                      ),
                      child: pw.Image(pw.MemoryImage(signBytes),
                          fit: pw.BoxFit.contain),
                    ),
                  ],
                ),
              ],
            ),

            pw.SizedBox(height: 20),

            pw.Text("Retailers Signature: _________________________"),

            pw.SizedBox(height: 20),

            pw.Center(
              child: pw.Text(
                "For any queries or support kindly call: 8810422690",
                style: const pw.TextStyle(fontSize: 11),
              ),
            ),
          ],
        ),
      );

      final dir = await getExternalStorageDirectory();
      final folder = Directory("${dir!.path}/Agreements");
      if (!await folder.exists()) await folder.create(recursive: true);

      final file =
      File("${folder.path}/Agreement_${now.millisecondsSinceEpoch}.pdf");
      await file.writeAsBytes(await pdf.save());

      Get.snackbar("Downloaded", "Agreement saved successfully",
          snackPosition: SnackPosition.BOTTOM);

      await OpenFilex.open(file.path);
    } catch (e) {
      Get.snackbar("Error", "Agreement generation failed",
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isGeneratingAgreement.value = false;
    }
  }

  pw.Widget _sectionTitle(String title) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(top: 10, bottom: 4),
      child: pw.Text(
        title,
        style: pw.TextStyle(
          fontSize: 12,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    );
  }

  pw.Widget _para(String text) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 8),
      child: pw.Text(
        text,
        style: const pw.TextStyle(
          fontSize: 11,
          height: 1.4,
        ),
      ),
    );
  }
}
