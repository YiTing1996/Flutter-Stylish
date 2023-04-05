import 'package:flutter/material.dart';
import 'package:flutter_stylish/model/viewmodel.dart';

class HomeMobileScaffold extends StatefulWidget {
  const HomeMobileScaffold({super.key});

  @override
  State<HomeMobileScaffold> createState() => _HomeMobileScaffoldState();
}

class _HomeMobileScaffoldState extends State<HomeMobileScaffold> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Image.asset('images/logo.png', width: 120, height: 120),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
                height: 100,
                child: ViewModel(
                  onTapListItem: (p0) {
                    Navigator.pushNamed(context, '/detail', arguments: p0);
                  },
                ).createRowContainer()),
          ),
          SizedBox(
            width: screenWidth * 0.97,
            height: screenHeight - 200,
            child: ListView(
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
    return 
    Column(
        children: [
          Text(sectionHeader),
          ViewModel(
            onTapListItem: (p0) {
              Navigator.pushNamed(context, '/detail', arguments: p0);
            },
          ).createColumnContainer()
        ],
      );
  }
}
