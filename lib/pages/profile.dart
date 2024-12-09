import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:raffaelosanzio/api/profile_api.dart';
import 'package:raffaelosanzio/auth/auth_handler.dart';
import 'package:raffaelosanzio/blocs/cart/cart_bloc.dart';
import 'package:raffaelosanzio/blocs/cart/cart_event.dart';
import 'package:raffaelosanzio/blocs/cart/cart_hiveHandler.dart';
import 'package:raffaelosanzio/models/hive/model.dart';
import 'package:raffaelosanzio/shared/theme.dart';
import 'package:raffaelosanzio/widget/button.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  bool _isLoading = true;
  User? _user;

  @override
  void initState() {
    super.initState();
    _fetchUserFromHive();
  }

  Future<void> _fetchUserFromHive() async {
    try {
      await UserApiHandler().fetchUser();
      var box = Hive.box('User');
      User user = box.get(1);
      setState(() {
        _user = user;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      Fluttertoast.showToast(
        msg: "Terjadi kesalahan saat mengambil data pengguna ${e}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<void> _logout() async {
    final cartItem = await CartHivehandler().getCart();
    if (cartItem.isNotEmpty) {
      for (var cart in cartItem) {
        context
            .read<CartBloc>()
            .add(RemoveFromCart(detailProductId: cart.detailProductId));
      }
    }
    bool isLogout = await AuthHandler().logout();

    if (isLogout) {
      Fluttertoast.showToast(
        msg: "Logout Berhasil",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      Fluttertoast.showToast(
        msg: "Terjadi kesalahan saat logout",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : _buildProfilePage(context);
  }

  Widget _buildProfilePage(BuildContext context) {
    return Scaffold(
      backgroundColor: gray60,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 36, bottom: 4.0),
              width: double.infinity,
              decoration: BoxDecoration(
                color: whiteMain,
                image: const DecorationImage(
                  image: AssetImage("assets/bg_profile.png"),
                  fit: BoxFit.cover,
                ),
              ),
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
                          child: ClipOval(
                            child: Image(
                              image: _user!.image == null
                                  ? const AssetImage("assets/Ellipse 192.png")
                                  : NetworkImage(_user!.image!),
                              fit: BoxFit.fill,
                            ),
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
                              _user?.username ?? '',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24,
                                  color: gray600),
                            ),
                            Text(
                              _user?.fullname ?? '',
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
                          pushTo: "/user-info",
                        ),
                        const CustomOutlineMenuProfile(
                          title: "Alamat Saya",
                          pushTo: "/edit-address",
                        ),
                        const CustomOutlineMenuProfile(
                          title: "Ganti Password",
                          pushTo: "/change-password",
                        ),
                        const CustomOutlineMenuProfile(
                          title: "Favorite",
                          pushTo: "/favorite",
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
                            "Tentang Kami",
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
                          pushTo: "/kebijakan",
                        ),
                        const CustomOutlineMenuProfile(
                          title: "Tentang Sanzio",
                          pushTo: "/about",
                        ),
                      ],
                    ),
                  ),
                  CustomOutlineButton(
                    title: "Logout",
                    color: purple600,
                    pushTo: _logout,
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
