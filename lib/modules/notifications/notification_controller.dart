import 'dart:ui';

import 'package:get/get.dart';

class NotificationController extends GetxController {
  var notifications = <NotificationModel>[
    NotificationModel(
      title: "Transaction Credit",
      message:
      "You Have received a transaction of \$49.99 from LockPe.",
      time: "3 days ago",
      iconBgColor: const Color(0xFFE6F6EC),
      icon: "assets/icons/transaction.svg",
    ),
  ].obs;
}

class NotificationModel {
  final String title;
  final String message;
  final String time;
  final String icon;
  final Color iconBgColor;

  NotificationModel({
    required this.title,
    required this.message,
    required this.time,
    required this.icon,
    required this.iconBgColor,
  });
}
