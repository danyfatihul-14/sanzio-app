import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raffaelosanzio/shared/theme.dart';

class GenderCard extends StatelessWidget {
  final String image;
  final String gender;
  final VoidCallback? onTap;

  const GenderCard(
      {super.key, required this.image, required this.gender, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap, // Pastikan onTap terdefinisi dengan baik
        child: SizedBox(
          height: 200,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      gray600,
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.only(top: 150),
                child: Text(
                  gender,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 24,
                    color: whiteMain,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}