import 'package:flutter/material.dart';
import 'package:raffaelosanzio/auth/auth_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    isLogin();
  }

  Future<void> isLogin() async {
    // Simulate a token validation process
    bool isValid = await AuthHandler().validateToken();

    if (isValid) {
      Navigator.pushReplacementNamed(context, '/main-home');
    } else {
      Navigator.pushReplacementNamed(context, '/onboard');
    }
  }

  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Splash Screen"),
      ),
    );
  }
}
