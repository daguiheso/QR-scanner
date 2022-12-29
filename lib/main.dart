import 'package:flutter/material.dart';

import 'package:qr_reader/pages/home_page.dart';
import 'package:qr_reader/pages/map_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Reder',
      initialRoute: 'home',
      routes: {
        'home': (_) => const HomePage(),
        'map': (_) => const MapPage(),
      },
    );
  }
}