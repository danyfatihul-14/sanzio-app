import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:raffaelosanzio/pages/detailProduk.dart';

class ProductItem extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman detail dengan membawa data produk
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailProductPage(product: product),
          ),
        );
      },
      child: Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.18, // Dinamis
              child: Image.asset(product['image'], fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(product['title'],
                style: GoogleFonts.plusJakartaSans(
                    fontSize:
                        MediaQuery.of(context).size.width * 0.035, // Dinamis
                    fontWeight: FontWeight.w500)),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                CircleAvatar(radius: 10, backgroundColor: Colors.grey),
                SizedBox(width: 4),
                CircleAvatar(radius: 10, backgroundColor: Colors.brown),
                SizedBox(width: 4),
                CircleAvatar(radius: 10, backgroundColor: Colors.black),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Rp${NumberFormat('#,###', 'id_ID').format(product['price'])}",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize:
                        MediaQuery.of(context).size.width * 0.03, // Dinamis
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.star,
                  color: Color(0xFFFFDD00),
                  size: 16,
                ),
                const SizedBox(width: 4.0),
                Text(
                  product['rating'].toString(),
                  style: GoogleFonts.plusJakartaSans(
                      fontSize:
                          MediaQuery.of(context).size.width * 0.03), // Dinamis
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    );
  }
}