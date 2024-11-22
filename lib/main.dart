import 'package:flutter/material.dart';
import 'package:raffaelosanzio/pages/info_pengguna.dart';
import 'package:raffaelosanzio/pages/profile.dart';
import 'pages/login.dart';
import 'pages/register.dart';
// import 'pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Raffaelo Sanzio',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/profile', // Start with the login page
      debugShowCheckedModeBanner: false,
      routes: {
        // '/login': (context) => const LoginPage(),
        // '/register': (context) => const RegisterPage(),
        '/profile': (context) => const MyProfile(),
        '/profile/information': (context) => const MyInformasiPengguna(),
        // '/home': (context) => HomePage(),
      },
    );
  }
}
