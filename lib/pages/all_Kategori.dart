import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raffaelosanzio/api/product_api.dart';
import 'package:raffaelosanzio/help/product_helper.dart';
import 'package:raffaelosanzio/models/hive/model.dart';
import 'package:raffaelosanzio/pages/view_Kategori.dart';
import 'package:raffaelosanzio/shared/theme.dart';
import 'package:raffaelosanzio/widget/category_card.dart';
import 'package:raffaelosanzio/widget/gender_card.dart';
import 'package:raffaelosanzio/widget/season_card.dart';

class AllCategoriesPage extends StatelessWidget {
  final List<Map<String, dynamic>> categories;
  final List<Product> products;

  const AllCategoriesPage(
      {required this.categories, required this.products, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gray50,
      appBar: AppBar(
        backgroundColor: whiteMain,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8.0), // Ukuran lingkaran
            decoration: const BoxDecoration(
              color: Colors.white, // Warna latar belakang lingkaran
              shape: BoxShape.circle, // Bentuk lingkaran
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  spreadRadius: -2,
                ),
              ],
            ),
            child: Icon(
              Icons.arrow_back,
              color: blue600,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'All Categories',
          style: TextStyle(
            color: gray800,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Model Section
              const SizedBox(height: 16),
              Text(
                'Model',
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      MediaQuery.of(context).size.width > 400 ? 4 : 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height * 0.6), // Responsif
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  var category = categories[index];
                  return CategoryCard(
                    title: category['title']!,
                    itemCount: '100 Items', // Adjust this dynamically if needed
                    image: category['image']!,
                    onTap: () {
                      List<Map<String, dynamic>> categoryProducts = products
                          .where((product) {
                            return product.categoryId ==
                                categories[index]['id'];
                          })
                          .map((product) => product.toJson())
                          .toList();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryProductPage(
                              categoryTitle: category['title']!,
                              products: categoryProducts),
                        ),
                      );
                    },
                  );
                },
              ),

              // Genders Section
              const SizedBox(height: 24),
              Text(
                'Genders',
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: gray800,
                ),
              ),
              const SizedBox(height: 8),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: GenderCard(
                      image: 'assets/female.png',
                      gender: "Women",
                    ),
                  ),
                  SizedBox(width: 8),
                  Flexible(
                    child: GenderCard(
                      image: 'assets/male.png',
                      gender: "Man",
                    ),
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
