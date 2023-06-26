import 'package:flutter_stylish/page/map.dart';
import 'package:flutter_stylish/page/cart.dart';
import 'package:flutter_stylish/page/detail.dart';
import 'package:flutter_stylish/page/home/home_desktop.dart';
import 'package:flutter_stylish/page/home/home_mobile.dart';
import 'package:flutter_stylish/helper/export/bloc_export.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CartBloc()..add(CartInitialEvent())),
        BlocProvider(create: (_) => ProductBloc()..add(ProductInitialEvent())),
      ],
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
          '/map': (context) => const MapPage(),
          '/cart': (context) => const CartPage(),
        },
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        ),
      ),
    );
  }
}
