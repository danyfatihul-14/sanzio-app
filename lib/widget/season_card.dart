import 'package:flutter/material.dart';
import 'package:raffaelosanzio/shared/theme.dart';

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
