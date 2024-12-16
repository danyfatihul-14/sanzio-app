import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raffaelosanzio/shared/theme.dart';
import 'package:raffaelosanzio/widget/displaypicture_screen.dart';

// ignore: must_be_immutable
class TakePictureScreen extends StatefulWidget {
  CameraDescription? camera;
  TakePictureScreen({super.key, this.camera});

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late CameraDescription frontCamera;

  @override
  void initState() {
    super.initState();
    _initializeControllerFuture = _initializeCamera().then((_) {
      _showModalGuide();
    });
  }

  Future<void> _initializeCamera() async {
    // Get the list of available cameras.
    final cameras = await availableCameras();
    // Find the front camera.
    frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
    );

    // Create a CameraController.
    _controller = CameraController(
      frontCamera,
      ResolutionPreset.medium,
    );

    // Initialize the controller.
    _initializeControllerFuture = _controller.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  void _showModalGuide() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 400,
          color: whiteMain,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Contoh Penggunaan yang Benar',
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: gray600),
                ),
                const SizedBox(height: 24),
                Image.asset('assets/img_scan_guide.jpeg', width: 200),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Scanning",
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
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            await _initializeControllerFuture;
            final image = await _controller.takePicture();
            final imagePath = image.path.replaceAll('.png', '.jpg');
            await File(image.path).rename(imagePath);
            if (!context.mounted) return;
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(
                  imagePath: File(imagePath),
                ),
              ),
            );
          } catch (e) {
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
