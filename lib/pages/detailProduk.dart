import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailProductPage extends StatefulWidget {
  final String name;
  final String price;
  final String imagePath;

  const DetailProductPage({
    Key? key,
    required this.name,
    required this.price,
    required this.imagePath,
  }) : super(key: key);

  @override
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
                    widget.imagePath, // Menggunakan imagePath dari parameter
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
                  widget.price, // Menggunakan price dari parameter
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
              widget.name, // Menggunakan name dari parameter
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'Long established fact that a reader will be distracted by the readable',
              textAlign: TextAlign.left,
              style: TextStyle(color: Colors.grey),
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
                  selected: selectedSize == size,
                  onSelected: (bool selected) {
                    setState(() {
                      selectedSize = size;
                    });
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
            const Text(
              'Jaket bomber adalah jenis jaket yang memiliki desain khas dengan bagian depan yang dapat dibuka (zipper) dan sering kali dilengkapi dengan ribbed cuffs (pergelangan tangan) dan hem (bagian bawah). Awalnya, jaket ini dirancang untuk para pilot pesawat tempur selama Perang Dunia II, namun kini telah menjadi fashion staple yang populer di kalangan pria dan wanita.',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    width: 2, // Adjust the width of the border
                    color:
                        Colors.transparent, // Make the inner border transparent
                  ),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFA5D1FE),
                      Color(0xFFCDB4DB),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: const EdgeInsets.all(
                    1), // Padding to create space for the gradient border
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors
                        .white, // Set the button background to the specified blue color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    side: const BorderSide(
                        color: Colors
                            .transparent), // No border on the button itself
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_cart,
                          color:
                              Color(0xFF8AA1D3)), // Set the icon color to white
                      SizedBox(width: 8),
                      Text(
                        'ADD TO CART',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color:
                              Color(0xFF8AA1D3), // Set the text color to white
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
                    fontSize: 18,
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
