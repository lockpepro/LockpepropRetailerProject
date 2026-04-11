import '../../modules/retailer/Add_new_key/new_key_controller.dart';

// class AddKeyRequest {
//   final String customerName;
//   final String mobileNumber;
//   final String imeiNumber;
//   final String loanProvider;
//   final String brandModel;
//
//   final PaymentType paymentType;
//   final DeviceType deviceType;
//
//   // optional EMI fields (but postman me sab ja rahe)
//   final String? productPrice;
//   final String? downPayment;
//   final String? balancePayment;
//
//   final EmiCycle? emiType;
//   final String? tenureMonths;
//   final String? interestRate;
//   final String? emiAmount;
//
//   final String? loanStartDate; // YYYY-MM-DD
//
//   AddKeyRequest({
//     required this.customerName,
//     required this.mobileNumber,
//     required this.imeiNumber,
//     required this.loanProvider,
//     required this.brandModel,
//     required this.paymentType,
//     required this.deviceType,
//     this.productPrice,
//     this.downPayment,
//     this.balancePayment,
//     this.emiType,
//     this.tenureMonths,
//     this.interestRate,
//     this.emiAmount,
//     this.loanStartDate,
//   });
//
//   Map<String, dynamic> toJson() {
//     return {
//       "customerName": customerName,
//       "mobileNumber": mobileNumber,
//       "imeiNumber": imeiNumber,
//       "loanProvider": loanProvider,
//       "brandModel": brandModel,
//       "paymentType": paymentType.name,
//       "deviceType": deviceType.name,
//
//       if (productPrice != null) "productPrice": productPrice,
//       if (downPayment != null) "downPayment": downPayment,
//       if (balancePayment != null) "balancePayment": balancePayment,
//
//       if (emiType != null) "emiType": emiType!.name,
//       if (tenureMonths != null) "tenureMonths": tenureMonths,
//       if (interestRate != null) "interestRate": interestRate,
//       if (emiAmount != null) "emiAmount": emiAmount,
//
//       if (loanStartDate != null) "loanStartDate": loanStartDate,
//     };
//   }
// }
class AddKeyRequest {
  final String customerName;
  final String mobileNumber;
  final String imeiNumber;
  final String loanProvider;
  final String brandModel;

  final PaymentType paymentType;
  final DeviceType deviceType;

  // optional finance fields
  final String? productPrice;
  final String? downPayment;
  final String? balancePayment;

  final EmiCycle? emiType;
  final String? tenureMonths;
  final String? interestRate;
  final String? emiAmount;

  final String? loanStartDate;
  final String? purchaseAgreement;

  AddKeyRequest({
    required this.customerName,
    required this.mobileNumber,
    required this.imeiNumber,
    required this.loanProvider,
    required this.brandModel,
    required this.paymentType,
    required this.deviceType,
    this.productPrice,
    this.downPayment,
    this.balancePayment,
    this.emiType,
    this.tenureMonths,
    this.interestRate,
    this.emiAmount,
    this.loanStartDate,
    this.purchaseAgreement,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      "customerName": customerName.trim(),
      "mobileNumber": mobileNumber.trim(),
      "imeiNumber": imeiNumber.trim(),
      "loanProvider": loanProvider.trim(),
      "brandModel": brandModel.trim(),

      // ✅ enums correct for API
      "paymentType": paymentType.apiValue, // EMI/ECS/E_MANDATE/WITHOUT_EMI
      "deviceType": deviceType.apiValue,   // ANDROID/IPHONE
    };

    // ✅ only send when non-empty (prevents "" from going)
    void putIfNotEmpty(String key, String? value) {
      final v = value?.trim();
      if (v != null && v.isNotEmpty) {
        map[key] = v;
      }
    }

    putIfNotEmpty("productPrice", productPrice);
    putIfNotEmpty("downPayment", downPayment);
    putIfNotEmpty("balancePayment", balancePayment);

    // ✅ emiType must be UPPERCASE enum for backend
    if (emiType != null) {
      map["emiType"] = emiType!.apiValue; // DAILY/WEEKLY/MONTHLY
    }

    putIfNotEmpty("tenureMonths", tenureMonths);
    putIfNotEmpty("interestRate", interestRate);
    putIfNotEmpty("emiAmount", emiAmount);

    putIfNotEmpty("loanStartDate", loanStartDate);
    putIfNotEmpty("purchaseAgreement", purchaseAgreement);

    return map;
  }
}