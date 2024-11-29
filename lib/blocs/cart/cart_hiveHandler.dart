import 'package:hive/hive.dart';
import 'package:raffaelosanzio/models/cart.dart';
import 'package:raffaelosanzio/models/hive/model.dart';

class CartHivehandler {
  void modifyCart(List<Cart> cart) {
    var box = Hive.box('Cart');
    List<CartHive> _carts = [];
    for (var item in cart) {
      _carts.add(CartHive(
        detailProductId: item.detailProductId,
        title: item.title,
        price: item.price,
        size: item.size,
        imageUrl: item.imageUrl,
        quantity: item.quantity,
        isSelected: item.isSelected,
        status: item.status,
        stock: item.stock,
      ));
    }
    box.put(1, _carts);
  }

  List<Cart> getCart() {
    var box = Hive.box('Cart');
    List<CartHive> _carts = box.get(1).cast<CartHive>();
    if (_carts.isEmpty) {
      print("Kosong");
      return [];
    }
    print("Isi");
    List<Cart> carts = [];
    for (var item in _carts) {
      carts.add(Cart(
        detailProductId: item.detailProductId,
        title: item.title,
        price: item.price,
        size: item.size,
        imageUrl: item.imageUrl,
        quantity: item.quantity,
        isSelected: item.isSelected,
        status: item.status,
        stock: item.stock,
      ));
    }
    return carts;
  }
}
