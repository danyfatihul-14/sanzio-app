import 'package:flutter/material.dart';
import 'package:raffaelosanzio/auth/auth_handler.dart';
import 'package:raffaelosanzio/blocs/cart/cart_bloc.dart';
import 'package:raffaelosanzio/blocs/cart/cart_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), isLogin);
  }

  Future<void> isLogin() async {
    // Simulate a token validation process
    bool isValid = await AuthHandler().validateToken();

    if (isValid && mounted) {
      context.read<CartBloc>().add(LoadCartFromHive());
      Navigator.pushReplacementNamed(context, '/main-home');
    } else {
      Navigator.pushReplacementNamed(context, '/onboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/BG-data.png',
              fit: BoxFit.cover, // Makes the image cover the entire screen
            ),
          ),
          // Foreground Image
          Center(
            child: Image.asset(
              'assets/type5.png',
              width: 250,
              height: 150,
            ),
          ),
        ],
      ),
    );
  }
}