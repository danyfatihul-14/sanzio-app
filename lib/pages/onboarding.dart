import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raffaelosanzio/pages/login.dart';
import 'package:raffaelosanzio/shared/theme.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      'imagePath': 'assets/onboarding 1.png',
      'title': 'Temukan Produk Favorit Anda',
      'description':
          'Temukan produk impian Anda dengan mudah dan cepat! Tidak perlu lagi repot, cukup gunakan fitur pencarian kami untuk mendapatkan apa yang Anda butuhkan dalam hitungan detik.',
    },
    {
      'imagePath': 'assets/onboarding 2.png',
      'title': 'Promo Menarik Setiap Hari',
      'description':
          'Jangan lewatkan kesempatan emas untuk menikmati diskon spesial yang kami siapkan hanya untuk Anda! Belanja hemat dengan penawaran terbaik yang sayang jika dilewatkan. Yuk, buruan sebelum kehabisan!',
    },
    {
      'imagePath': 'assets/onboarding 3.png',
      'title': 'Pengiriman Cepat & Aman',
      'description':
          'Kami pastikan pesanan Anda tiba dengan aman, tepat waktu, dan dalam kondisi terbaik! Belanja tanpa khawatir, karena kepuasan dan kenyamanan Anda adalah prioritas kami.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteMain,
      appBar: AppBar(
        backgroundColor: whiteMain,
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: TextButton(
              onPressed: () {
                // Aksi tombol Skip
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text(
                'Skip',
                style: GoogleFonts.plusJakartaSans(
                    color: blue600,
                    fontWeight:
                        FontWeight.w600 // Pastikan teks terlihat di AppBar
                    ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: _onboardingData.length,
              itemBuilder: (context, index) {
                return buildOnboardingPage(
                  context,
                  imagePath: _onboardingData[index]['imagePath']!,
                  title: _onboardingData[index]['title']!,
                  description: _onboardingData[index]['description']!,
                  index: index,
                );
              },
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: _currentPage == _onboardingData.length - 1
                ? SizedBox(
                    width: double.infinity, // Tombol full panjang
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 79, 114, 189),
                        minimumSize: const Size(
                            double.infinity, 50), // Full lebar tombol
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: const Text(
                        'Mulai Belanja',
                        style: TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                            List.generate(_onboardingData.length, (index) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            height: 10.0,
                            width: _currentPage == index ? 20.0 : 10.0,
                            decoration: BoxDecoration(
                              color: _currentPage == index
                                  ? const Color.fromARGB(255, 79, 114, 189)
                                  : Colors.grey[400],
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          );
                        }),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.height * (1 / 8),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 79, 114, 189),
                          minimumSize: Size(150, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          _pageController.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: const Text(
                          'Selanjutnya',
                          style: TextStyle(
                            fontFamily: 'PlusJakartaSans',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
          )
        ],
      ),
    );
  }

  Widget buildOnboardingPage(BuildContext context,
      {required String imagePath,
      required String title,
      required String description,
      required int index}) {
    double imageHeight = (index == 0) ? 0.4 : 0.5;
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.001,
                ),
                Image.asset(
                  imagePath,
                  height: constraints.maxHeight * imageHeight,
                  fit: BoxFit.contain,
                ),
                Column(
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: gray600),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 14,
                        color: gray400,
                      ),
                    ),
                    const SizedBox(
                      height: 36,
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
