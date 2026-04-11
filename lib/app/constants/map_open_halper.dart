// import 'package:url_launcher/url_launcher.dart';
//
// Future<void> openMap(double lat, double lng) async {
//
//   final Uri url = Uri.parse(
//       "https://www.google.com/maps/search/?api=1&query=$lat,$lng");
//
//   if (await canLaunchUrl(url)) {
//     await launchUrl(url);
//   }
// }
import 'package:url_launcher/url_launcher.dart';

Future<void> openMap(double lat, double lng) async {

  final Uri googleMapUrl = Uri.parse(
    "https://www.google.com/maps/search/?api=1&query=$lat,$lng",
  );

  if (!await launchUrl(
    googleMapUrl,
    mode: LaunchMode.externalApplication,
  )) {
    throw Exception("Could not open map");
  }
}