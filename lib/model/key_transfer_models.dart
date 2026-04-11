class KeyTransferRequest {
  final String retailerId;
  final String type;    // "CREDIT" or "DEBIT"
  final String keyType; // "ANDROID" or "IPHONE"
  final int quantity;

  KeyTransferRequest({
    required this.retailerId,
    required this.type,
    required this.keyType,
    required this.quantity,
  });

  Map<String, dynamic> toJson() => {
    "retailerId": retailerId,
    "type": type,
    "keyType": keyType,
    "quantity": quantity,
  };
}

// class KeyTransferResponse {
//   final bool success;
//   final String message;
//
//   KeyTransferResponse({
//     required this.success,
//     required this.message,
//   });
//
//   factory KeyTransferResponse.fromJson(Map<String, dynamic> json) {
//     return KeyTransferResponse(
//       success: (json["success"] ?? false) == true,
//       message: (json["message"] ?? "").toString(),
//     );
//   }
// }

class KeyTransferResponse {
  final bool success;
  final String message;

  KeyTransferResponse({
    required this.success,
    required this.message,
  });

  factory KeyTransferResponse.fromJson(Map<String, dynamic> json) {
    return KeyTransferResponse(
      success: json["success"] == true,
      message: (json["message"] ?? "").toString(),
    );
  }
}