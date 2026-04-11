// lib/views/product_list_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zlock_smart_finance/app/constants/app_colors.dart';
import 'package:zlock_smart_finance/modules/retailer/b2b_order/controller/product_controller.dart';
import 'package:zlock_smart_finance/modules/retailer/b2b_order/views/my_order_page.dart';
import 'package:zlock_smart_finance/modules/retailer/b2b_order/views/product_detail_page.dart';
import 'package:zlock_smart_finance/modules/retailer/dashboard/dashboard_retailer.dart';
import '../widgets/product_card.dart';

class ProductListPage extends StatelessWidget {
  ProductListPage({super.key});

  final ProductController c = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _appBar(),
            _search(),
            Expanded(
              child: Obx(() => ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: c.filteredList.length,
                itemBuilder: (_, i) {
                  final item = c.filteredList[i];
                  return ProductCard(
                    product: item,
                    onTap: () {
                      Get.to(() => ProductDetailPage());
                    },
                  );
                },
              )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _appBar() => Padding(
    padding: const EdgeInsets.all(16),
    child: Row(
      children: [
        InkWell(
          onTap: () {
            Get.offAll(RetailerDashboard());
          },
          // onTap: () => Get.back(),
            child: const Icon(Icons.arrow_back)),
        const SizedBox(width: 12),
        const Text("Product",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600)),
        const Spacer(),
        InkWell(
          onTap: () {
            Get.to(MyOrderPage());
          },
          child: Container(
            padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text("My Orders",
                style: TextStyle(color: Colors.white)),
          ),
        )
      ],
    ),
  );

  Widget _search() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: TextField(
      onChanged: (v) => c.search.value = v,
      decoration: InputDecoration(
        hintText: "Search Product",
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    ),
  );
}
