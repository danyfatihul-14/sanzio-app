import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raffaelosanzio/models/hive/model.dart';
import 'package:raffaelosanzio/pages/gender.dart';
import 'package:raffaelosanzio/pages/view_Kategori.dart';
import 'package:raffaelosanzio/shared/theme.dart';
import 'package:raffaelosanzio/widget/category_card.dart';
import 'package:raffaelosanzio/widget/gender_card.dart';

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
        surfaceTintColor: whiteMain,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8.0), // Ukuran lingkaran
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
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: GenderCard(
                      image: 'assets/female.png',
                      gender: "Woman",
                      onTap: () {
                        print('Gender Card clicked!');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Cewek(),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: GenderCard(
                      image: 'assets/male.png',
                      gender: "Man",
                      onTap: () {
                        print('Gender Card clicked!');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Cowok(),
                          ),
                        );
                      },
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
