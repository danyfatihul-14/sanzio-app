import 'package:equatable/equatable.dart';
import 'package:raffaelosanzio/models/cart.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class LoadCartFromHive extends CartEvent {}

class AddToCart extends CartEvent {
  final Cart cartItem;

  const AddToCart({required this.cartItem});

  @override
  List<Object> get props => [cartItem];
}

class RemoveFromCart extends CartEvent {
  final int detailProductId;

  const RemoveFromCart({required this.detailProductId});

  @override
  List<Object> get props => [detailProductId];
}

class UpdateQuantityEvent extends CartEvent {
  final int index;
  final int quantity;
  const UpdateQuantityEvent(this.index, this.quantity);
}

class ToggleSelectEvent extends CartEvent {
  final int index;
  final bool isSelected;
  const ToggleSelectEvent(this.index, this.isSelected);
}