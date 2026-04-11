import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zlock_smart_finance/app/constants/app_colors.dart';
import 'package:zlock_smart_finance/modules/retailer/b2b_order/controller/my_order_controller.dart';
import '../widgets/order_card.dart';

class MyOrderPage extends StatelessWidget {
  static const routeName = '/my-order';

  MyOrderPage({super.key});

  final controller = Get.put(MyOrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "My order",
          style: TextStyle(color: Colors.black),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.favorite_border, color: Colors.black),
          )
        ],
      ),
      body: Column(
        children: [
          _tabs(),
          Expanded(child: _orderList()),
        ],
      ),
    );
  }

  Widget _tabs() {
    return Obx(() {
      return Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: AppColors.lightGrey,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            _tabItem("Ongoing", 0),
            _tabItem("Order Completed", 1),
          ],
        ),
      );
    });
  }

  Widget _tabItem(String text, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.changeTab(index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: controller.selectedTab.value == index
                ? AppColors.primaryBlue
                : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: controller.selectedTab.value == index
                  ? Colors.white
                  : Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _orderList() {
    return Obx(() {
      final list = controller.selectedTab.value == 0
          ? controller.ongoingOrders
          : controller.completedOrders;

      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: list.length,
        itemBuilder: (_, index) {
          return OrderCard(
            data: list[index],
            completed: controller.selectedTab.value == 1,
          );
        },
      );
    });
  }
}
