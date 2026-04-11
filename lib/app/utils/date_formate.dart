import 'package:intl/intl.dart';

// String formatApiDateTime(String isoDate) {
//   try {
//     final utcDate = DateTime.parse(isoDate).toUtc();
//     final localDate = utcDate.toLocal();
//
//     return DateFormat('dd MMM yyyy, hh:mm a').format(localDate);
//   } catch (e) {
//     return isoDate; // fallback
//   }
// }

String formatApiDate(String isoDate) {
  try {
    final utcDate = DateTime.parse(isoDate).toUtc();
    final localDate = utcDate.toLocal();
    return DateFormat('dd MMM yyyy').format(localDate);
  } catch (e) {
    return isoDate;
  }
}

String formatApiTime(String isoDate) {
  try {
    final utcDate = DateTime.parse(isoDate).toUtc();
    final localDate = utcDate.toLocal();
    return DateFormat('hh:mm a').format(localDate);
  } catch (e) {
    return '';
  }
}


final _inr = NumberFormat.currency(locale: 'en_IN', symbol: '₹ ', decimalDigits: 2);

String fmtMoney(num v) => _inr.format(v);

String fmtDate(String iso, {String fallback = "-"}) {
  if (iso.trim().isEmpty || iso == "-") return fallback;
  try {
    final dt = DateTime.parse(iso).toLocal();
    return DateFormat('dd/MMM/yyyy').format(dt); // 31/Jan/2026
  } catch (_) {
    return fallback;
  }
}

String fmtTenureMonths(int m) => (m <= 0) ? "-" : "$m Months";
String fmtPercent(double p) {
  if (p.isNaN) return "0%";
  // API sometimes gives 0..100, but can be 0..1 also
  final val = (p <= 1) ? (p * 100) : p;
  return "${val.round()}%";
}

double clamp01(double v) => v < 0 ? 0 : (v > 1 ? 1 : v);
