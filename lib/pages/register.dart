import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:raffaelosanzio/auth/auth_form_validator.dart';
import 'package:raffaelosanzio/auth/auth_handler.dart';
import 'package:raffaelosanzio/shared/theme.dart';
import 'package:raffaelosanzio/widget/button.dart';
import 'package:raffaelosanzio/widget/textField.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController _usernameController;
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _registration() async {
    String username = _usernameController.text;
    String fullName = _fullNameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    String? isValid = AuthFormValidator()
        .registerValidator(email, password, fullName, username);

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
      bool isRegistered =
          await AuthHandler().register(username, fullName, email, password);
      if (isRegistered) {
        Fluttertoast.showToast(
          msg: "Registrasi Berhasil",
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
          msg: "Registrasi Gagal",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    }
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
                Container(
                  margin: const EdgeInsets.only(top: 80.0),
                  width: double.infinity,
                  child: Column(
                    children: [
                      // Logo
                      Image.asset(
                        'assets/Type4.png', // Path to your logo image
                        height: 140, // Set the desired height
                      ),
                      Text(
                        'Create Account',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'The perfect choice to boost your confidence\n'
                        'and match your unique skin tone',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.plusJakartaSans(
                          color: gray400,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
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

                      // Outer label and Gradient Border for Fullname
                      FormFieldCustom(
                        label: 'Full Name',
                        value: 'Enter your Full Name',
                        icons: Icon(IconsaxPlusLinear.user),
                        controller: _fullNameController,
                        isPassword: false,
                      ),
                      const SizedBox(height: 8.0),

                      // Outer label and Gradient Border for Email
                      FormFieldCustom(
                        label: 'Email',
                        value: 'Enter your Email',
                        icons: Icon(IconsaxPlusLinear.sms),
                        controller: _emailController,
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
                    ],
                  ),
                ),
              ],
            ),

            // Sign In Button
            CustomButton(
              title: 'Create Account',
              color: blue600,
              pushTo: _registration,
            ),
            const SizedBox(height: 16.0),

                  // Divider with "Or"
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        const Expanded(
                            child: Divider(
                                thickness: 1, color: Color(0xFF2A2A2A))),
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
                            child: Divider(
                                thickness: 1, color: Color(0xFF2A2A2A))),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),

            // Create Account Button
            CustomOutlineButton(
              title: 'Sign In',
              color: purple600,
              pushTo: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}
