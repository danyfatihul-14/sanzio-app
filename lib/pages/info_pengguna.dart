import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:raffaelosanzio/shared/theme.dart';
import 'package:raffaelosanzio/widget/textField.dart';
import 'package:raffaelosanzio/widget/button.dart';

class MyInformasiPengguna extends StatelessWidget {
  const MyInformasiPengguna({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gray50,
      appBar: AppBar(
        title: Text(
          "Informasi Pengguna",
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: whiteMain,
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
      body: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromRGBO(165, 209, 254, 1), // Light Blue
                            Color.fromRGBO(205, 180, 219, 1), // Light Purple
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(60),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          width: 112,
                          height: 112,
                          child: const Image(
                            image: AssetImage("assets/Ellipse 192.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 80,
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: blue600,
                          borderRadius: BorderRadius.circular(60),
                        ),
                        child: Icon(
                          Icons.mode_edit_outline,
                          color: whiteMain,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Column(
                  children: [
                    CustomOutlineInputProfileUser(
                      value: "Username",
                      icons: Icon(IconsaxPlusLinear.profile_circle),
                    ),
                    SizedBox(height: 6),
                    CustomOutlineInputProfileUser(
                        value: "Full Name",
                        icons: Icon(IconsaxPlusLinear.user)),
                    SizedBox(height: 6),
                    CustomOutlineInputProfileUser(
                        value: "Email", icons: Icon(IconsaxPlusLinear.sms)),
                    SizedBox(height: 6),
                    CustomOutlineInputProfileUser(
                        value: "No. Telp",
                        icons: Icon(IconsaxPlusLinear.call_calling)),
                    SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: whiteMain,
        child:
            CustomOutlineButton(title: "Simpan", color: blue600, pushTo: () {}),
      ),
    );
  }
}
