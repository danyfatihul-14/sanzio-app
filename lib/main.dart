import 'package:flutter/material.dart';
import 'package:raffaelosanzio/pages/history.dart';
import 'package:raffaelosanzio/pages/mychart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HistoryPage(),
    );
  }
}
