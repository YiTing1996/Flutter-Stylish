import 'package:flutter/material.dart';
import 'package:flutter_stylish/viewmodel.dart';

class MobileScaffold extends StatefulWidget {
  const MobileScaffold({super.key});

  @override
  State<MobileScaffold> createState() => _MobileScaffoldState();
}

class _MobileScaffoldState extends State<MobileScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('images/logo.png', width: 120, height: 120),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: ViewModel(context: context).createRowContainer(),
              )
            ),
            const CategorySection(sectionHeader: "女裝"),
            const CategorySection(sectionHeader: "男裝"),
            const CategorySection(sectionHeader: "配件"),
          ],
        ),
      ),
    );
  }
}

class CategorySection extends StatelessWidget {
  final String sectionHeader;

  const CategorySection({
    super.key,
    required this.sectionHeader
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text(sectionHeader)],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: ViewModel(context: context).createColumnContainer(),
        )
      ],
    );
  }
}