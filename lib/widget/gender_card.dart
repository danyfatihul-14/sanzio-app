import 'package:flutter/material.dart';

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
