import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raffaelosanzio/api/product_api.dart';
import 'package:raffaelosanzio/help/data.dart';
import 'package:raffaelosanzio/models/hive/model.dart';
import 'package:raffaelosanzio/pages/all_Kategori.dart';
import 'package:raffaelosanzio/pages/mychart.dart';
import 'package:raffaelosanzio/pages/search.dart';
import 'package:raffaelosanzio/pages/view_Kategori.dart';
import 'package:raffaelosanzio/shared/theme.dart';
import 'package:raffaelosanzio/widget/product_item.dart';
import 'package:hive/hive.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<Product> _products = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProductsFromHive();
  }

  Future<void> _fetchProductsFromHive() async {
    await ProductApiHandler().fetchAndStoreProducts();
    _isLoading = false;
    var box = Hive.box('Product');
    List<Product> products = box.get(1)?.cast<Product>() ?? [];
    setState(() {
      _products = products;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: whiteMain,
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
              const SizedBox(height: 16.0)
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
      surfaceTintColor: whiteMain,
      backgroundColor: whiteMain,
      automaticallyImplyLeading: false,
      title: _buildSearchField(),
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
                    builder: (context) => AllCategoriesPage(
                      categories: categories,
                      products: _products,
                    ),
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
                categories[index]['id']!,
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
    final popularProducts = _products
        .where((product) => product.rating > 4.5)
        .toList()
      ..sort((a, b) => b.rating.compareTo(a.rating));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Popular Products",
            style: GoogleFonts.plusJakartaSans(
                fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8.0),
        _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height *
                        0.68), // Sesuaikan proporsi
                children: List.generate(
                  popularProducts.length,
                  (index) {
                    final product = popularProducts[index];

                    // Mengirimkan satu Map<String, dynamic> ke ProductItem
                    return ProductItem(product: product.toJson());
                  },
                ),
              ),
      ],
    );
  }

  // Search functionality
  Widget _buildSearchField() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: gray50,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Icon(Icons.search, color: gray600),
          ),
          Expanded(
            child: TextField(
              textAlign: TextAlign.start,
              decoration: const InputDecoration(
                hintText: 'Search',
                filled: true,
                fillColor: Colors.transparent,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 10.0),
              ),
              onSubmitted: (query) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchPage(query: query),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Cart icon widget
  Widget _buildCartIcon() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: 40,
        height: 40,
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const ShoppingCartPage(), // Navigasi ke ShoppingCartPage
              ),
            );
          },
        ),
      ),
    );
  }

  // Category item widget
  Widget categoryItem(int id, String title, String imagePath) {
    return GestureDetector(
      onTap: () {
        List<Map<String, dynamic>> categoryProducts = _products
            .where((product) => product.categoryId == id)
            .map((product) => product.toJson())
            .toList();
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
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
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
