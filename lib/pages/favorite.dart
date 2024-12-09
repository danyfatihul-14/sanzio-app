import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raffaelosanzio/blocs/favorite/favorite_bloc.dart';
import 'package:raffaelosanzio/blocs/favorite/favorite_state.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorite Products')),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteUpdated) {
            if (state.favoriteProducts.isEmpty) {
              return const Center(child: Text('No favorite products yet.'));
            }
            return ListView.builder(
              itemCount: state.favoriteProducts.length,
              itemBuilder: (context, index) {
                final product = state.favoriteProducts[index];
                return ListTile(
                  leading: Image.network(product.imageUrl, width: 50),
                  title: Text(product.title),
                  subtitle: Text(product.subtitle),
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
