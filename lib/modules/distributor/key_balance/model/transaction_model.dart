import 'package:intl/intl.dart';

class TransactionModel {
  final bool isCredit;
  final String partyName;
  final String date;
  final String time;
  final String amount;
  final String byText;

  TransactionModel({
    required this.isCredit,
    required this.partyName,
    required this.date,
    required this.time,
    required this.amount,
    required this.byText,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    final type = (json["type"] ?? "").toString().toUpperCase();
    final createdBy = (json["createdBy"] ?? "").toString().trim();
    final desc = (json["description"] ?? "").toString().trim();

    final rawDate = (json["createdAt"] ?? "").toString();
    DateTime createdAt;
    try {
      createdAt = DateTime.parse(rawDate).toLocal();
    } catch (_) {
      createdAt = DateTime.now();
    }

    final credit = type == "CREDIT";

    final amountNum = (json["amount"] is num)
        ? (json["amount"] as num).toDouble()
        : double.tryParse((json["amount"] ?? "0").toString()) ?? 0.0;

    final dateStr = _uiDate(createdAt);
    final timeStr = _uiTime(createdAt);

    // ✅ CREDIT = -₹ , DEBIT = +₹ (as per your screenshot)
    final sign = credit ? "-" : "+";
    final amountStr = "$sign₹${amountNum.toStringAsFixed(0)}";

    return TransactionModel(
      isCredit: credit,
      partyName: desc.isEmpty ? "Transaction" : desc,
      date: dateStr,
      time: timeStr,
      amount: amountStr,
      byText: credit
          ? "Sent By: ${createdBy.isEmpty ? "N/A" : createdBy}"
          : "Received By: ${createdBy.isEmpty ? "N/A" : createdBy}",
    );
  }

  static String _uiDate(DateTime dt) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final d0 = DateTime(dt.year, dt.month, dt.day);

    final diff = today.difference(d0).inDays;
    if (diff == 0) return "Today";
    if (diff == 1) return "Yesterday";
    return DateFormat("dd-MMM-yyyy").format(dt);
  }

  static String _uiTime(DateTime dt) {
    // "02.35 pm"
    final s = DateFormat("hh:mm a").format(dt).toLowerCase();
    return s.replaceAll(":", ".");
  }
}
