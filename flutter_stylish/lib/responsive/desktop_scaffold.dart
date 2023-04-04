import 'package:flutter/material.dart';
import 'package:flutter_stylish/viewmodel.dart';

class HomeDesktopScaffold extends StatefulWidget {
  const HomeDesktopScaffold({super.key});

  @override
  State<HomeDesktopScaffold> createState() => _HomeDesktopScaffoldState();
}

class _HomeDesktopScaffoldState extends State<HomeDesktopScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'images/logo.png',
          width: 120,
          height: 120,
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: ViewModel(context: context, onTapListItem: (p0) {
                  Navigator.pushNamed(context, '/detail', arguments: p0);
                },).createRowContainer(),
              )
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CategorySection(sectionHeader: "女裝"),
                CategorySection(sectionHeader: "男裝"),
                CategorySection(sectionHeader: "配件"),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CategorySection extends StatelessWidget {
  final String sectionHeader;
  const CategorySection({super.key, required this.sectionHeader});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(sectionHeader),
          Column(
            children: ViewModel(context: context, onTapListItem: (p0) {
              Navigator.pushNamed(context, '/detail', arguments: p0);
            },).createColumnContainer(),
          )
        ],
      ),
    );
  }
}
