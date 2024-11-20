import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raffaelosanzio/models/detail_product.dart';
import 'package:raffaelosanzio/pages/detailProduk.dart';

Widget productItem(BuildContext context, String name, String price,
    String imageUrl, String desc1, String desc2) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailProductPage(
            product: DetailProduct(
              name: name,
              price: price,
              imageUrl: imageUrl,
              description1: desc1,
              description2: desc2,
            ),
          ),
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
              child: Image.asset(imageUrl, fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(name,
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
                  price,
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
                  "4.8",
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
