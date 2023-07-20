// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:project_4them/homepage.dart';
import 'package:project_4them/video.dart';

void main() {
  runApp(const App_4Them());
}

class App_4Them extends StatelessWidget {
  const App_4Them({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'Product Sans',
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(backgroundColor: Colors.white)),
      home: const WhatsAppVideoTutorial(),
    );
  }
}
