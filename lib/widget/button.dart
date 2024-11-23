import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ElevatedButton(
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
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFFFFFFF),
          ),
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: OutlinedButton(
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
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: color, // Text color
          ),
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
      {super.key,
      required this.title,
      required this.pushTo});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    // ignore: unused_local_variable
    double height = MediaQuery.sizeOf(context).height;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          
            onTap: () {
              // Navigate to HomePage using named route
              Navigator.pushNamed(context, pushTo);
            },
          child: Container(
            
            width: width * 0.95,
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: const LinearGradient(
                colors: [
                  Color.fromRGBO(165, 209, 254, 1), // Light Blue
                  Color.fromRGBO(205, 180, 219, 1), // Light Purple
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Container(
                decoration: BoxDecoration(
                  color: whiteMain,
                  borderRadius: BorderRadius.circular(11)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title, style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.grey,
                      ),),
                      const SizedBox(
                        width: 15,
                        height: 15,
                        child: Image(
                          image: AssetImage("assets/chevron.png"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
