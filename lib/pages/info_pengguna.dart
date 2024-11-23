import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raffaelosanzio/shared/theme.dart';
import 'package:raffaelosanzio/widget/textField.dart';

class MyInformasiPengguna extends StatelessWidget {
  const MyInformasiPengguna({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    // ignore: unused_local_variable
    double height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Informasi Pengguna",
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
        )),
        child: SizedBox(
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Container(
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
                    ),
                    const Positioned(
                      left: 80,
                      bottom: 0,
                      child: SizedBox(
                        width: 30,
                        height: 30,
                        child: Image(
                          image: AssetImage("EditProfilePicture.png"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              const CustomOutlineInputProfileUser(
                  title: "Your Skintone", image: "assets/scan.png"),
              const CustomOutlineInputProfileUser(
                  title: "Nama Lengkap", image: "assets/user.png"),
              const CustomOutlineInputProfileUser(
                  title: "Username", image: "assets/profile-circle.png"),
              const CustomOutlineInputProfileUser(
                  title: "No. Telp", image: "assets/call-calling.png"),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Container(
                  width: width * 0.95,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color.fromRGBO(171, 111, 205, 100),
                  ),
                  child: Center(
                    child: Text(
                      "Simpan",
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: whiteMain),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
