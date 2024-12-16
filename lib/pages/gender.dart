import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raffaelosanzio/api/product_api.dart';
import 'package:raffaelosanzio/models/hive/model.dart';
import 'package:raffaelosanzio/shared/theme.dart';
import 'package:raffaelosanzio/widget/product_item.dart';

class GenderPage extends StatefulWidget {
  const GenderPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GenderPageState createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gender Page'),
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Cowok(),
          Cewek(),
        ],
      ),
    );
  }
}

class Cowok extends StatefulWidget {
  const Cowok({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CowokState createState() => _CowokState();
}

class _CowokState extends State<Cowok> {
  bool _isLoading = true;
  List<Product> _manProducts = [];

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

      // Fetch products and filter by gender "man"
      final List<Product> products = await ProductApiHandler().getProducts();
      final filteredProducts =
          products.where((element) => element.gender == "M").toList();

      setState(() {
        _manProducts = filteredProducts;
        _isLoading = false;
      });
    } catch (e) {
      print("Error loading products: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<List<Product>> fetchProducts() async {
    // Implement your fetch logic here
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8.0), // Ukuran lingkaran
            child: Icon(
              Icons.arrow_back,
              color: blue600,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        surfaceTintColor: Colors.white,
        title: Text(
          "Man",
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _manProducts.isEmpty
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
                    _manProducts.length,
                    (index) {
                      final product = _manProducts[index];
                      return ProductItem(product: product.toJson());
                    },
                  ),
                ),
    );
  }
}

class Cewek extends StatefulWidget {
  const Cewek({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CewekState createState() => _CewekState();
}

class _CewekState extends State<Cewek> {
  bool _isLoading = true;
  // ignore: non_constant_identifier_names
  List<Product> _WomanProducts = [];

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

      // Fetch products and filter by gender "man"
      final List<Product> products = await ProductApiHandler().getProducts();
      final filteredProducts =
          products.where((element) => element.gender == "W").toList();

      setState(() {
        _WomanProducts = filteredProducts;
        _isLoading = false;
      });
    } catch (e) {
      print("Error loading products: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<List<Product>> fetchProducts() async {
    // Implement your fetch logic here
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        shadowColor: Colors.grey,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.arrow_back,
              color: blue600,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        surfaceTintColor: Colors.white,
        title: Text(
          "Woman",
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _WomanProducts.isEmpty
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
                    _WomanProducts.length,
                    (index) {
                      final product = _WomanProducts[index];
                      return ProductItem(product: product.toJson());
                    },
                  ),
                ),
    );
  }
}
