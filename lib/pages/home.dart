import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:raffaelosanzio/widget/bottom_navbar.dart';
import 'package:raffaelosanzio/widget/product_item.dart'; // Import widget

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              filled: true,
              fillColor: Colors.grey[200],
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Banner Carousel Slider
              SizedBox(
                height: 180,
                child: CarouselSlider(
                  items: [
                    Image.asset('assets/slidebar1.png', fit: BoxFit.cover),
                    Image.asset('assets/slidebar1.png', fit: BoxFit.cover),
                    Image.asset('assets/slidebar1.png', fit: BoxFit.cover),
                  ],
                  options: CarouselOptions(
                    height: 180.0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    viewportFraction: 1.0,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),

              // Categories Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Categories",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/allKategori');
                    },
                    child: Text(
                      "See All",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        color: const Color(0xFF4F72BD),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              // Usage
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    categoryItem("T-Shirts", 'assets/T-Shirt.png'),
                    categoryItem("Kemeja", 'assets/Kemeja.png'),
                    categoryItem("Blouse", 'assets/Blouse.png'),
                    categoryItem("Dress", 'assets/Dress.png'),
                    categoryItem("Jacket", 'assets/Jacket.png'),
                    categoryItem("Hoodie", 'assets/Hoodie.png'),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),

              // Popular Products Section
              Text("Popular Products",
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8.0),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 0.75,
                children: [
                  productItem(context, "Jacket Bomber", "Rp 150.000", "assets/Jacket Bomber.png"),
                  productItem(context, "Daster", "Rp 150.000", "assets/Daster.png"),
                  productItem(context, "Tank Top", "Rp 100.000", "assets/Tanktop.png"),
                  productItem(context, "Batik Shirt", "Rp 250.000", "assets/Batik.png"),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const ScanButton(),
      bottomNavigationBar: const CustomBottomNavbar(),
    );
  }

  // Function to create a category item with an image
  Widget categoryItem(String title, String imagePath) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 60,
          height: 60,
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(title, style: GoogleFonts.plusJakartaSans(fontSize: 12)),
      ],
    );
  }
}
