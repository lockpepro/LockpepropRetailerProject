// lib/controllers/product_controller.dart
import 'package:get/get.dart';
import 'package:zlock_smart_finance/model/product_model.dart';

class ProductController extends GetxController {
  final search = ''.obs;

  final products = <ProductModel>[
    ProductModel(
      id: '1',
      name: 'GoPro HERO6 4K Action Camera - Black',
      image: 'assets/images/gopro.png',
      price: 99.50,
      desc: 'Action Camera',
    ),
    ProductModel(
      id: '2',
      name: 'Sport Smart Watch Bracelet Waterproof',
      image: 'assets/images/watch.png',
      price: 99.50,
      desc: 'Smart Watch',
    ),
    ProductModel(
      id: '3',
      name: 'T-shirt blue cotton',
      image: 'assets/images/shirt.png',
      price: 99.50,
      desc: 'Cotton T-shirt',
    ),
    ProductModel(
      id: '4',
      name: 'Apple iPhone 12 Pro 6.1 RAM 6GB 512GB',
      image: 'assets/images/iphone.png',
      price: 99.50,
      desc: 'iPhone',
    ),
  ].obs;

  List<ProductModel> get filteredList {
    if (search.value.isEmpty) return products;
    return products
        .where((e) =>
        e.name.toLowerCase().contains(search.value.toLowerCase()))
        .toList();
  }
}
