import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:raffaelosanzio/models/hive/model.dart';
import 'package:raffaelosanzio/pages/detailProduk.dart';
import 'package:raffaelosanzio/shared/theme.dart';

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
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: whiteMain,
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.18, // Dinamis
                  child: Hero(
                    tag: product[
                        'id'], // Pastikan tag ini unik untuk setiap produk
                    child: Image.network(product['image'], fit: BoxFit.cover),
                    flightShuttleBuilder: (flightContext, animation, direction,
                        fromContext, toContext) {
                      return ScaleTransition(
                        scale: animation.drive(
                          CurveTween(
                              curve: const Interval(0.0, 1.0,
                                  curve: Curves.easeInOut)),
                        ),
                        child:
                            Image.network(product['image'], fit: BoxFit.cover),
                      );
                    },
                  ),
                ),
              ),
              Text(
                product['title'],
                style: GoogleFonts.plusJakartaSans(
                  fontSize: MediaQuery.of(context).size.width * 0.04, // Dinamis
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
                Row(
                children: product['skin_type'].take(5).map<Widget>((details) {
                  String color = SkinType.numToHexcode(details['skin_type']);
                  int hexColor = int.parse('FF$color', radix: 16);
                  return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Color(hexColor),
                  ),
                  );
                }).toList(), // Convert the iterable into a List<Widget>
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Rp${NumberFormat('#,###', 'id_ID').format(product['price'])}",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize:
                          MediaQuery.of(context).size.width * 0.035, // Dinamis
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.star,
                    color: const Color(0xFFFFDD00),
                    size: MediaQuery.of(context).size.width * 0.045,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    product['rating'].toString(),
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: MediaQuery.of(context).size.width * 0.0325,
                    ), // Dinamis
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
