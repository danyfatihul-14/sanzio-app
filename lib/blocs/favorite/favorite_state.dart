import 'package:raffaelosanzio/models/hive/model.dart';

abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteUpdated extends FavoriteState {
  final List<Product> favoriteProducts;

  FavoriteUpdated(this.favoriteProducts);
}
