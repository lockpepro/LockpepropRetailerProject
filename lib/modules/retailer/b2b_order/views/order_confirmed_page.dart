// lib/views/order_confirmed_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zlock_smart_finance/app/constants/app_colors.dart';
import 'package:zlock_smart_finance/modules/retailer/b2b_order/views/product_list_page.dart';

class OrderConfirmedPage extends StatelessWidget {
  const OrderConfirmedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _appBar(),
              const SizedBox(height: 40),

              /// SUCCESS ICON
              Container(
                height: 120,
                width: 120,
                decoration: const BoxDecoration(
                  color: Color(0xff4CAF50),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check,
                    size: 60, color: Colors.white),
              ),

              const SizedBox(height: 24),
              const Text(
                "Thank You! Your order is\nconfirmed.",
                textAlign: TextAlign.center,
                style:
                TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 8),
              const Text(
                "We've sent a confirmation to your email",
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 24),
              _summaryCard(),

              const SizedBox(height: 20),
              _trackingCard(),

              const Spacer(),
              _continueBtn(),
            ],
          ),
        ),
      ),
    );
  }

  // ================= APP BAR =================
  Widget _appBar() => Row(
    children:  [
      InkWell(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back)),
      Spacer(),
      Icon(Icons.favorite_border),
    ],
  );

  // ================= SUMMARY =================
  Widget _summaryCard() => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Text("Order Summary",
                style:
                TextStyle(fontWeight: FontWeight.w600)),
            Spacer(),
            Text("View Invoice",
                style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 13)),
          ],
        ),
        const Divider(height: 24),
        _row("Order ID", "#1234-456-759"),
        _row("Date Placed", "12/June/2025"),
        _row("Payment Method", "Visa ending in 1234"),
        const Divider(height: 24),
        _row("Order Total", "\$142.50", bold: true),
      ],
    ),
  );

  // ================= TRACKING =================
  Widget _trackingCard() => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Text("Order Tracking",
                style:
                TextStyle(fontWeight: FontWeight.w600)),
            Spacer(),
            Text("Track Live Status",
                style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 13)),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            4,
                (i) => Column(
              children: [
                Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    color: i == 0
                        ? const Color(0xff4CAF50)
                        : Colors.grey.shade300,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    i == 0 ? Icons.check : Icons.local_shipping,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                const Icon(Icons.more_horiz, size: 14),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  // ================= BUTTON =================
  Widget _continueBtn() => ElevatedButton(
    onPressed: () {
      Get.offAll(() =>  ProductListPage());

    },
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      minimumSize: const Size(double.infinity, 52),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)),
    ),
    child: const Text("Continue Shopping",style: TextStyle(color: Colors.white),),
  );

  // ================= HELPER =================
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
}
