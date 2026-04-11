import 'package:get/get.dart';

class OrderDetailsController extends GetxController {
  final orderId = "#CDX49302";
  final arrivingDate = "Arriving on 19th Nov 2025";

  final trackingSteps = [
    TrackingStep(
      title: "The shipment has been made by the sender.",
      desc:
      "The tracking number has been created and the package is awaiting collection.",
      time: "31 Aug, 08:23 PM",
      isCompleted: true,
    ),
    TrackingStep(
      title: "The package has been picked up by the delivery courier.",
      desc: "The courier has received the package from the sender.",
      time: "31 Aug, 09:03 PM",
      isCompleted: true,
    ),
    TrackingStep(
      title: "The package has arrived at the main distribution centre.",
      desc:
      "The package has been received at the sorting centre and is awaiting the next process.",
      time: "31 Aug, 11:40 PM",
      isCompleted: true,
    ),
    TrackingStep(
      title: "The package has left the distribution centre.",
      desc: "The package is on its way to the destination city.",
      time: "01 Sep, 05:03 AM",
      isCompleted: true,
    ),
    TrackingStep(
      title: "Out For Delivery",
      desc: "Item yet to be delivered.",
      time: "",
      isCompleted: false,
    ),
    TrackingStep(
      title: "Delivery Expected by Thu 27th Nov",
      desc: "Item yet to be delivered.",
      time: "",
      isCompleted: false,
    ),
  ];
}

class TrackingStep {
  final String title;
  final String desc;
  final String time;
  final bool isCompleted;

  TrackingStep({
    required this.title,
    required this.desc,
    required this.time,
    required this.isCompleted,
  });
}
