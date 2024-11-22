import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:raffaelosanzio/pages/profile.dart';
import 'package:raffaelosanzio/widget/textField.dart';

class MyResetPassword extends StatelessWidget {
  const MyResetPassword({super.key});

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
                Text(
                  'Reset Password',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Text(
                    'Set up a new password. Ensure your account remains secure.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 17),
                // Centered Username TextField
                Center(
                  child: Container(
                    width: 328,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'New Password',
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 7),
                        FormFieldNoIconCustom(
                          label: 'Password', 
                          value: 'Password', 
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Center(
                  child: Container(
                    width: 328,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Confirmation Password',
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 7),
                        FormFieldNoIconCustom(
                          label: 'Confirmation Password', 
                          value: 'Confirmation Password',
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 42), // Memberikan jarak sebelum tombol
                // Tombol Recover Password yang memanggil halaman GetCode
                CustomButton(
                  text: 'Create New Password', 
                  onPressed: () {

                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}