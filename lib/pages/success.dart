import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raffaelosanzio/widget/bottom_navbar.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Navigasi otomatis ke HistoryPage setelah 2 detik
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (context) => const CustomBottomNavbar(selectedIndex: 2), // Corrected toHistory usage
        ),
      );
    });

    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 79, 114, 189), // Warna latar biru
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle, // Ikon centang
                color: Colors.white, // Warna ikon putih
                size: 80, // Ukuran ikon
              ),
              const SizedBox(height: 20),
              Text(
                'Pemesanan Berhasil',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 25,
                  fontWeight: FontWeight.bold, // Font tebal
                  color: Colors.white, // Warna teks putih
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
