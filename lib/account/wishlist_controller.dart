import 'package:get/get.dart';

class WishlistController extends GetxController {
  var wishlist = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();

    // Temporary static data for 6 cards
    wishlist.value = List.generate(6, (index) {
      return {
        "image": "assets/images/iphone.png",
        "title": "Apple Iphone 15 Pro 128GB",
        "subtitle": "Natural Titanium",
        "rating": 4.9,
        "reviews": 345,
        "price": 699.00,
        "oldPrice": 730.00,
        "discount": "10% off",
        "isFav": true,
      };
    });
  }

  void toggleFavorite(int index) {
    wishlist[index]["isFav"] = !wishlist[index]["isFav"];
    wishlist.refresh();
  }
}
