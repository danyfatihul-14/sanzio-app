import 'package:flutter/material.dart';
import 'package:raffaelosanzio/pages/history.dart';
import 'package:raffaelosanzio/pages/all_Kategori.dart';
import 'package:raffaelosanzio/pages/view_Kategori.dart';
import 'package:raffaelosanzio/widget/bottom_navbar.dart';
import 'package:raffaelosanzio/pages/login.dart';
import 'package:raffaelosanzio/pages/register.dart';
import 'package:raffaelosanzio/pages/home.dart';
import 'package:raffaelosanzio/pages/mychart.dart';
import 'package:raffaelosanzio/pages/payment.dart';
import 'package:raffaelosanzio/pages/editable_address_page.dart';

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
      initialRoute: '/login',
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/main-home': (context) => const CustomBottomNavbar(),
        '/home': (context) => const HomePage(),
        '/allKategori': (context) => const AllCategoriesPage(categories: [],),
        '/viewkategory': (context) => CategoryProductPage(categoryTitle: '', products: const [],),
        '/history': (context) => const HistoryPage(),
      },
    );
  }
}
