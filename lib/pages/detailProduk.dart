import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raffaelosanzio/blocs/cart/cart_bloc.dart';
import 'package:raffaelosanzio/blocs/cart/cart_event.dart';
import 'package:raffaelosanzio/models/detail_product.dart';
import 'package:raffaelosanzio/shared/theme.dart';

class DetailProductPage extends StatefulWidget {
  final DetailProduct product;

  const DetailProductPage({super.key, required this.product});

  @override
  // ignore: library_private_types_in_public_api
  _DetailProductPageState createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  String selectedSize = 'S'; // Default size selection

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 40, left: 16.0, right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Center(
                  child: Image.asset(
                    widget.product
                        .imageUrl, // Menggunakan imagePath dari parameter
                    height: 300,
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.grey),
                      onPressed: () {
                        Navigator.pop(context); // Back button
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(backgroundColor: Colors.grey, radius: 5),
                SizedBox(width: 8),
                CircleAvatar(backgroundColor: Colors.brown, radius: 5),
                SizedBox(width: 8),
                CircleAvatar(backgroundColor: Colors.blueGrey, radius: 5),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  widget.product.price, // Menggunakan price dari parameter
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w400),
                ),
                const Spacer(),
                const Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 20),
                    SizedBox(width: 2),
                    Text(
                      '4.8',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              widget.product.name, // Menggunakan name dari parameter
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              widget.product.description1,
              textAlign: TextAlign.left,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 8),
            const Text(
              'Select Size',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: ['S', 'M', 'L', 'XL', 'XXL'].map((size) {
                return ChoiceChip(
                  label: Text(size),
                  selectedColor: blue600,
                  labelStyle: selectedSize == size
                      ? TextStyle(color: whiteMain)
                      : TextStyle(color: gray800),
                  selected: selectedSize == size,
                  checkmarkColor: whiteMain,
                  onSelected: (bool selected) {
                    if (selected) {
                      setState(() {
                        selectedSize = size;
                      });
                    }
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            const Text(
              'Description',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              widget.product.description2,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFA5D1FE),
                      Color(0xFFCDB4DB),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: const EdgeInsets.all(1),
                child: OutlinedButton(
                  onPressed: () {
                    // Mengirimkan event AddToCart ke CartBloc
                    BlocProvider.of<CartBloc>(context).add(
                      AddToCart(
                        product: widget.product.copyWith(
                          size: selectedSize, // Tambahkan ukuran yang dipilih
                        ),
                      ),
                    );

                    // Tampilkan notifikasi
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content:
                              Text('${widget.product.name} added to cart!')),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: whiteMain, // Warna latar belakang tombol
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    side: BorderSide.none, // Hilangkan garis pembatas
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart,
                        color: Color(0xFF8AA1D3),
                        size: 16.0,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'ADD TO CART',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8AA1D3), // Warna teks
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4F72BD),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'BUY',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFFFFFFF),
                    letterSpacing: 1.2, // Menambahkan spasi antar huruf
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
