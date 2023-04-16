import 'package:flutter/material.dart';
import 'package:flutter_stylish/page/base_page.dart';
import 'package:flutter_stylish/helper/common_export.dart';

class HomeDesktopPage extends BasePageScreen {
  const HomeDesktopPage({Key? key}) : super(key: key);
  @override
  State<HomeDesktopPage> createState() => _HomeDesktopPageState();
}

class _HomeDesktopPageState extends BasePageScreenState<HomeDesktopPage>
    with BaseScreen {
  @override
  Widget body() {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 100,
          child: createRowContainer(),
        ),
      ),
      Expanded(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(children: [
            const Text("女裝"),
            SizedBox(
              width: screenWidth * 0.33,
              height: screenHeight - 200,
              child: createColumnContainer(CategoryType.women),
            )
          ]),
          Column(children: [
            const Text("男裝"),
            SizedBox(
              width: screenWidth * 0.33,
              height: screenHeight - 200,
              child: createColumnContainer(CategoryType.men),
            )
          ]),
          Column(children: [
            const Text("配件"),
            SizedBox(
              width: screenWidth * 0.33,
              height: screenHeight - 200,
              child: createColumnContainer(CategoryType.accessories),
            )
          ]),
        ],
      ))
    ]);
  }
}