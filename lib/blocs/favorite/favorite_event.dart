import 'package:raffaelosanzio/models/hive/model.dart';

abstract class FavoriteEvent {}

class ToggleFavoriteEvent extends FavoriteEvent {
  final Product product;

  ToggleFavoriteEvent(this.product);
}
