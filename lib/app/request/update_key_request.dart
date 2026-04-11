import 'package:zlock_smart_finance/modules/retailer/Add_new_key/new_key_controller.dart';

class UpdateKeyRequest {
  final String imeiNumber;
  final String loanProvider;
  final String brandModel;
  final PaymentType paymentType;

  final String? productPrice;
  final String? downPayment;
  final String? balancePayment;

  final EmiCycle emiType;
  final String? tenureMonths;
  final String? interestRate;
  final String? emiAmount;
  final String? loanStartDate; // postman me text hi bhej rahe ho

  UpdateKeyRequest({
    required this.imeiNumber,
    required this.loanProvider,
    required this.brandModel,
    required this.paymentType,
    required this.emiType,
    this.productPrice,
    this.downPayment,
    this.balancePayment,
    this.tenureMonths,
    this.interestRate,
    this.emiAmount,
    this.loanStartDate,
  });

  Map<String, dynamic> toJson() {
    return {
      "imeiNumber": imeiNumber.trim(),
      "loanProvider": loanProvider.trim(),
      "brandModel": brandModel.trim(),
      "paymentType": paymentType.apiValue,
      "emiType": emiType.apiValue,

      if (productPrice != null && productPrice!.trim().isNotEmpty)
        "productPrice": productPrice!.trim(),
      if (downPayment != null && downPayment!.trim().isNotEmpty)
        "downPayment": downPayment!.trim(),
      if (balancePayment != null && balancePayment!.trim().isNotEmpty)
        "balancePayment": balancePayment!.trim(),

      if (tenureMonths != null && tenureMonths!.trim().isNotEmpty)
        "tenureMonths": tenureMonths!.trim(),
      if (interestRate != null && interestRate!.trim().isNotEmpty)
        "interestRate": interestRate!.trim(),
      if (emiAmount != null && emiAmount!.trim().isNotEmpty)
        "emiAmount": emiAmount!.trim(),

      if (loanStartDate != null && loanStartDate!.trim().isNotEmpty)
        "loanStartDate": loanStartDate!.trim(),
    };
  }
}
