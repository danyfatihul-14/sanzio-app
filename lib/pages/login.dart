import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:raffaelosanzio/auth/auth_form_validator.dart';
import 'package:raffaelosanzio/auth/auth_handler.dart';
import 'package:raffaelosanzio/shared/theme.dart';
import 'package:raffaelosanzio/widget/button.dart';
import 'package:raffaelosanzio/widget/textField.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    String? isValid = AuthFormValidator().loginValidator(username, password);

    if (isValid != null) {
      Fluttertoast.showToast(
        msg: isValid,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    } else {
      bool isLogin = await AuthHandler().login(username, password);
      if (isLogin) {
        Fluttertoast.showToast(
          msg: "Login Berhasil",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Navigator.pushReplacementNamed(context, '/main-home');
      } else {
        Fluttertoast.showToast(
          msg: "Login Gagal",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    }

    // Navigasi ke halaman utama
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteMain,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Image.asset(
                    'assets/background.png',
                    fit: BoxFit.cover,
                  ),
                ),
                // Content on top of the background
                Center(
                  child: Stack(
                    children: [
                      Lottie.asset(
                        "assets/an_login.json",
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: (MediaQuery.of(context).size.width) * 0.78),
                        child: Center(
                          child: Column(
                            children: [
                              Text(
                                'Discover Your Style',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Find clothing that complements your skin tone\n'
                                'Confident with styles curated just for you',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.plusJakartaSans(
                                  color: gray400,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Outer label and Gradient Border for Username
            FormFieldCustom(
              label: 'Username',
              value: 'Enter your username',
              icons: Icon(IconsaxPlusLinear.profile_circle),
              controller: _usernameController,
              isPassword: false,
            ),
            const SizedBox(height: 8.0),

            // Outer label and Gradient Border for Password
            FormFieldCustom(
              label: 'Password',
              value: 'Enter your password',
              icons: Icon(IconsaxPlusLinear.lock_1),
              controller: _passwordController,
              isPassword: true,
            ),
            const SizedBox(height: 24.0),

            // Sign In Button
            CustomButton(
              title: 'Login',
              color: blue600,
              pushTo: _login,
            ),
            const SizedBox(height: 16.0),

            // Divider with "Or"
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  const Expanded(
                      child: Divider(thickness: 1, color: Color(0xFF2A2A2A))),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Or",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        color: const Color(0xFF2A2A2A),
                      ),
                    ),
                  ),
                  const Expanded(
                      child: Divider(thickness: 1, color: Color(0xFF2A2A2A))),
                ],
              ),
            ),
            const SizedBox(height: 16.0),

            // Create Account Button
            CustomOutlineButton(
              title: 'Create Account',
              color: purple600,
              pushTo: () {
                Navigator.pushReplacementNamed(context, '/register');
              },
            ),
          ],
        ),
      ),
    );
  }
}
