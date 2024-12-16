import 'package:flutter/material.dart';
import 'package:raffaelosanzio/shared/theme.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback? onTap;

  const CategoryCard({
    required this.title,
    required this.image,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
            Image.asset(image, height: 70),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w500, color: gray800),
            ),
          ],
        ),
      ),
    );
  }
}