import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raffaelosanzio/blocs/favorite/favorite_bloc.dart';
import 'package:raffaelosanzio/blocs/favorite/favorite_state.dart';
import 'package:raffaelosanzio/shared/theme.dart';
import 'package:raffaelosanzio/widget/product_item.dart';

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
      backgroundColor: gray50,
      appBar: AppBar(
        title: const Text('Favorite Products'),
        backgroundColor: whiteMain,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8.0), // Ukuran lingkaran
            decoration: const BoxDecoration(
              color: Colors.white, // Warna latar belakang lingkaran
              shape: BoxShape.circle, // Bentuk lingkaran
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  spreadRadius: -2,
                ),
              ],
            ),
            child: Icon(
              Icons.arrow_back,
              color: blue600,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteUpdated) {
            if (state.favoriteProducts.isEmpty) {
              return _emptyData();
            }
            return Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                ),
                itemCount: state.favoriteProducts.length,
                itemBuilder: (context, index) {
                  final product = state.favoriteProducts[index];

                  return ProductItem(product: product.toJson());
                },
              ),
            );
          }
          return _emptyData();
        },
      ),
    );
  }

  Widget _emptyData() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icon 2.png',
            width: 250,
            height: 250,
          ),
          const SizedBox(height: 16),
          const Text(
            "Favorite is Empty",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
