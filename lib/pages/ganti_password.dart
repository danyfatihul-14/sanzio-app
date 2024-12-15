import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:raffaelosanzio/api/profile_api.dart';
import 'package:raffaelosanzio/auth/auth_form_validator.dart';
import 'package:raffaelosanzio/widget/button.dart';
import 'package:raffaelosanzio/widget/textField.dart';
import 'package:raffaelosanzio/shared/theme.dart';

class MyGantiPassword extends StatefulWidget {
  const MyGantiPassword({super.key});

  @override
  State<MyGantiPassword> createState() => _MyGantiPasswordState();
}

class _MyGantiPasswordState extends State<MyGantiPassword> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController validateNewPasswordController =
      TextEditingController();

  Future<void> changePassword() async {
    String? isValidate = await AuthFormValidator().changePasswordValidator(
      oldPasswordController.text,
      newPasswordController.text,
      validateNewPasswordController.text,
    );
    if (isValidate != null) {
      Fluttertoast.showToast(
        msg: isValidate,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      bool isUpdated = await UserApiHandler().changePassword(
        oldPasswordController.text,
        newPasswordController.text,
      );
      if (isUpdated) {
        Fluttertoast.showToast(
          msg: "Password Berhasil Diubah",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(
          msg: "Password Gagal Diubah",
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
    double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: gray50,
      appBar: AppBar(
        foregroundColor: whiteMain,
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
            child: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8.0), // Ukuran lingkaran
                decoration: const BoxDecoration(
                  color: Colors.white, // Warna latar belakang lingkaran
                  shape: BoxShape.circle, // Bentuk lingkaran
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      spreadRadius: -2,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: blue600,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
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
            FormFieldNoIconCustom(
              label: 'Password',
              value: 'Password',
              controller: oldPasswordController,
            ),
            const SizedBox(height: 20),
            FormFieldNoIconCustom(
              label: 'New Password',
              value: 'New Password',
              controller: newPasswordController,
            ),
            const SizedBox(height: 20),
            FormFieldNoIconCustom(
              label: 'Confirmation Password',
              value: 'Confriamtion Password',
              controller: validateNewPasswordController,
            ),
            const SizedBox(height: 70),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomButton(
                title: "Simpan",
                color: blue600,
                pushTo: () {
                  changePassword();
                },
              ),
            ),
            // Save Button
          ],
        ),
      ),
    );
  }
}
