import 'package:flutter/material.dart';
import 'package:flutter_stylish/detail.dart';
import 'package:flutter_stylish/responsive/desktop_scaffold.dart';
import 'package:flutter_stylish/responsive/mobile_scaffold.dart';
import 'package:flutter_stylish/responsive/responsive_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
      return  MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => ResponsiveLayout(
          mobileScaffold: HomeMobileScaffold(),
          desktopScaffold: HomeDesktopScaffold(),
        ),
        '/detail': (context) => DetailPage(),
      },
    );
  }
}