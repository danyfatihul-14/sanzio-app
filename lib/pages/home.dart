import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raffaelosanzio/pages/all_Kategori.dart';
import 'package:raffaelosanzio/pages/view_Kategori.dart';
import 'package:raffaelosanzio/widget/product_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  // Define the products for each category
  final Map<String, List<Map<String, String>>> products = {
    "T-Shirt": [
      {
        "title": "T-Shirt Classic",
        "price": "Rp 100.000",
        "image": "assets/T-Shirt.png"
      },
      {
        "title": "T-Shirt Modern",
        "price": "Rp 120.000",
        "image": "assets/T-Shirt.png"
      },
    ],
    "Jacket": [
      {
        "title": "Jacket Bomber",
        "price": "Rp 150.000",
        "image": "assets/Jacket.png"
      },
      {
        "title": "Jacket Leather",
        "price": "Rp 250.000",
        "image": "assets/Jacket.png"
      },
    ],
    // Add other categories as needed
  };

  final List<Map<String, String>> categories = [
    {"title": "T-Shirt", "image": "assets/T-Shirt.png"},
    {"title": "Jacket", "image": "assets/Jacket.png"},
    {"title": "Blouse", "image": "assets/Blouse.png"},
    {"title": "Dress", "image": "assets/Dress.png"},
    {"title": "Hoodie", "image": "assets/Hoodie.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCarouselSlider(),
              _buildDotsIndicator(),
              const SizedBox(height: 16.0),
              _buildCategoriesSection(context),
              const SizedBox(height: 16.0),
              _buildPopularProductsSection(context),
            ],
          ),
        ),
      ),
    );
  }

  // AppBar with search field and cart icon
  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        child: _buildSearchField(),
      ),
      actions: [_buildCartIcon()],
      toolbarHeight: 50,
    );
  }

  // Carousel Slider for banners
  Widget _buildCarouselSlider() {
    return SizedBox(
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
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          viewportFraction: 1.0,
          onPageChanged: (index, reason) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }

  // Dots indicator for the carousel
  Widget _buildDotsIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return Container(
          width: 8.0,
          height: 8.0,
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentIndex == index ? Colors.blue : Colors.grey,
          ),
        );
      }),
    );
  }

  // Categories section
  Widget _buildCategoriesSection(BuildContext context) {
    return Column(
      children: [
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AllCategoriesPage(categories: categories),
                  ),
                );
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
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return categoryItem(
                categories[index]['title']!,
                categories[index]['image']!,
              );
            },
          ),
        ),
      ],
    );
  }

  // Popular Products section
  Widget _buildPopularProductsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            productItem(context, "Jacket Bomber", "Rp 150.000",
                "assets/Jacket Bomber.png"),
            productItem(context, "Daster", "Rp 150.000", "assets/Daster.png"),
            productItem(
                context, "Tank Top", "Rp 100.000", "assets/Tanktop.png"),
            productItem(
                context, "Batik Shirt", "Rp 250.000", "assets/Batik.png"),
          ],
        ),
      ],
    );
  }

  // Search field widget
  Widget _buildSearchField() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: const Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Icon(Icons.search, color: Colors.grey),
          ),
          Expanded(
            child: TextField(
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                hintText: 'Search',
                filled: true,
                fillColor: Colors.transparent,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 10.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Cart icon widget
  Widget _buildCartIcon() {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFA5D1FE), Color(0xFFCDB4DB)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: IconButton(
          icon: const Icon(Icons.shopping_cart, color: Colors.white),
          onPressed: () {
            // Handle cart action
          },
        ),
      ),
    );
  }

  // Category item widget
  Widget categoryItem(String title, String imagePath) {
    return GestureDetector(
      onTap: () {
        List<Map<String, String>> categoryProducts = products[title] ?? [];
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryProductPage(
              categoryTitle: title,
              products: categoryProducts,
            ),
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}