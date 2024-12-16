import 'package:flutter/material.dart';

class MyForgetPassword extends StatelessWidget {
  const MyForgetPassword({super.key});

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
                  'Forgot Password',
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
                    'Reset your password. Please proceed with the steps to regain access to your account.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 17),
                // Centered Username TextField
                Center(
                  child: Container(
                    width: 328,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Username',
                          style: TextStyle(fontSize: 14),
                        ),
                        // SizedBox(height: 7),
                        // FormFieldCustom(
                        //   label: 'Username', 
                        //   value: '', 
                        //   icons: Icon(IconsaxPlusLinear.profile_circle),
                        // ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Centered Email TextField
                Center(
                  child: Container(
                    width: 328,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 42),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
