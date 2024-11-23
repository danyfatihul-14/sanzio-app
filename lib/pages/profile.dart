import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raffaelosanzio/shared/theme.dart';
import 'package:raffaelosanzio/widget/button.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    // ignore: unused_local_variable
    double height = MediaQuery.sizeOf(context).height;
    int _selectedIndex = 0;

    void onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      backgroundColor: gray60,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: whiteMain,
              padding: const EdgeInsets.only(top: 36, bottom: 4.0),
              width: width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14.0, vertical: 8.0),
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
                        padding: const EdgeInsets.all(4),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Username",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24,
                                  color: gray600),
                            ),
                            Text(
                              "Full Name",
                              style: TextStyle(
                                color: gray400,
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(135, 86, 40, 100),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Type 10",
                              style: TextStyle(
                                color: gray400,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                children: [
                  Container(
                    color: whiteMain,
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14.0),
                          child: Text(
                            "Informasi Pengguna",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              color: gray600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const CustomOutlineMenuProfile(
                          title: "Akun Saya",
                          pushTo: "/profile/information",
                        ),
                        const CustomOutlineMenuProfile(
                          title: "Alamat Saya",
                          pushTo: "/",
                        ),
                        const CustomOutlineMenuProfile(
                          title: "Ganti Password",
                          pushTo: "/",
                        ),
                        const CustomOutlineMenuProfile(
                          title: "Favorite",
                          pushTo: "/",
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    color: whiteMain,
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14.0),
                          child: Text(
                            "About Sanzio",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              color: gray600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const CustomOutlineMenuProfile(
                          title: "Kebijakan Sanzio",
                          pushTo: "/",
                        ),
                        const CustomOutlineMenuProfile(
                          title: "Tentang Sanzio",
                          pushTo: "/",
                        ),
                      ],
                    ),
                  ),
                  CustomOutlineButton(
                    title: "Logout",
                    color: purple600,
                    pushTo: "/login",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
