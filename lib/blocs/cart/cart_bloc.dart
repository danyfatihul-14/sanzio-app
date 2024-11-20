import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raffaelosanzio/models/cart.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    // Menangani event AddToCart
    on<AddToCart>((event, emit) {
      _cartItems.add(event.cartItem);

      double totalPrice =
          _cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));

      // Emit state keranjang yang diperbarui
      emit(CartUpdated(
          cartItems: List.from(_cartItems), totalPrice: totalPrice));
    });

    // Menangani event RemoveFromCart
    on<RemoveFromCart>((event, emit) {
      _cartItems
          .removeWhere((item) => item.detailProductId == event.detailProductId);

      double totalPrice =
          _cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));

      // Emit state keranjang yang diperbarui
      emit(CartUpdated(
          cartItems: List.from(_cartItems), totalPrice: totalPrice));
    });

  // Menangani event UpdateQuantityEvent
    on<UpdateQuantityEvent>((event, emit) {
      if (event.index >= 0 && event.index < _cartItems.length) {
        _cartItems[event.index].quantity = event.quantity;

        double totalPrice =
            _cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));

        // Emit state keranjang yang diperbarui
        emit(CartUpdated(
            cartItems: List.from(_cartItems), totalPrice: totalPrice));
      }
    });

    // Menangani event ToggleSelectEvent
    on<ToggleSelectEvent>((event, emit) {
      if (event.index >= 0 && event.index < _cartItems.length) {
        _cartItems[event.index].status = event.isSelected ? 'Selected' : 'In Cart';

        double totalPrice =
            _cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));

        // Emit state keranjang yang diperbarui
        emit(CartUpdated(
            cartItems: List.from(_cartItems), totalPrice: totalPrice));
      }
    });
  }

  final List<Cart> _cartItems = [];
}
