import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raffaelosanzio/blocs/cart/cart_hiveHandler.dart';
import 'package:raffaelosanzio/models/cart.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    // Menangani event AddToCart
    on<LoadCartFromHive>((event, emit) {
      if (_cartItems.isEmpty) {
        List<Cart> _cartHive = CartHivehandler().getCart();

        for (var cart in _cartHive) {
          _cartItems.add(cart);
        }

        emit(CartUpdated(cartItems: _cartItems));
      }
    });

    on<AddToCart>((event, emit) {
      if (_cartItems.isNotEmpty) {
        // Cek apakah item dengan `detailProductId` yang sama sudah ada
        final isExistingItem = _cartItems
            .where((item) =>
                item.detailProductId == event.cartItem.detailProductId)
            .isNotEmpty;

        if (isExistingItem) {
          // Jika item sudah ada, tambahkan quantity
          final existingItem = _cartItems.firstWhere(
            (item) => item.detailProductId == event.cartItem.detailProductId,
          );
          int quantity = existingItem.quantity;
          if ((quantity + event.cartItem.quantity) > existingItem.stock) {
            _cartItems
                .firstWhere(
                  (item) =>
                      item.detailProductId == event.cartItem.detailProductId,
                )
                .quantity = existingItem.stock;
          } else {
            _cartItems
                .firstWhere(
                  (item) =>
                      item.detailProductId == event.cartItem.detailProductId,
                )
                .quantity += event.cartItem.quantity;
          }
        } else {
          // Jika item belum ada, tambahkan item baru
          _cartItems.add(event.cartItem);
        }
      } else {
        // Jika keranjang kosong, tambahkan item baru
        _cartItems.add(event.cartItem);
      }

      // Emit state keranjang yang diperbarui
      emit(CartUpdated(cartItems: _cartItems));
      CartHivehandler().modifyCart(_cartItems);
    });

    // Menangani event RemoveFromCart
    on<RemoveFromCart>((event, emit) {
      _cartItems
          .removeWhere((item) => item.detailProductId == event.detailProductId);

      // Emit state keranjang yang diperbarui
      emit(CartUpdated(cartItems: List<Cart>.from(_cartItems)));
      CartHivehandler().modifyCart(_cartItems);
    });

    // Menangani event UpdateQuantityEvent
    on<UpdateQuantityEvent>((event, emit) {
      if (event.index >= 0 && event.index < _cartItems.length) {
        _cartItems[event.index].quantity = event.quantity;

        // Emit state keranjang yang diperbarui
        emit(CartUpdated(cartItems: List.from(_cartItems)));
        CartHivehandler().modifyCart(_cartItems);
      }
    });

    // Menangani event ToggleSelectEvent
    on<ToggleSelectEvent>((event, emit) {
      if (event.index >= 0 && event.index < _cartItems.length) {
        _cartItems[event.index].status =
            event.isSelected ? 'Selected' : 'In Cart';

        // Emit state keranjang yang diperbarui
        emit(CartUpdated(cartItems: List.from(_cartItems)));
        CartHivehandler().modifyCart(_cartItems);
      }
    });
  }

  final List<Cart> _cartItems = [];
}
