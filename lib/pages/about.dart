import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raffaelosanzio/shared/theme.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tentang Sanzio",
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: whiteMain,
        shadowColor: Colors.grey,
        leading: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 20,
              height: 20,
              child: const Image(image: AssetImage("assets/Back-AppBar.png")),
            ),
          ),
        ),
      ),
      body: Container(
        width: width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/BG-data.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 14),
              Text(
                "Sanzio adalah aplikasi e-commerce yang dirancang untuk memberikan pengalaman belanja yang modern dan nyaman. "
                "Dengan fitur utama seperti tampilan produk yang menarik, pengelolaan keranjang belanja, pembayaran yang mudah, "
                "dan manajemen pengguna, Sanzio hadir untuk memenuhi kebutuhan belanja online Anda.\n\n"
                "Keunggulan Sanzio meliputi teknologi pengenalan wajah berbasis AI untuk keamanan dan kemudahan login, serta dukungan database yang handal "
                "untuk memastikan semua data pengguna dan transaksi dikelola dengan baik.\n\n"
                "Kami berkomitmen untuk terus menghadirkan inovasi yang mempermudah hidup Anda.",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
              const Spacer(),
              Center(
                child: Text(
                  "Sanzio - Belanja Lebih Mudah, Lebih Aman.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
