import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stylish/repos/repositories.dart';
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
    return RepositoryProvider(
      create: (context) => ProductRepository(),
      child: MaterialApp(
        initialRoute: '/', 
        routes: {
        '/': (context) => LayoutBuilder(builder: (context, constraints) {
              if (constraints.maxWidth < 600) {
                return const HomeMobilePage();
              } else {
                return const HomeDesktopPage();
              }
            }),
        '/detail': (context) => const DetailPage(),
      },
      ),
    );
  }
}
