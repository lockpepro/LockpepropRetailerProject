// lib/views/product_detail_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zlock_smart_finance/app/constants/app_colors.dart';
import 'package:zlock_smart_finance/modules/retailer/b2b_order/controller/product_detail_controller.dart';
import 'package:zlock_smart_finance/modules/retailer/b2b_order/views/checkout_page.dart';

class ProductDetailPage extends StatelessWidget {
  ProductDetailPage({super.key});

  final ProductDetailController c =
  Get.put(ProductDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _appBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _productImage(),
                    const SizedBox(height: 16),
                    _titleSection(),
                    const SizedBox(height: 14),
                    _priceSection(),
                    const SizedBox(height: 16),
                    _aboutProduct(),
                    const SizedBox(height: 12),
                    _expandTile(
                      title: "Product description",
                      value: c.showDesc,
                      content:
                      "A Recliner Armchair is a comfortable, adjustable chair designed for relaxation. It features a reclining backrest and a footrest that can be extended to various positions.",
                    ),
                    _expandTile(
                      title: "Product details",
                      value: c.showDetails,
                      content:
                      "Material: Premium\nWarranty: 1 year\nCountry: USA",
                    ),
                    const SizedBox(height: 20),
                    _reviewSection(),
                    const SizedBox(height: 20),
                    _trendingSection(),
                    const SizedBox(height: 130),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: _bottomButtons(),
    );
  }

  // ================= APP BAR =================
  Widget _appBar() => Padding(
    padding: const EdgeInsets.all(16),
    child: Row(
      children: [
        InkWell(
          onTap: () => Get.back(),
            child: const Icon(Icons.arrow_back)),
        const SizedBox(width: 12),
        const Text("Detail Order",
            style:
            TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        const Spacer(),
        Obx(() => GestureDetector(
          onTap: c.toggleFav,
          child: Icon(
            c.isFav.value
                ? Icons.favorite
                : Icons.favorite_border,
            color: c.isFav.value
                ? Colors.red
                : Colors.black,
          ),
        )),
      ],
    ),
  );

  // ================= IMAGE =================
  Widget _productImage() => Center(
    child: Image.asset(
      "assets/images/iphone_big.png",
      height: 260,
      fit: BoxFit.contain,
    ),
  );

  // ================= TITLE =================
  Widget _titleSection() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: const [
      Chip(
        label: Text("Electronics product"),
        backgroundColor: Color(0xffEEF3FF),
      ),
      SizedBox(height: 8),
      Text(
        "Apple iPhone 15 Pro 128GB Natural Titanium",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      ),
    ],
  );

  // ================= PRICE =================
  Widget _priceSection() => Row(
    children: const [
      Text("\$699.00",
          style:
          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      SizedBox(width: 8),
      Text("\$730.00",
          style: TextStyle(
              decoration: TextDecoration.lineThrough,
              color: Colors.grey)),
      SizedBox(width: 8),
      Chip(
        label: Text("10% off",
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
      )
    ],
  );

  // ================= ABOUT =================
  Widget _aboutProduct() => const Text(
    "About this product",
    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  );

  // ================= EXPAND TILE =================
  Widget _expandTile({
    required String title,
    required RxBool value,
    required String content,
  }) =>
      Obx(() => Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => value.toggle(),
              child: Row(
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600)),
                  const Spacer(),
                  Icon(value.value
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down),
                ],
              ),
            ),
            if (value.value) ...[
              const SizedBox(height: 10),
              Text(content,
                  style: const TextStyle(
                      fontSize: 13, color: Colors.grey)),
            ]
          ],
        ),
      ));

  // ================= REVIEW =================
  Widget _reviewSection() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text("Review",
          style:
          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
      const SizedBox(height: 8),
      Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 18),
                SizedBox(width: 4),
                Text("4.9 (345)",
                    style: TextStyle(fontWeight: FontWeight.w600)),
              ],
            ),
            SizedBox(height: 8),
            Text(
              "A Recliner Armchair is a comfortable adjustable chair designed for relaxation.",
              style: TextStyle(fontSize: 13),
            )
          ],
        ),
      )
    ],
  );

  // ================= TRENDING =================
  Widget _trendingSection() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: const [
          Text("Trending product",
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w600)),
          Spacer(),
          Text("View more",
              style: TextStyle(color: AppColors.primary)),
        ],
      ),
      const SizedBox(height: 12),
      SizedBox(
        height: 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          itemBuilder: (_, i) => Container(
            width: 140,
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Expanded(
                    child: Image.asset(
                        "assets/images/iphone.png")),
                const SizedBox(height: 6),
                const Text("\$699.00",
                    style: TextStyle(
                        fontWeight: FontWeight.w700)),
              ],
            ),
          ),
        ),
      )
    ],
  );

  // ================= BOTTOM =================
  Widget _bottomButtons() => Container(
    padding: const EdgeInsets.all(16),
    color: Colors.white,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          onPressed: () {
            Get.to(CheckoutPage());
            // GO TO CHECKOUT
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)),
            minimumSize: const Size(double.infinity, 50),
          ),
          child: const Text("Buy it now",style: TextStyle(color: Colors.white),),
        ),
        const SizedBox(height: 10),
        OutlinedButton(
          onPressed: () {
            Get.to(CheckoutPage());
          },
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)),
            minimumSize: const Size(double.infinity, 50),
          ),
          child: const Text("Add to Cart"),
        ),
      ],
    ),
  );
}
