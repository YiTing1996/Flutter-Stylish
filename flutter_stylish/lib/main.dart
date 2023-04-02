import 'package:flutter/material.dart';
import 'package:flutter_stylish/page/detail.dart';
import 'package:flutter_stylish/page/home/home_desktop.dart';
import 'package:flutter_stylish/page/home/home_mobile.dart';

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
        '/': (context) => 
        LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return const HomeMobileScaffold();
        } else {
          return const HomeDesktopScaffold();
        }}),
        '/detail': (context) => const DetailPage(),
      },
    );
  }
}