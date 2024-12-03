import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:image/image.dart' as img;

import 'package:raffaelosanzio/api/profile_api.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late List<CameraDescription> _cameras;
  late CameraDescription _camera;
  bool _isCameraInitialized = false;
  bool _isFrontCamera = false;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  // Initialize camera
  Future<void> initializeCamera() async {
    _cameras = await availableCameras();
    _camera = _cameras.first;
    _controller = CameraController(_camera, ResolutionPreset.high);

    await _controller.initialize();
    setState(() {
      _isCameraInitialized = true;
    });
  }

  // Switch camera
  Future<void> switchCamera() async {
    setState(() {
      _isCameraInitialized = false;
    });

    _isFrontCamera = !_isFrontCamera;
    _camera = _isFrontCamera
        ? _cameras.firstWhere(
            (camera) => camera.lensDirection == CameraLensDirection.front)
        : _cameras.firstWhere(
            (camera) => camera.lensDirection == CameraLensDirection.back);
    _controller = CameraController(_camera, ResolutionPreset.high);

    await _controller.initialize();
    setState(() {
      _isCameraInitialized = true;
    });
  }

  // Take picture
  Future<void> takePicture() async {
    print("Ambil Gambar \n * \n* \n *");
    if (!_controller.value.isInitialized) {
      return;
    }

    final tempDir = await getTemporaryDirectory();
    final filePath =
        '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

    print("Berhasil di simpan \n * \n* \n *");
    // Capture image from camera
    final XFile file = await _controller.takePicture();
    cropImage(file.path);
  }

  // Crop image
  Future<void> cropImage(String imagePath) async {
    print("Cropping \n * \n* \n *");
    try {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: imagePath,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      );

      if (croppedFile != null && croppedFile.path.isNotEmpty) {
        File croppedImageFile = File(croppedFile.path);

        // Check if cropped image is valid and non-empty
        if (await croppedImageFile.exists() &&
            await croppedImageFile.length() > 0) {
          print("Berhasil di Crop dan file valid");
          _updateUserPicture(croppedImageFile);
        } else {
          print("File hasil cropping kosong.");
        }
      } else {
        print("Cropping was canceled or failed.");
      }
    } catch (e) {
      print("Error during cropping: $e");
    }
  }

  // Update user picture
  Future<void> _updateUserPicture(File file) async {
    try {
      if (await file.exists() && await file.length() > 0) {
        final directory = await getTemporaryDirectory();
        final newPath = '${directory.path}/c_${basename(file.path)}';
        final newFile = await file.copy(newPath);

        bool isUpdated = await UserApiHandler().updateUserPicture(newFile);
        if (isUpdated) {
          Fluttertoast.showToast(
            msg: "Foto Profil Berhasil Diperbarui",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else {
          Fluttertoast.showToast(
            msg: "Terjadi Kesalahan Saat Memperbarui Foto Profil",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      } else {
        print("File kosong, tidak bisa mengupdate gambar.");
        Fluttertoast.showToast(
          msg: "Gambar kosong, gagal memperbarui foto profil.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      print("Terjadi Kesalahan: $e");
      Fluttertoast.showToast(
        msg: "Terjadi Kesalahan: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<File> _ensureValidImageFormat(File file) async {
    // Periksa ekstensi dan MIME type
    final allowedExtensions = ['jpeg', 'png', 'gif'];
    final fileExtension = file.path.split('.').last.toLowerCase();
    final mimeType = lookupMimeType(file.path);

    if (allowedExtensions.contains(fileExtension) &&
        mimeType?.startsWith('image/') == true) {
      // Format sudah valid
      return file;
    }

    // Jika format tidak valid, konversi gambar ke format JPEG
    final imageBytes = await file.readAsBytes();
    final decodedImage = img.decodeImage(imageBytes);
    if (decodedImage == null) {
      throw Exception("Gagal membaca file gambar.");
    }

    final directory = await getTemporaryDirectory();
    final convertedPath =
        '${directory.path}/${basenameWithoutExtension(file.path)}.jpeg';

    final convertedImageBytes = img.encodeJpg(decodedImage);
    final convertedFile = File(convertedPath)
      ..writeAsBytesSync(convertedImageBytes);

    return convertedFile;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ambil dan Crop Foto Profil')),
      body: Column(
        children: [
          if (!_isCameraInitialized)
            CircularProgressIndicator()
          else
            Expanded(child: CameraPreview(_controller)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: takePicture,
                child: Text('Ambil Foto'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: switchCamera,
                child: Text('Ganti Kamera'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
