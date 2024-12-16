import 'package:flutter/material.dart';

class MyGetCode extends StatelessWidget {
  const MyGetCode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gambar rantai di bagian atas
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 400, // Atur tinggi gambar sesuai dengan kebutuhan
              child: Image.asset(
                'assets/images/rantai.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 66.0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                SizedBox(
                  width: 144,
                  height: 190,
                  child: Image.asset('assets/images/logo.png'),
                ),
                const Text(
                  'Get Your Code',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Text(
                    'Please check your email for the verification code. Enter the code here to proceed.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 47),
                const SizedBox(height: 30),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Text(
                    'The code within 1 minute, as it will expire after that.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 64),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
