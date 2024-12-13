import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:raffaelosanzio/api/profile_api.dart';
import 'package:raffaelosanzio/auth/auth_form_validator.dart';
import 'package:raffaelosanzio/models/hive/model.dart';
import 'package:raffaelosanzio/shared/theme.dart';
import 'package:raffaelosanzio/widget/textField.dart';
import 'package:raffaelosanzio/widget/button.dart';

class MyInformasiPengguna extends StatefulWidget {
  const MyInformasiPengguna({super.key});

  @override
  State<MyInformasiPengguna> createState() => _MyInformasiPenggunaState();
}

class _MyInformasiPenggunaState extends State<MyInformasiPengguna> {
  bool _isLoading = true;
  User? _user;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String? _gender;

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  Future<void> _getUser() async {
    var box = await UserApiHandler().getUser();
    setState(() {
      _user = box;
      _usernameController.text = _user?.username ?? '';
      _fullNameController.text = _user?.fullname ?? '';
      _emailController.text = _user?.email ?? '';
      _phoneController.text = _user?.phone ?? '';
      _gender = User.genderToString(_user!.gender);
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _refreshData() {
    _getUser();
  }

  void onChanged(String? newValue) {
    setState(() {
      _gender = newValue!;
    });
  }

  Future<void> _saveUpdate() async {
    String? isValid = AuthFormValidator().updateValidator(
        _usernameController.text,
        _fullNameController.text,
        _emailController.text,
        _phoneController.text,
        _gender);
    if (isValid != null) {
      Fluttertoast.showToast(
        msg: isValid,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: whiteMain,
        fontSize: 16.0,
      );
    } else {
      bool isUpdated = await UserApiHandler().updateUserDetails(
          _usernameController.text,
          _fullNameController.text,
          _emailController.text,
          _phoneController.text,
          _gender);

      if (isUpdated) {
        Fluttertoast.showToast(
          msg: "Informasi Pengguna Berhasil Diperbarui",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: whiteMain,
          fontSize: 16.0,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Terjadi Kesalahan Saat Memperbarui Informasi Pengguna",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: whiteMain,
          fontSize: 16.0,
        );
      }
    }
  }

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
        leading: IconButton(
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildUserInfo(),
      bottomNavigationBar: BottomAppBar(
        color: whiteMain,
        child: CustomOutlineButton(
            title: "Simpan",
            color: blue600,
            pushTo: () {
              _saveUpdate();
            }),
      ),
    );
  }

  Widget _buildUserInfo() {
    return SingleChildScrollView(
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
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/profile-camera')
                          .then((_) => _refreshData());
                    },
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
              child: Column(
                children: [
                  CustomOutlineInputProfileUser(
                    controller: _usernameController,
                    value: "Username",
                    icons: Icon(IconsaxPlusLinear.profile_circle),
                    isPassword: false,
                  ),
                  const SizedBox(height: 6),
                  CustomOutlineInputProfileUser(
                    controller: _fullNameController,
                    value: "Full Name",
                    icons: Icon(IconsaxPlusLinear.user),
                    isPassword: false,
                  ),
                  const SizedBox(height: 6),
                  CustomOutlineInputProfileUser(
                    controller: _emailController,
                    value: "Email",
                    icons: Icon(IconsaxPlusLinear.sms),
                    isPassword: false,
                  ),
                  const SizedBox(height: 6),
                  CustomOutlineInputProfileUser(
                    controller: _phoneController,
                    value: "No. Telp",
                    icons: Icon(IconsaxPlusLinear.call_calling),
                    isPassword: false,
                  ),
                  GenderOptionInput(
                      selectedValue: _gender, onChanged: onChanged),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
