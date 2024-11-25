import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raffaelosanzio/shared/theme.dart';
import 'package:raffaelosanzio/widget/bottom_navbar.dart';
import 'dart:math' as math;

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
    final isFlipped = _flipAnimation.value > 0.5;
    if (isFlipped) {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
            builder: (context) => const CustomBottomNavbar(
                selectedIndex: 2), // Corrected toHistory usage
          ),
        );
      });
    }

    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _flipAnimation,
          builder: (context, child) {
            // Rotasi 3D untuk flip animasi
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(
                  _flipAnimation.value * math.pi), // Rotasi Y-axis
              child: isFlipped
                  ? Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(math.pi), // Flip 180 derajat
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check_circle, // Ikon centang
                            color: blue600, // Warna ikon putih
                            size: 80, // Ukuran ikon
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
                  : Transform.rotate(
                      angle: _loadingController.value * 2 * math.pi,
                      child: Container(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(
                          color: blue600,
                          strokeWidth: 8.0,
                          strokeCap: StrokeCap.round,
                        ),
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }
}
