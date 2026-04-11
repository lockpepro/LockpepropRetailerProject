import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zlock_smart_finance/modules/retailer/b2b_order/controller/order_details_controller.dart';
import 'package:zlock_smart_finance/modules/retailer/b2b_order/views/product_list_page.dart';

import 'live_tracking_page.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(OrderDetailsController());

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Order Details",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: Get.back,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _orderCard(c),
            const SizedBox(height: 16),
            _shippingCard(c),
            const SizedBox(height: 16),
            _orderSummary(),
            const SizedBox(height: 16),
            _priceDetails(),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4865F6),
            minimumSize: const Size(double.infinity, 56),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
          onPressed: () => Get.offAll(ProductListPage()),
          child: const Text(
            "Continue Shopping",
            style: TextStyle(fontSize: 16,color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _orderCard(OrderDetailsController c) {
    return _card(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Order ID: ${c.orderId}",
              style:
              const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
          const Divider(height: 24),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset(
                  "assets/images/my_order.png",
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Apple Iphone 15 Pro 128GB Natural Titanium",
                      style:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "Arriving on 19th Nov 2025",
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ],
      ),
    );
  }

  Widget _shippingCard(OrderDetailsController c) {
    return _card(
      Column(
        children: [
          Row(
            children: [
              const Text(
                "Shipped",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => Get.to(() => const LiveTrackingPage()),
                child: const Text(
                  "Track Live Status",
                  style: TextStyle(
                    color: Color(0xFF4865F6),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            "Nov 23: Product has left the location facility.",
            style: TextStyle(fontSize: 13, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          _trackingIcons(),
        ],
      ),
    );
  }

  Widget _trackingIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        _TrackIcon(icon: Icons.inventory, active: true),
        _TrackIcon(icon: Icons.local_shipping, active: true),
        _TrackIcon(icon: Icons.people, active: false),
        _TrackIcon(icon: Icons.inventory_2, active: false),
      ],
    );
  }

  Widget _orderSummary() {
    return _card(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _row("Order ID", "#1234-456-759"),
          _row("Date Placed", "12/June/2025"),
          _row("Payment Method", "Visa ending in 1234"),
          Divider(height: 24),
          _rowBold("Order Total", "\$142.50"),
        ],
      ),
    );
  }

  Widget _priceDetails() {
    return _card(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _row("Listing Price", "\$149"),
          _row("Selling Price", "\$109"),
          _rowDiscount("Other Discount", "-\$40"),
          Divider(height: 24),
          _rowBold("Order Total", "\$109"),
          SizedBox(height: 8),
          _pill("Payment Method", "UPI — Google Pay (Paid)"),
        ],
      ),
    );
  }

  Widget _card(Widget child) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }
}

class _TrackIcon extends StatelessWidget {
  final IconData icon;
  final bool active;

  const _TrackIcon({required this.icon, required this.active});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 32,
          color: active ? Colors.green : Colors.grey,
        ),
        const SizedBox(height: 6),
        Icon(
          Icons.check_circle,
          size: 18,
          color: active ? Colors.green : Colors.grey,
        ),
      ],
    );
  }
}

class _row extends StatelessWidget {
  final String l, r;
  const _row(this.l, this.r);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(l, style: const TextStyle(color: Colors.grey)),
          const Spacer(),
          Text(r),
        ],
      ),
    );
  }
}

class _rowBold extends StatelessWidget {
  final String l, r;
  const _rowBold(this.l, this.r);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(l, style: const TextStyle(fontWeight: FontWeight.w600)),
        const Spacer(),
        Text(r,
            style: const TextStyle(
                fontWeight: FontWeight.w700, fontSize: 16)),
      ],
    );
  }
}

class _rowDiscount extends StatelessWidget {
  final String l, r;
  const _rowDiscount(this.l, this.r);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(l),
        const Spacer(),
        Text(r, style: const TextStyle(color: Colors.green)),
      ],
    );
  }
}

class _pill extends StatelessWidget {
  final String l, r;
  const _pill(this.l, this.r);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F2F2),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Text(l),
          const Spacer(),
          Text(r, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
