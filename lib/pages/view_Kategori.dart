import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raffaelosanzio/widget/product_item.dart';

class CategoryProductPage extends StatelessWidget {
  final String categoryTitle;
  final List<Map<String, String>> products;

  const CategoryProductPage({
    super.key,
    required this.categoryTitle,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     categoryTitle,
      //     style: GoogleFonts.plusJakartaSans(
      //       fontSize: 18,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      // ),
      // body: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       const SizedBox(height: 8.0),
      //       Expanded(
      //         child: GridView.count(
      //           crossAxisCount: 2,
      //           crossAxisSpacing: 8,
      //           mainAxisSpacing: 8,
      //           childAspectRatio: MediaQuery.of(context).size.width /
      //               (MediaQuery.of(context).size.height * 0.66),
      //           children: products.map((product) {
      //             return productItem(
      //               context,
      //               product['title'] ?? 'Unknown',
      //               product['price'] ?? 'Unknown',
      //               product['image'] ?? '',
      //               product['desc1'] ?? '',
      //               product['desc2'] ?? '',
      //             );
      //           }).toList(),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
