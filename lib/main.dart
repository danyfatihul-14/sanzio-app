import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raffaelosanzio/blocs/cart/cart_bloc.dart';
import 'package:raffaelosanzio/pages/about.dart';
import 'package:raffaelosanzio/pages/ganti_password.dart';
import 'package:raffaelosanzio/pages/history.dart';
import 'package:raffaelosanzio/pages/all_Kategori.dart';
import 'package:raffaelosanzio/pages/home.dart';
import 'package:raffaelosanzio/pages/info_pengguna.dart';
import 'package:raffaelosanzio/pages/kebijakan.dart';
import 'package:raffaelosanzio/pages/login.dart';
import 'package:raffaelosanzio/pages/mychart.dart';
import 'package:raffaelosanzio/pages/onboarding.dart';
import 'package:raffaelosanzio/pages/profile.dart';
import 'package:raffaelosanzio/pages/register.dart';
import 'package:raffaelosanzio/pages/rincian_pesanan.dart';
import 'package:raffaelosanzio/pages/success.dart';
import 'package:raffaelosanzio/pages/view_Kategori.dart';
import 'package:raffaelosanzio/shared/theme.dart';
import 'package:raffaelosanzio/widget/bottom_navbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartBloc(),
      child: MaterialApp(
        title: 'Raffaelo Sanzio',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryColor: whiteMain,
        ),
        initialRoute: '/onboard',
        debugShowCheckedModeBanner: false,
        routes: {
          '/login': (context) => const LoginPage(),
          '/register': (context) => const RegisterPage(),
          '/main-home': (context) => const CustomBottomNavbar(),
          '/home': (context) => const HomePage(),
          '/allKategori': (context) => const AllCategoriesPage(
                categories: [],
              ),
          '/viewkategory': (context) => const CategoryProductPage(
                categoryTitle: '',
                products: [],
              ),
          '/history': (context) => const HistoryPage(),
          '/cart': (context) => const ShoppingCartPage(),
          '/success': (context) => LoadingToFlipCheck(),
          '/onboard': (context) => OnboardingScreen(),
          '/rimcian': (context) => Rincian(),
          '/profile': (context) => MyProfile()
        },
      ),
    );
  }
}
