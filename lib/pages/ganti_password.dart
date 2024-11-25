import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:raffaelosanzio/widget/button.dart';
import 'package:raffaelosanzio/widget/textField.dart';
import 'package:raffaelosanzio/shared/theme.dart';

class MyGantiPassword extends StatelessWidget {
  const MyGantiPassword({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: gray50,
      appBar: AppBar(
        title: Text(
          "Ganti Password",
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: gray600,
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
              child: Icon(
                IconsaxPlusBold.arrow_circle_left,
                color: blue400,
                size: 36,
              ),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const FormFieldNoIconCustom(
              label: 'Password',
              value: 'Password',
            ),
            const SizedBox(height: 20),
            const FormFieldNoIconCustom(
              label: 'New Password',
              value: 'New Password',
            ),
            const SizedBox(height: 20),
            const FormFieldNoIconCustom(
              label: 'Confirmation Password',
              value: 'Confriamtion Password',
            ),
            const SizedBox(height: 70),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomButton(
                title: "Simpan",
                color: blue600,
                pushTo: '/profile',
              ),
            ),
            // Save Button
          ],
        ),
      ),
    );
  }
}
