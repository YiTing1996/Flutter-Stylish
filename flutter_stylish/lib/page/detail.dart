import '../helper/common_export.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    final String message = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'images/logo.png',
          width: 120,
          height: 120,
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 判斷螢幕寬度決定怎麼排列
            Image.asset(
              'images/cloth.png',
              width: 300,
              height: 400,
              fit: BoxFit.fill,
            ),
            FeatureMenu(
                title: 'UNIQLO 特級極輕羽絨外套',
                onPressed: () {
                  debugPrint('ParentView接收到點擊事件');
                })
          ],
        ),
      ),
    );
  }
}

class FeatureMenu extends StatelessWidget {
  final String title; // 到時候要傳入Object
  final VoidCallback onPressed;

  const FeatureMenu({required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: titleTextStyle,
        ),
        const Text(
          '2023032101',
          style: subtitleTextStyle,
        ),
        const Text(
          'NT \$323',
          style: titleTextStyle,
        ),
        Row(
          children: [
            const Text(
              '顏色',
              style: subtitleTextStyle,
            ),
            SqaureColorButton(color: Colors.blue, onPressed: () {
              debugPrint('點擊藍色按鈕');
            }),
            SqaureColorButton(color: Colors.red, onPressed: () {
              debugPrint('點擊紅色按鈕');
            })
          ],
        ),
        Row(
          children: [
            const Text(
              '尺寸',
              style: subtitleTextStyle,
            ),
            RoundTextButton(text: 'S', onPressed: () {
              debugPrint('點擊S按鈕');
            }),
            RoundTextButton(text: 'M', onPressed: () {
              debugPrint('點擊M按鈕');
            }),
          ],
        )
      ],
    );
  }
}