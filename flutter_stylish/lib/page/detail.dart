import '../helper/common_export.dart';
import 'package:flutter/material.dart';

final double containerWidth = 400; // TODO: 根據螢幕尺寸決定

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
        child: Center(
          child: Container(
            width: containerWidth,
            child: Column(
              children: [
                Image.asset(
                  'images/cloth.png',
                  width: containerWidth,
                  height: 400,
                  fit: BoxFit.fill,
                ),

                FeatureMenu(
                    title: 'UNIQLO 特級極輕羽絨外套',
                    onPressed: () {
                      debugPrint('ParentView接收到點擊事件');
                    }
                ),
                const SizedBox(height: 10),
                const DescMenu(
                  desc:
                      "O.N.S is all about options, which is why we took our staple polo shirt and upgraded it with slubby linen jersey, making it even lighter for those who prefer their summer style extra-breezy.",
                  images: [
                    'https://picsum.photos/id/238/200/300',
                    'https://picsum.photos/id/239/200/300',
                    'https://picsum.photos/id/240/200/300',
                    'https://picsum.photos/id/241/200/300',
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DescMenu extends StatelessWidget {
  final String desc;
  final List<String> images;

  const DescMenu({
    Key? key,
    required this.desc,
    required this.images,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(desc),
        ListView.builder(
            shrinkWrap: true, // 以防超出螢幕尺寸
            itemCount: images.length,
            itemBuilder: (context, index) {
              return Center( // 需要加Center才可以改圖片大小
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Image.network(images[index], width: containerWidth, height: 300, fit: BoxFit.fill),
                ),
              );
            })
      ],
    );
  }
}

class FeatureMenu extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const FeatureMenu({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: titleTextStyle,
            ),
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '2023032101',
              style: subtitleTextStyle,
            ),
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'NT \$323',
              style: titleTextStyle,
            ),
          ),
          Row(
            children: [
              const Text(
                '顏色',
                style: subtitleTextStyle,
              ),
              const SizedBox(width: 5),
              SqaureColorButton(
                  color: Colors.blue,
                  onPressed: () {
                    debugPrint('點擊藍色按鈕');
                  }),
              const SizedBox(width: 5),
              SqaureColorButton(
                  color: Colors.red,
                  onPressed: () {
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
              const SizedBox(width: 5),
              RoundTextButton(
                  text: 'S',
                  onPressed: () {
                    debugPrint('點擊S按鈕');
                  }),
              const SizedBox(width: 5),
              RoundTextButton(
                  text: 'M',
                  onPressed: () {
                    debugPrint('點擊M按鈕');
                  }),
            ],
          ),
          Row(
            children: [
              const Text(
                '數量',
                style: subtitleTextStyle,
              ),
              NumChangeWidget(onValueChanged: (num) {
                debugPrint('數量改變$num');
              })
            ],
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              debugPrint('點擊選擇尺寸按鈕');
            },
            style: ElevatedButton.styleFrom(
                fixedSize: Size(containerWidth, 50),
                backgroundColor: Colors.black45,
                textStyle: secTitleTextStyle),
            child: const Text(
              '請選擇尺寸',
              style: secTitleTextStyle,
            ),
          ),
          const SizedBox(height: 8),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text('實品顏色依單品照為主\n棉100%\n厚薄:薄\n彈性:無\n素材產地/日本\n加工產地/中國'),
          )
        ],
      ),
    );
  }
}
