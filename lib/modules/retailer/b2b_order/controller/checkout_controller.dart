// lib/controllers/checkout_controller.dart
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  final quantity = 1.obs;
  final paymentMethod = "Credit card / Debit card".obs;

  double get itemPrice => 699.0;
  double get delivery => 5.0;

  double get total =>
      (itemPrice * quantity.value) + delivery;

  void increaseQty() => quantity.value++;
  void decreaseQty() {
    if (quantity.value > 1) quantity.value--;
  }
}
