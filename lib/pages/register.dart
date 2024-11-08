import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo and Title with Spacer to push content upwards
            Column(
              children: [
                const SizedBox(
                    height: 30), // Adjust this value for more space if needed
                Image.asset(
                  'assets/Type4.png',
                  height: 80, // Adjust the height as needed
                ),
                const SizedBox(height: 8.0),
                Text(
                  "Create Account",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  "The perfect choice to boost your confidence\nand match your unique skin tone",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    color: const Color(0xFF5F5F5F),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40.0),

            // Form Fields
            buildFormField("Username", IconsaxPlusLinear.profile_circle),
            const SizedBox(height: 11.0),
            buildFormField("Full Name", IconsaxPlusLinear.user),
            const SizedBox(height: 11.0),
            buildFormField("Email", IconsaxPlusLinear.sms),
            const SizedBox(height: 11.0),
            buildFormField("Password", IconsaxPlusLinear.lock_1,
                isPassword: true),
            const SizedBox(height: 24.0),

            // Sign In Button
            ElevatedButton(
              onPressed: () {
                // Navigate to HomePage using named route
                Navigator.pushNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: const Color(0xFF4F72BD), // Set button color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), // Rounded corners
                ),
              ),
              child: Text(
                'Create Account',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFFFFFFF),
                ),
              ),
            ),
            const SizedBox(height: 16.0),

            // Divider with "Or"
            Row(
              children: [
                const Expanded(
                    child:
                        Divider(thickness: 1, color: Color(0xFF2A2A2A))),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "Or",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      color: const Color(0xFF2A2A2A),
                    ),
                  ),
                ),
                const Expanded(
                    child:
                        Divider(thickness: 1, color: Color(0xFF2A2A2A))),
              ],
            ),
            const SizedBox(height: 16.0),

            // Create Account Button
            ElevatedButton(
              onPressed: () {
                // Navigate to RegisterPage using named route
                Navigator.pushNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor:
                    const Color(0xFFAB6FCD), // Set button color to purple
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), // Rounded corners
                ),
              ),
              child: Text(
                'Sign In',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFFFFFFF),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFormField(String label, IconData icon,
      {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w500,
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
            borderRadius: BorderRadius.circular(20.0),
          ),
          padding: const EdgeInsets.all(1.5), // Gradient border thickness
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF8F8F8), // Background color for TextField
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: TextField(
              obscureText: isPassword,
              decoration: InputDecoration(
                prefixIcon: Icon(icon, color: Colors.grey[600]),
                hintText: 'Enter your $label',
                hintStyle: GoogleFonts.plusJakartaSans(
                  color: const Color(0xFF5F5F5F),
                  fontSize: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
