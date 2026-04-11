import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zlock_smart_finance/app/constants/app_colors.dart';
import 'package:zlock_smart_finance/modules/retailer/b2b_order/controller/my_order_controller.dart';

class ReviewBottomSheet extends StatelessWidget {
  const ReviewBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<MyOrderController>();

    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          left: 20,
          right: 20,
          top: 12,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Drag Handle
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: AppColors.borderGrey,
                borderRadius: BorderRadius.circular(8),
              ),
            ),

            /// Title
            const Text(
              "Leave a Review",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 20),
            _orderItemCard(),
            const SizedBox(height: 24),

            /// How is your order
            const Text(
              "How is your order?",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              "Please give your rating & also your review...",
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textGrey,
              ),
            ),

            const SizedBox(height: 20),
            _ratingStars(c),
            const SizedBox(height: 20),

            _reviewInput(c),
            const SizedBox(height: 24),

            _actionButtons(c),
          ],
        ),
      ),
    );
  }

  // ---------------- ORDER ITEM CARD ----------------

  Widget _orderItemCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.borderGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Items in Your Order",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Divider(height: 24),

          Row(
            children: [
              Stack(
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
                  Positioned(
                    top: 4,
                    left: 4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        "10% off",
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Apple Iphone 15 Pro 128GB Natural Titanium",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Electronics product",
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textGrey,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Quantity",
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textGrey,
                      ),
                    ),
                  ],
                ),
              ),

              const Text(
                "1",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------- STAR RATING ----------------

  Widget _ratingStars(MyOrderController c) {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(5, (index) {
          final selected = c.rating.value > index;
          return GestureDetector(
            onTap: () => c.rating.value = index + 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Icon(
                selected ? Icons.star : Icons.star_border,
                size: 34,
                color: selected
                    ? AppColors.starColor
                    : Colors.black,
              ),
            ),
          );
        }),
      );
    });
  }

  // ---------------- REVIEW INPUT ----------------

  Widget _reviewInput(MyOrderController c) {
    return TextField(
      controller: c.reviewController,
      maxLines: 1,
      decoration: InputDecoration(
        hintText: "Very good product & fast delivery!",
        suffixIcon: const Icon(Icons.image_outlined),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.black),
        ),
      ),
    );
  }

  // ---------------- ACTION BUTTONS ----------------

  Widget _actionButtons(MyOrderController c) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 54,
            decoration: BoxDecoration(
              color: AppColors.lightGrey,
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextButton(
              onPressed: () => Get.back(),
              child: const Text(
                "Cancel",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            height: 54,
            decoration: BoxDecoration(
              color: AppColors.primaryBlue,
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextButton(
              onPressed: c.submitReview,
              child: const Text(
                "Submit",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
