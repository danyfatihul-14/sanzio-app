import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raffaelosanzio/api/profile_api.dart';
import 'package:raffaelosanzio/pages/product_scanning.dart';
import 'package:raffaelosanzio/shared/theme.dart';

class DisplayPictureScreen extends StatefulWidget {
  final File imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  // ignore: library_private_types_in_public_api
  _DisplayPictureScreenState createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _simulateLoading();
    });
  }

  Future<int> scanFaces(File file) async {
    try {
      final response = await UserApiHandler().scanFace(file);
      if (response != false) {
        Fluttertoast.showToast(
          msg: "Face Scanned Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: whiteMain,
          fontSize: 16.0,
        );
        return response;
      } else {
        Fluttertoast.showToast(
          msg: "Face Not Detected",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: whiteMain,
          fontSize: 16.0,
        );
        return -1;
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error Scanning Face: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: whiteMain,
        fontSize: 16.0,
      );
      return -1;
    }
  }

  Future<void> _simulateLoading() async {
    int? isScanned = await scanFaces(widget.imagePath);
    if (isScanned >= 0) {
      setState(() {
        if (mounted) {
          _isLoading = false;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ProductScanningPage(
                      skin_type: isScanned,
                    )),
          );
        }
      });
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Waiting",
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          Image.file(
            File(widget.imagePath.path),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          if (_isLoading)
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(child: CircularProgressIndicator()),
              ),
            ),
        ],
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
