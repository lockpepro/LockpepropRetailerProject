import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zlock_smart_finance/app/constants/app_colors.dart';
import 'package:zlock_smart_finance/modules/retailer/details%20/details_controller.dart';
import 'package:zlock_smart_finance/modules/retailer/details%20/details_page.dart';
import 'package:zlock_smart_finance/modules/retailer/upcoming_emi/upcoming_emi_controller.dart';

class UpcomingScreen extends StatelessWidget {
  UpcomingScreen({super.key});

  final UpcomingController c = Get.put(UpcomingController());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: AppColors.bgTopGradient,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back button
                Row(
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
                    SizedBox(width: 20,),
                    Text("Details",
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600,fontSize: 20),
                    ),

                  ],
                ),

                const SizedBox(height: 25),
                // Obx(
                //       () => ListView.builder(
                //         shrinkWrap: true, // ⭐ IMPORTANT
                //         physics: const NeverScrollableScrollPhysics(), // ⭐ IMPORTANT
                //         padding: EdgeInsets.zero,
                //     itemCount: c.upcomingList.length,
                //     itemBuilder: (_, index) {
                //       final item = c.upcomingList[index];
                //       return _upcomingCard(item);
                //     },
                //   ),
                // ),
                Obx(() {
                  if (c.isLoading.value && c.upcomingList.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (c.upcomingList.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Center(child: Text("No upcoming EMI found")),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: c.upcomingList.length,
                    itemBuilder: (_, index) {
                      final item = c.upcomingList[index];
                      return _upcomingCard(item);
                    },
                  );
                }),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _upcomingCard(UpcomingModel item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xffE6E9F0)),
      ),
      child: Column(
        children: [
          /// TOP ROW
          InkWell(
            onTap: () {
              // Get.to(DetailsScreen());
              Get.to(
                    () => DetailsScreen(),
                arguments: {
                  "keyId": item.keyId,
                  // "deviceId": item.,
                },
                binding: BindingsBuilder(() {
                  Get.create<DetailsController>(() => DetailsController());
                }),
              );

            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Key ID: ${item.keyId}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xff3A3A3A),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Due Date:',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xff7A7A7A),
                      ),
                    ),
                    Text(
                      item.dueDate,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),

          const Divider(height: 24),

          /// BOTTOM ROW
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Name:',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xff7A7A7A),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Amount:',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xff7A7A7A),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.amount,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff2E7D32),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
