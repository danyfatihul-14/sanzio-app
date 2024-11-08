import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Logo and Text with Background
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/background.png'), // Path to your background image
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    children: [
                      // Logo
                      Image.asset(
                        'assets/Type4.png', // Path to your logo image
                        height: 200, // Set the desired height
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Discover Your Style',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Find clothing that complements your skin tone\n'
                        'Confident with styles curated just for you',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),

                // Outer label and Gradient Border for Username
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Username',
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
                      padding: const EdgeInsets.all(1.5), // Padding for the gradient border thickness
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F8F8), // Background color for TextField
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            prefixIcon: const Icon(IconsaxPlusLinear.profile_circle), // Icon for username
                            hintText: 'Enter your username', // Inner hint text
                            hintStyle: GoogleFonts.plusJakartaSans(
                              color: const Color(0xFF5F5F5F),
                              fontSize: 12,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0), // Rounded corners
                              borderSide: BorderSide.none, // No border line
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),

                // Outer label and Gradient Border for Password
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Password',
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
                      padding: const EdgeInsets.all(1.5), // Padding for the gradient border thickness
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F8F8), // Background color for TextField
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(IconsaxPlusLinear.lock_1), // Icon for password
                            hintText: 'Enter your password', // Inner hint text
                            hintStyle: GoogleFonts.plusJakartaSans(
                              color: const Color(0xFF5F5F5F),
                              fontSize: 12,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0), // Rounded corners
                              borderSide: BorderSide.none, // No border line
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),

                // Sign In Button
                ElevatedButton(
                  onPressed: () {
                    // Navigate to HomePage using named route
                    Navigator.pushNamed(context, '/home');
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: const Color(0xFF4F72BD), // Set button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), // Rounded corners
                    ),
                  ),
                  child: Text(
                    'Login',
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
                    const Expanded(child: Divider(thickness: 1, color: Color(0xFF2A2A2A))),
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
                    const Expanded(child: Divider(thickness: 1, color: Color(0xFF2A2A2A))),
                  ],
                ),
                const SizedBox(height: 16.0),

                // Create Account Button
                ElevatedButton(
                  onPressed: () {
                    // Navigate to RegisterPage using named route
                    Navigator.pushNamed(context, '/register');
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: const Color(0xFFAB6FCD), // Set button color to purple
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
