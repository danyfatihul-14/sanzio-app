import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:raffaelosanzio/shared/theme.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Color color;
  final String pushTo;
  const CustomButton(
      {super.key,
      required this.title,
      required this.color,
      required this.pushTo});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Navigate to HomePage using named route
        Navigator.pushNamed(context, pushTo);
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: color, // Set button color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // Rounded corners
        ),
      ),
      child: Text(
        title,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: const Color(0xFFFFFFFF),
        ),
      ),
    );
  }
}

class CustomOutlineButton extends StatelessWidget {
  final String title;
  final Color color;
  final String pushTo;

  const CustomOutlineButton(
      {super.key,
      required this.title,
      required this.color,
      required this.pushTo});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        // Navigate to HomePage using named route
        Navigator.pushNamed(context, pushTo);
      },
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        side: BorderSide(
          color: color, // Border color
          width: 2.0, // Border width
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // Rounded corners
        ),
      ),
      child: Text(
        title,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: color, // Text color
        ),
      ),
    );
  }
}

class CustomOutlineGradientButton extends StatelessWidget {
  final String title;
  final String pushTo;
  final List<Color> gradientColors;

  const CustomOutlineGradientButton(
      {super.key,
      required this.title,
      required this.gradientColors,
      required this.pushTo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFA5D1FE), Color(0xFFCDB4DB)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent, // Background color for button area
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: OutlinedButton(
          onPressed: () {
            // Navigate to HomePage using named route
            Navigator.pushNamed(context, pushTo);
          },
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            backgroundColor: Colors.transparent,
            side: const BorderSide(
              color: Colors.transparent,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0), // Rounded corners
            ),
          ),
          child: Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomOutlineMenuProfile extends StatelessWidget {
  final String title;
  final String pushTo;

  const CustomOutlineMenuProfile(
      {super.key, required this.title, required this.pushTo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, pushTo);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 1.0),
            decoration: BoxDecoration(
              color: whiteMain,
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFA5D1FE),
                  Color(0xFFCDB4DB),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Container(
              color: whiteMain,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: gray500,
                    ),
                  ),
                  const SizedBox(
                    child: Icon(
                      IconsaxPlusLinear.arrow_right_3,
                      size: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
