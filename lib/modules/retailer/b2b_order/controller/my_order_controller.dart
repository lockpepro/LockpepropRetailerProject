import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyOrderController extends GetxController {
  RxInt selectedTab = 0.obs;
  RxInt rating = 4.obs;

  final reviewController = TextEditingController();

  List<Map<String, String>> ongoingOrders = List.generate(5, (index) => {
    "title": "Apple Iphone 15 Pro 128GB Natural Titanium",
    "date": "Arriving on 19th Nov 2025",
    "image":"assets/images/my_order.png"
  });

  List<Map<String, String>> completedOrders = List.generate(4, (index) => {
    "title": "Apple Iphone 15 Pro 128GB Natural Titanium",
    "date": "Delivered on Nov 20",
    "image":"assets/images/my_order.png"
  });

  void changeTab(int index) {
    selectedTab.value = index;
  }

  void submitReview() {
    Get.back();
    Get.snackbar(
      "Thank You",
      "Review submitted successfully",
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
