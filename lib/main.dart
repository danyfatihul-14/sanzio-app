import 'package:flutter/material.dart';
import 'package:raffaelosanzio/pages/editable_address_page.dart';
import 'package:raffaelosanzio/pages/mychart.dart';
import 'package:raffaelosanzio/pages/onboarding.dart';
import 'package:raffaelosanzio/pages/payment.dart';
import 'package:raffaelosanzio/pages/login.dart';
import 'package:raffaelosanzio/pages/register.dart';
import 'package:raffaelosanzio/pages/home.dart';
import 'package:raffaelosanzio/pages/rincian_pesanan.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping Cart',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: OnboardingScreen(), // Corrected this line
    );
  }
}
