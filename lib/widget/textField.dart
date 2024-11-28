import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raffaelosanzio/shared/theme.dart';

class FormFieldCustom extends StatelessWidget {
  final String label;
  final String value;
  final Icon icons;
  final TextEditingController controller;
  final bool isPassword;
  const FormFieldCustom({
    super.key,
    required this.label,
    required this.value,
    required this.icons,
    required this.controller,
    required this.isPassword,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF242F38),
            ),
          ),
          const SizedBox(height: 8.0),
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFA5D1FE), Color(0xFFCDB4DB)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.all(
                1.5), // Padding for the gradient border thickness
            child: Container(
              decoration: BoxDecoration(
                color: whiteMain, // Background color for TextField
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextField(
                controller: controller,
                obscureText: isPassword,
                decoration: InputDecoration(
                  prefixIcon: icons, // Icon for password
                  hintText: value, // Inner hint text
                  hintStyle: GoogleFonts.plusJakartaSans(
                    color: gray500,
                    fontSize: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(20.0), // Rounded corners
                    borderSide: BorderSide.none, // No border line
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FormFieldNoIconCustom extends StatelessWidget {
  final String label;
  final String value;
  const FormFieldNoIconCustom({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF242F38),
            ),
          ),
          const SizedBox(height: 8.0),
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFA5D1FE), Color(0xFFCDB4DB)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.all(
                1.5), // Padding for the gradient border thickness
            child: Container(
              decoration: BoxDecoration(
                color: whiteMain, // Background color for TextField
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  // Icon for password
                  hintText: value, // Inner hint text
                  hintStyle: GoogleFonts.plusJakartaSans(
                    color: gray400,
                    fontSize: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(20.0), // Rounded corners
                    borderSide: BorderSide.none, // No border line
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomOutlineInputProfileUser extends StatelessWidget {
  final String value;
  final Icon icons;

  const CustomOutlineInputProfileUser(
      {super.key, required this.value, required this.icons});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFA5D1FE), Color(0xFFCDB4DB)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.all(
          1.5), // Padding for the gradient border thickness
      child: Container(
        decoration: BoxDecoration(
          color: whiteMain, // Background color for TextField
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: TextField(
          obscureText: true,
          decoration: InputDecoration(
            prefixIcon: icons, // Icon for password
            hintText: value, // Inner hint text
            hintStyle: GoogleFonts.plusJakartaSans(
              color: gray500,
              fontSize: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0), // Rounded corners
              borderSide: BorderSide.none, // No border line
            ),
          ),
        ),
      ),
    );
  }
}
