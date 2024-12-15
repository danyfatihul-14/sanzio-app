import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raffaelosanzio/api/product_api.dart';
import 'package:raffaelosanzio/models/hive/model.dart';
import 'package:raffaelosanzio/shared/theme.dart';
import 'package:raffaelosanzio/widget/product_item.dart';

class FYPPage extends StatefulWidget {
  const FYPPage({super.key});

  @override
  _FYPPageState createState() => _FYPPageState();
}

class _FYPPageState extends State<FYPPage> {
  bool _isLoading = true;
  List<Product> _fypProducts = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      setState(() {
        _isLoading = true;
      });

      // Memanggil API untuk mendapatkan produk
      final List<Product> products = await ProductApiHandler().getProducts();

      // Acak urutan produk
      products.shuffle(Random());

      setState(() {
        _fypProducts = products;
        _isLoading = false;
      });
    } catch (e) {
      print("Error loading FYP data: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gray50,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: whiteMain,
        surfaceTintColor: whiteMain,
        title: Text(
          "For You Page",
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _fypProducts.isEmpty
              ? const Center(
                  child: Text(
                    "No products available",
                    style: TextStyle(fontSize: 16),
                  ),
                )
              : GridView.count(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  crossAxisCount: 2,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height * 0.7),
                  children: List.generate(
                    _fypProducts.length,
                    (index) {
                      final product = _fypProducts[index];
                      return ProductItem(product: product.toJson());
                    },
                  ),
                ),
    );
  }
}
