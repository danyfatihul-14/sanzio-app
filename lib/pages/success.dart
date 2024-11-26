import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:raffaelosanzio/shared/theme.dart';
import 'dart:math' as math;

import 'package:raffaelosanzio/widget/button.dart';

class LoadingToFlipCheck extends StatefulWidget {
  @override
  _LoadingToFlipCheckState createState() => _LoadingToFlipCheckState();
}

class _LoadingToFlipCheckState extends State<LoadingToFlipCheck>
    with TickerProviderStateMixin {
  late AnimationController _loadingController;
  late AnimationController _flipController;

  late Animation<double> _flipAnimation;
  bool _showCheckmark = false;

  @override
  void initState() {
    super.initState();

    // Animation controller untuk loading animasi (2 detik)
    _loadingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    // Animation controller untuk flip animasi
    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // Animasi flip
    _flipAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _flipController, curve: Curves.easeInOut),
    );

    // Transisi dari loading ke flip
    Future.delayed(const Duration(seconds: 2), () {
      _loadingController.stop();
      _flipController.forward().whenComplete(() {
        setState(() {
          _showCheckmark = true;
        });

        // Pindah ke halaman baru setelah 2 detik
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => CheckmarkPage()),
          );
        });
      });
    });
  }

  @override
  void dispose() {
    _loadingController.dispose();
    _flipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteMain,
      body: Center(
        child: AnimatedBuilder(
          animation: _flipAnimation,
          builder: (context, child) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(_flipAnimation.value * math.pi),
              child: _flipAnimation.value >= 0.5
                  ? Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(math.pi),
                      child: Column(
                        key: ValueKey<bool>(_showCheckmark),
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Hero(
                            tag: 'checkmark',
                            child: Icon(
                              IconsaxPlusBold.tick_circle, // Ikon centang
                              color: blue600, // Warna ikon putih
                              size: 80, // Ukuran ikon
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Pemesanan Berhasil',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 20,
                              fontWeight: FontWeight.bold, // Font tebal
                              color: blue600, // Warna teks putih
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      key: ValueKey<bool>(_showCheckmark),
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(
                        color: blue600,
                        strokeWidth: 8.0,
                        strokeCap: StrokeCap.round,
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }
}

class CheckmarkPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gray50,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 60),
            decoration: BoxDecoration(
              color: blue600,
              image: const DecorationImage(
                image: AssetImage('assets/bg_success.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Center(
                  child: Hero(
                    tag: 'checkmark',
                    child: Icon(
                      IconsaxPlusBold.tick_circle, // Ikon centang
                      color: whiteMain, // Warna ikon putih
                      size: 80, // Ukuran ikon
                    ),
                  ),
                ),
                const SizedBox(height: 14.0),
                Text(
                  "Pemesanan Berhasil",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 24,
                    fontWeight: FontWeight.bold, // Font tebal
                    color: whiteMain, // Warna teks putih
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              color: whiteMain,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Detail Transaksi",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: gray600,
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        IconsaxPlusLinear.location,
                        color: gray600,
                        size: 24.0,
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                        child: Text(
                          "Jalan Soekarno Hatta No. 1, Lowokwaru, Kota Malang, Jawa Timur, ID 12345",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: gray600,
                          ),
                          softWrap: true,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Container(
                    height: 1.0,
                    color: gray300,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "No. Pesanan",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: gray600,
                            ),
                          ),
                          Text(
                            "NOV1924XYZA",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: gray400,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Tanggal",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: gray600,
                            ),
                          ),
                          Text(
                            "19-11-2024",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: gray400,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Waktu",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: gray600,
                            ),
                          ),
                          Text(
                            "08:00 WIB",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: gray400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Container(
                    height: 1.0,
                    color: gray300,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: gray600,
                        ),
                      ),
                      Text(
                        "Rp 250.000,00",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: gray400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Row(
            children: [
              Expanded(
                child: CustomOutlineButton(
                  title: "Kembali ke Beranda",
                  color: blue600,
                  pushTo: (){
                    Navigator.pushReplacementNamed(context, '/main-home');
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
