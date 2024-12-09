import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raffaelosanzio/blocs/favorite/favorite_event.dart';
import 'package:raffaelosanzio/blocs/favorite/favorite_state.dart';
import 'package:raffaelosanzio/models/hive/model.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final List<Product> _favoriteProducts = [];

  FavoriteBloc() : super(FavoriteInitial()) {
    on<ToggleFavoriteEvent>((event, emit) {
      if (_favoriteProducts.contains(event.product)) {
        _favoriteProducts.remove(event.product);
      } else {
        _favoriteProducts.add(event.product);
      }
      emit(FavoriteUpdated(List.from(_favoriteProducts)));
    });
  }
}