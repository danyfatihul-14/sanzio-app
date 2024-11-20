import 'package:equatable/equatable.dart';
import 'package:raffaelosanzio/models/detail_product.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddToCart extends CartEvent {
  final DetailProduct product;

  const AddToCart({required this.product});

  @override
  List<Object> get props => [product];
}

class RemoveFromCart extends CartEvent {
  final DetailProduct product;

  const RemoveFromCart({required this.product});

  @override
  List<Object> get props => [product];
}
