import 'package:flutter/material.dart';
import 'package:flutter_stylish/page/base_page.dart';
import 'package:flutter_stylish/helper/common_export.dart';

class HomeMobilePage extends BasePageScreen {
  const HomeMobilePage({Key? key}) : super(key: key);
  @override
  State<HomeMobilePage> createState() => _HomeMobilePageState();
}

class _HomeMobilePageState extends BasePageScreenState<HomeMobilePage>
    with BaseScreen {
  @override
  Widget body() {
    return Column(children: <Widget>[
      Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(height: 100, child: createRowContainer())),
      SizedBox(
        width: screenWidth * 0.97,
        height: screenHeight - 200,
        child: ListView(
          children: [
            Column(
              children: [const Text("女裝"), createColumnContainer(CategoryType.women)],
            ),
            Column(
              children: [const Text("男裝"), createColumnContainer(CategoryType.men)],
            ),
            Column(
              children: [const Text("配件"), createColumnContainer(CategoryType.accessories)],
            ),
          ],
        ),
      )
    ]);
  }
}