// lib/controllers/product_detail_controller.dart
import 'package:get/get.dart';

class ProductDetailController extends GetxController {
  final isFav = false.obs;
  final showDesc = true.obs;
  final showDetails = false.obs;

  void toggleFav() => isFav.toggle();
}
