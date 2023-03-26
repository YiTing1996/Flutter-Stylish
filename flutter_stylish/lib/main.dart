import 'package:flutter/material.dart';
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ResponsiveLayout(
        mobileScaffold: const MobileScaffold(), 
        desktopScaffold: const DesktopScaffold()
        ),
    );
  }
}