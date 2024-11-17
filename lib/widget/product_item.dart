import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raffaelosanzio/pages/detailProduk.dart';

Widget productItem(
    BuildContext context, String name, String price, String imagePath) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailProductPage(
            name: name,
            price: price,
            imagePath: imagePath,
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
            // Center the image
            child: SizedBox(
              height: 145, // You can adjust the height as needed
              child: Image.asset(imagePath, fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(name,
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 13, fontWeight: FontWeight.w500)),
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
                    fontSize: 10,
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
                  style: GoogleFonts.plusJakartaSans(fontSize: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
