import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raffaelosanzio/models/detail_product.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial());

  final List<DetailProduct> _cartProducts = [];

  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is AddToCart) {
      _cartProducts.add(event.product);
      double totalPrice = _cartProducts.fold(
          0, (sum, item) => sum + (double.parse(item.price) * item.quantity));
      yield CartUpdated(products: _cartProducts, totalPrice: totalPrice);
    } else if (event is RemoveFromCart) {
      _cartProducts.remove(event.product);
      double totalPrice = _cartProducts.fold(
          0, (sum, item) => sum + (double.parse(item.price) * item.quantity));
      yield CartUpdated(products: _cartProducts, totalPrice: totalPrice);
    }
  }
}
