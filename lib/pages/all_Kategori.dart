import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raffaelosanzio/shared/theme.dart';
// import 'package:raffaelosanzio/widget/button.dart';
// import 'package:raffaelosanzio/widget/textField.dart';

class AllCategoriesPage extends StatelessWidget {
  const AllCategoriesPage({super.key});

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
          style: TextStyle(color: gray800, fontWeight: FontWeight.bold, fontSize: 16),
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
                style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
              ),
              const SizedBox(height: 8),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 0.75,
                ),
                itemCount: 12,
                itemBuilder: (context, index) {
                  return const CategoryCard(
                    title: 'Category',
                    itemCount: '100 Items',
                    image: 'assets/T-Shirt.png', // Replace with actual image asset
                  );
                },
              ),

              // Genders Section
              const SizedBox(height: 24),
              Text(
                'Genders',
                style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold, fontSize: 18, color: gray800),
              ),
              const SizedBox(height: 8),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GenderCard(image: 'assets/female.png'), // Replace with actual image asset
                  GenderCard(image: 'assets/male.png'), // Replace with actual image asset
                ],
              ),

              // Season Section
              const SizedBox(height: 24),
              Text(
                'Season',
                style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold, fontSize: 18, color: gray800),
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

// CategoryCard Widget
class CategoryCard extends StatelessWidget {
  final String title;
  final String itemCount;
  final String image;

  const CategoryCard({
    required this.title,
    required this.itemCount,
    required this.image,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: whiteMain,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 50), // Add image asset path
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w500, color: gray800),
          ),
          Text(
            itemCount,
            style: TextStyle(color: gray500, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

// GenderCard Widget
class GenderCard extends StatelessWidget {
  final String image;

  const GenderCard({required this.image, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
        ),
      ),
    );
  }
}

// SeasonCard Widget
class SeasonCard extends StatelessWidget {
  final String title;

  const SeasonCard({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: whiteMain,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w500, color: gray800),
      ),
    );
  }
}
