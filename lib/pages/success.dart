import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raffaelosanzio/pages/history.dart';

// Assuming you have a HistoryPage widget defined
import 'history_page.dart';

class SuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          // Navigate to HistoryPage when the screen is tapped
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HistoryPage()),
          );
        },
        child: Container(
          color: const Color.fromARGB(255, 79, 114,
              189), // Set the background color of the page to blue
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle, // Use the checkmark icon
                  color: Colors.white, // Set icon color to white for contrast
                  size: 80, // Adjust the size as needed
                ),
                SizedBox(height: 20),
                Text(
                  'Pemesanan Berhasil',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 25,
                    fontWeight:
                        FontWeight.bold, // Change this to FontWeight.bold
                    color: const Color.fromARGB(255, 255, 255, 255),
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
