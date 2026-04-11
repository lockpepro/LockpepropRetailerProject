import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zlock_smart_finance/app/constants/app_colors.dart';
import 'package:zlock_smart_finance/modules/retailer/b2b_order/views/order_details_page.dart';
import 'review_bottom_sheet.dart';

class OrderCard extends StatelessWidget {
  final Map<String, String> data;
  final bool completed;

  const OrderCard({
    super.key,
    required this.data,
    required this.completed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(OrderDetailsPage()),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                data['image']!,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['title']!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data['date']!,
                    style: TextStyle(
                      color: completed ? Colors.black : Colors.orange,
                      fontSize: 12,
                    ),
                  ),
                  if (completed)
                    GestureDetector(
                      onTap: () {
                        Get.bottomSheet(
                          const ReviewBottomSheet(),
                          isScrollControlled: true,
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(top: 6),
                        child: Text(
                          "Rate this product now",
                          style: TextStyle(
                            color: AppColors.primaryBlue,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}
