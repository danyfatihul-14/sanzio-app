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
  final double totalPrice;

  CartUpdated({required this.cartItems, required this.totalPrice});
}
