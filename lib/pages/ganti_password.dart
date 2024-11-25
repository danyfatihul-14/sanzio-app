import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raffaelosanzio/widget/button.dart';
import 'package:raffaelosanzio/widget/textField.dart';
import 'package:raffaelosanzio/shared/theme.dart';

class MyGantiPassword extends StatelessWidget {
  const MyGantiPassword({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ganti Password",
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: whiteMain,
        shadowColor: Colors.grey,
        leading: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: (){
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
              const SizedBox(height: 41),
              FormFieldNoIconCustom(
                label: 'Password', 
                value: 'Password',
              ),
              const SizedBox(height: 20),
              FormFieldNoIconCustom(
                label: 'New Password', 
                value: 'New Password',
              ),
              const SizedBox(height: 20),
              FormFieldNoIconCustom(
                label: 'Confirmation Password', 
                value: '*********************',
              ),
              const SizedBox(height: 70),
              CustomOutlineButton(
                title: "Simpan",
                color: Color.fromRGBO(171, 111, 205, 1),
                pushTo: '/profile',
              ),
              // Save Button
            ],
          ),
        ),
      ),
    );
  }
}
