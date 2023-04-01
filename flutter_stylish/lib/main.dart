import 'package:flutter/material.dart';
import 'package:flutter_stylish/page/detail.dart';
import 'package:flutter_stylish/page/responsive/home_desktop.dart';
import 'package:flutter_stylish/page/responsive/home_mobile.dart';
import 'package:flutter_stylish/page/responsive/responsive_layout.dart';

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
        '/':(context) => 
        LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return const HomeMobileScaffold();
        } else {
          return const HomeDesktopScaffold();
        }
      }),
        // '/': (context) => ResponsiveLayout(
        //   mobileScaffold: const HomeMobileScaffold(),
        //   desktopScaffold: const HomeDesktopScaffold(),
        // ),
        '/detail': (context) => const DetailPage(),
      },
    );
  }
}