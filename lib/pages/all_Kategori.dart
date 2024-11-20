import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raffaelosanzio/help/product_helper.dart';
import 'package:raffaelosanzio/pages/view_Kategori.dart';
import 'package:raffaelosanzio/shared/theme.dart';
import 'package:raffaelosanzio/widget/category_card.dart';
import 'package:raffaelosanzio/widget/gender_card.dart';
import 'package:raffaelosanzio/widget/season_card.dart';

class AllCategoriesPage extends StatelessWidget {
  final List<Map<String, String>> categories;

  const AllCategoriesPage({required this.categories, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteMain,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: gray800),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'All Categories',
          style: TextStyle(
            color: gray800,
            fontWeight: FontWeight.bold,
            fontSize: 16,
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryProductPage(
                            categoryTitle: category['title']!,
                            products:
                                getProductsForCategory(category['title']!),
                          ),
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
                    child: GenderCard(image: 'assets/female.png'),
                  ),
                  SizedBox(width: 8),
                  Flexible(
                    child: GenderCard(image: 'assets/male.png'),
                  ),
                ],
              ),

              // Season Section
              const SizedBox(height: 24),
              Text(
                'Season',
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: gray800,
                ),
              ),
              const SizedBox(height: 8),
              const Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  SeasonCard(title: 'Summer'),
                  SeasonCard(title: 'Spring'),
                  SeasonCard(title: 'Fall'),
                  SeasonCard(title: 'Winter'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
