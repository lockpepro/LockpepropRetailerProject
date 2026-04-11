import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:zlock_smart_finance/modules/retailer/b2b_order/controller/order_details_controller.dart';

class LiveTrackingPage extends StatelessWidget {
  const LiveTrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<OrderDetailsController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: Get.back,
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: c.trackingSteps.length,
        itemBuilder: (_, i) {
          final step = c.trackingSteps[i];
          return _timelineTile(step, i == c.trackingSteps.length - 1);
        },
      ),
    );
  }

  Widget _timelineTile(TrackingStep step, bool isLast) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(
              Icons.radio_button_checked,
              color: step.isCompleted ? Colors.green : Colors.grey,
              size: 22,
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 60,
                color: step.isCompleted ? Colors.green : Colors.grey,
              ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        step.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                    ),
                    if (step.time.isNotEmpty)
                      Text(
                        step.time,
                        style:
                        const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  step.desc,
                  style:
                  const TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
