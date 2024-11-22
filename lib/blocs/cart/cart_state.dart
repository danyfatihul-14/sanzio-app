import 'package:equatable/equatable.dart';
import 'package:raffaelosanzio/models/cart.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartUpdated extends CartState {
  final List<Cart> cartItems;

  const CartUpdated({required this.cartItems});

  int get totalPrice =>
      cartItems
          .where((item) => item.status == 'Selected')
          .map((item) => item.price * item.quantity)
          .fold(0, (value, element) => value + element) |
      0;
}
