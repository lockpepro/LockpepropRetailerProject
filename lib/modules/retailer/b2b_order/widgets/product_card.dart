// lib/widgets/product_card.dart
import 'package:flutter/material.dart';
import 'package:zlock_smart_finance/app/constants/app_colors.dart';
import 'package:zlock_smart_finance/model/product_model.dart';
// class ProductCard extends StatelessWidget {
//   final ProductModel product;
//   final VoidCallback onTap;
//
//   const ProductCard({
//     super.key,
//     required this.product,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 14),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: const [
//           BoxShadow(
//             color: Color(0x11000000),
//             blurRadius: 10,
//             offset: Offset(0, 4),
//           )
//         ],
//       ),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(14),
//                 child: Image.asset(
//                   product.image,
//                   width: 70,
//                   height: 70,
//                   fit: BoxFit.contain,
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Column(
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text("\$${product.price.toStringAsFixed(2)}",
//                           style: const TextStyle(
//                               fontWeight: FontWeight.w700, fontSize: 16)),
//                       const SizedBox(height: 4),
//                       Text(product.name,
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                           style: const TextStyle(fontSize: 13)),
//
//                       Align(
//                         alignment: Alignment.bottomLeft,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             Container(
//                               padding: const EdgeInsets.all(6),
//                               decoration: BoxDecoration(
//                                 border: Border.all(color: AppColors.border),
//                                 shape: BoxShape.circle,
//                               ),
//                               child: const Icon(Icons.favorite_border, size: 18),
//                             ),
//                             const SizedBox(height: 10),
//                             ElevatedButton(
//                               onPressed: onTap,
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: AppColors.primary,
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10)),
//                                 padding:
//                                 const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
//                               ),
//                               child: const Text("Buy now",
//                                   style: TextStyle(fontSize: 12,color: Colors.white)),
//                             )
//                           ],
//                         ),
//                       )
//
//
//                     ],
//                   ),
//
//                 ],
//               ),
//             ],
//           ),
//
//         ],
//       ),
//     );
//   }
// }
class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// IMAGE
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(
              product.image,
              width: 72,
              height: 72,
              fit: BoxFit.cover,
            ),
          ),

          /// DIVIDER (exact like image)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            width: 1,
            height: 90,
            color: const Color(0xFFE5E7EB),
          ),

          /// RIGHT CONTENT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// PRICE
                Text(
                  "\$${product.price.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),

                /// TITLE
                Text(
                  product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.3,
                    color: Color(0xFF374151),
                  ),
                ),

                const SizedBox(height: 14),

                /// HEART + BUY NOW (BOTTOM RIGHT)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color(0xFFE5E7EB),
                        ),
                      ),
                      child: const Icon(
                        Icons.favorite_border,
                        size: 18,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      height: 34,
                      child: ElevatedButton(
                        onPressed: onTap,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                        ),
                        child: const Text(
                          "Buy now",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
