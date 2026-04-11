// lib/views/checkout_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zlock_smart_finance/app/constants/app_colors.dart';
import 'package:zlock_smart_finance/modules/retailer/b2b_order/controller/checkout_controller.dart';
import 'package:zlock_smart_finance/modules/retailer/b2b_order/views/order_confirmed_page.dart';

class CheckoutPage extends StatelessWidget {
  CheckoutPage({super.key});

  final CheckoutController c =
  Get.put(CheckoutController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _appBar(),
              const SizedBox(height: 16),
              _storeCard(),
              const SizedBox(height: 16),
              _productCard(),
              const SizedBox(height: 16),
              _addressCard(),
              const SizedBox(height: 16),
              _paymentMethod(),
              const SizedBox(height: 16),
              _promoCard(),
              const SizedBox(height: 16),
              _summaryCard(),
              const SizedBox(height: 90),
            ],
          ),
        ),
      ),
      bottomSheet: _confirmBtn(),
    );
  }

  // ================= APP BAR =================
  Widget _appBar() => Row(
    children:  [
      InkWell(
        onTap: () => Get.back(),
          child: Icon(Icons.arrow_back)),
      SizedBox(width: 12),
      Text("Checkout",
          style:
          TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
      Spacer(),
      Icon(Icons.favorite_border),
    ],
  );

  // ================= STORE =================
  Widget _storeCard() => _card(
    Row(
      children: const [
        Icon(Icons.store, color: AppColors.primary),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            "Smartphone Official\n2900 Ritter Street, Huntsville, AL",
            style: TextStyle(fontSize: 13),
          ),
        ),
        Icon(Icons.chevron_right),
      ],
    ),
  );

  // ================= PRODUCT =================
  Widget _productCard() => _card(
    Row(
      children: [
        Image.asset("assets/images/iphone.png", height: 70),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Apple iPhone 15 Pro 128GB Natural Titanium",
                style:
                TextStyle(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 6),
              Text("\$699.00",
                  style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Obx(() => Row(
          children: [
            _qtyBtn(Icons.remove, c.decreaseQty),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 8),
              child: Text("${c.quantity.value}",
                  style: const TextStyle(
                      fontWeight: FontWeight.w600)),
            ),
            _qtyBtn(Icons.add, c.increaseQty),
          ],
        )),
      ],
    ),
  );

  // ================= ADDRESS =================
  Widget _addressCard() => _card(
    Row(
      children: const [
        Icon(Icons.location_on_outlined),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            "4387 Farland Avenue,\nSan Antonio, New York City TX 78212",
            style: TextStyle(fontSize: 13),
          ),
        ),
        Icon(Icons.chevron_right),
      ],
    ),
  );

  // ================= PAYMENT =================
  Widget _paymentMethod() => _card(
    Row(
      children: [
        Image.asset("assets/images/visa.png", height: 20),
        const SizedBox(width: 10),
        const Expanded(
          child: Text("Credit card / Debit card"),
        ),
        const Icon(Icons.chevron_right),
      ],
    ),
  );

  // ================= PROMO =================
  Widget _promoCard() => _card(
    Row(
      children: const [
        Icon(Icons.confirmation_num_outlined),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            "ORDERNOW\nGet promo 10% off",
            style: TextStyle(fontSize: 13),
          ),
        ),
        Icon(Icons.chevron_right),
      ],
    ),
  );

  // ================= SUMMARY =================
  Widget _summaryCard() => _card(
    Column(
      children: [
        _row("Item (${c.quantity.value}x)", "\$${c.itemPrice}"),
        _row("Delivery", "\$${c.delivery}"),
        const Divider(),
        Obx(() => _row(
            "Order total", "\$${c.total.toStringAsFixed(2)}",
            bold: true)),
      ],
    ),
  );

  // ================= CONFIRM =================
  Widget _confirmBtn() => Container(
    padding: const EdgeInsets.all(16),
    color: Colors.white,
    child: ElevatedButton(
      onPressed: () {
        Get.off(() => OrderConfirmedPage());
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)),
      ),
      child: const Text("Confirmation",style: TextStyle(color: Colors.white),),
    ),
  );

  // ================= HELPERS =================
  Widget _card(Widget child) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
    ),
    child: child,
  );

  Widget _row(String t1, String t2, {bool bold = false}) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Text(t1),
            const Spacer(),
            Text(
              t2,
              style:
              bold ? const TextStyle(fontWeight: FontWeight.w600) : null,
            ),
          ],
        ),
      );

  Widget _qtyBtn(IconData i, VoidCallback tap) =>
      GestureDetector(
        onTap: tap,
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(i, size: 14),
        ),
      );
}
