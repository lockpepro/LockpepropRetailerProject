import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zlock_smart_finance/app/constants/app_colors.dart';
import 'wishlist_controller.dart';

class WishlistPage extends StatelessWidget {
  final WishlistController c = Get.put(WishlistController());

  WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          _header(),

          const SizedBox(height: 10),

          Obx(() => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "${c.wishlist.length} item wishlist product",
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black87,
              ),
            ),
          )),

          const SizedBox(height: 15),

          Expanded(
            child: Obx(
                  () => GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                itemCount: c.wishlist.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 0.64,
                ),
                itemBuilder: (context, index) {
                  final item = c.wishlist[index];
                  return _wishlistCard(item, index);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- HEADER ----------------
  Widget _header() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
      decoration: const BoxDecoration(
        gradient: AppColors.bgTopGradient,
      ),

      child: Row(
        children: [

          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF2F4FA),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_back, size: 18),
            ),
          ),

          const SizedBox(width: 12),
          const Text(
            "Wishlist product",
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- CARD ----------------
  Widget _wishlistCard(Map item, int index) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffF8F9FB),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image + Heart Icon + Discount Badge
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  item["image"],
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              // Discount badge
              if (item["discount"] != null)
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xffFF5C5C),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      item["discount"],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

              // Heart (favorite)
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: () => c.toggleFavorite(index),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.95),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      item["isFav"]
                          ? Icons.favorite
                          : Icons.favorite_border_outlined,
                      color: item["isFav"] ? Colors.red : Colors.black87,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Rating Row
          Row(
            children: [
              Icon(Icons.star, size: 14, color: Colors.amber),

              const SizedBox(width: 4),
              Text(
                "${item["rating"]}",
                style:
                const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: 5),
              Text(
                "(${item["reviews"]})",
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Title
          Text(
            item["title"],
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 3),

          // Subtitle
          Text(
            item["subtitle"],
            style: const TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 10),

          // Price Row
          Row(
            children: [
              Text(
                "\$${item["price"]}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(width: 8),

              Text(
                "\$${item["oldPrice"]}",
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.red,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
