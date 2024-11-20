import 'package:equatable/equatable.dart';
import 'package:raffaelosanzio/models/detail_product.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartUpdated extends CartState {
  final List<DetailProduct> products;
  final double totalPrice;

  const CartUpdated({required this.products, required this.totalPrice});

  @override
  List<Object> get props => [products, totalPrice];
}
