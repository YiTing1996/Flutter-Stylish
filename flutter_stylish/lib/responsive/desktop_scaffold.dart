import 'package:flutter/material.dart';
import 'package:flutter_stylish/viewmodel.dart';

class DesktopScaffold extends StatefulWidget {
  const DesktopScaffold({super.key});

  @override
  State<DesktopScaffold> createState() => _DesktopScaffoldState();
}

class _DesktopScaffoldState extends State<DesktopScaffold> {
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
                children: ViewModel(context: context).createRowContainer(),
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
            children: ViewModel(context: context).createColumnContainer(),
          )
        ],
      ),
    );
  }
}
