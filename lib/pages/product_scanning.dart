import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:raffaelosanzio/api/product_api.dart';
import 'package:raffaelosanzio/models/hive/model.dart';
import 'package:raffaelosanzio/shared/theme.dart';
import 'package:raffaelosanzio/widget/product_item.dart';

class ProductScanningPage extends StatefulWidget {
  const ProductScanningPage({super.key});

  @override
  State<ProductScanningPage> createState() => _ProductScanningPageState();
}

class _ProductScanningPageState extends State<ProductScanningPage> {
  List<Product> _products = [];
  bool _isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchProductsFromHive();
  }
  Future<void> _fetchProductsFromHive() async {
    List<Product> products = await ProductApiHandler().getProducts();
    setState(() {
      _products = products;
    });
    _isLoading = false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Product Scanning",
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: whiteMain,
        leading: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: SizedBox(
              width: 20,
              height: 20,
              child: Icon(
                IconsaxPlusBold.arrow_circle_left,
                color: blue400,
                size: 36,
              ),
            ),
          ),
        ),
      ),
      body: _buildPopularProductsSection(context),
    );
  }

  Widget _buildPopularProductsSection(BuildContext context) {
    List<Map<String, dynamic>> formattedProducts = [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height * 0.68), // Sesuaikan proporsi
          children: List.generate(formattedProducts.length, (index) {
            final product = formattedProducts[index];

            // Mengirimkan satu Map<String, dynamic> ke ProductItem
            return ProductItem(product: product);
          }),
        )
      ],
    );
  }
}