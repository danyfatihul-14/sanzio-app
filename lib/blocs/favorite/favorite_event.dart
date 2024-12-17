import 'package:equatable/equatable.dart';
import 'package:raffaelosanzio/models/hive/model.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();
  @override
  List<Object> get props => [];
}

class ToggleFavoriteEvent extends FavoriteEvent {
  final Product product;

  ToggleFavoriteEvent(this.product);

  List<Object> get props => [product];
}
