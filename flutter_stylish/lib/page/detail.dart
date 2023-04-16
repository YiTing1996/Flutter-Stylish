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
    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = screenWidth > 650 ? 620 : 300;
    final int productId = ModalRoute.of(context)!.settings.arguments as int;

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
          child: SizedBox(
            width: containerWidth,
            child: Column(
              children: [
                if (screenWidth > 650) ...[
                  // desktop
                  Row(
                    children: [
                      Image.asset(
                        'images/cloth.png',
                        width: 300,
                        height: 400,
                        fit: BoxFit.fill,
                      ),
                      const SizedBox(width: 10),
                      FeatureMenu(
                          title: 'UNIQLO 特級極輕羽絨外套',
                          onPressed: () {
                            debugPrint('ParentView接收到點擊事件');
                          }),
                    ],
                  )
                ] else ...[
                  // mobile
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
                      }),
                ],
                const SizedBox(height: 10),
                DescMenu(
                  containerWidth: containerWidth,
                  desc:
                      "O.N.S is all about options, which is why we took our staple polo shirt and upgraded it with slubby linen jersey, making it even lighter for those who prefer their summer style extra-breezy.",
                  images: const [
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
  final double containerWidth;

  const DescMenu(
      {Key? key,
      required this.desc,
      required this.images,
      required this.containerWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            ShaderMask(
              // 需要透過ShaderMask才不會隨視窗改變漸層
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 146, 65, 161),
                    Color.fromARGB(255, 70, 189, 189)
                  ],
                ).createShader(Offset.zero & bounds.size);
              },
              child: const Center(
                child: Text('細部說明', style: secSubtitleTextStyle),
              ),
            ),
            const Expanded(
                child: // 需要放在Expanded才有足夠的寬度
                    Divider(thickness: 1.0, indent: 20, color: Colors.black26))
          ],
        ),
        Text(desc),
        ListView.builder(
            shrinkWrap: true, // 以防超出螢幕尺寸
            itemCount: images.length,
            itemBuilder: (context, index) {
              return Center(
                // 需要加Center才可以改圖片大小
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Image.network(images[index],
                      width: containerWidth, height: 300, fit: BoxFit.fill),
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
    return SizedBox(
      width: 300,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            getColorButton([Colors.blue, Colors.green]),
            getSizeButton(['S', 'M']),
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
                  fixedSize: const Size(300, 50),
                  backgroundColor: Colors.black45,
                  textStyle: secTitleTextStyle),
              child: const Text(
                '請選擇尺寸',
                style: secTitleTextStyle,
              ),
            ),
            const SizedBox(height: 8),
            const Text('實品顏色依單品照為主\n棉100%\n厚薄:薄\n彈性:無\n素材產地/日本\n加工產地/中國')
          ],
        ),
      ),
    );
  }

  Row getSizeButton(List<String> sizes) {
    return Row(
      children: [
        const Text(
          '尺寸',
          style: subtitleTextStyle,
        ),
        const SizedBox(width: 5),
        for (var size in sizes) ...[
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: RoundTextButton(
                text: size,
                onPressed: () {
                  debugPrint('點擊S按鈕');
                }),
          ),
        ]
      ],
    );
  }

  Row getColorButton(List<Color> colors) {
    return Row(
      children: [
        const Text(
          '顏色',
          style: subtitleTextStyle,
        ),
        const SizedBox(width: 5),
        for (var color in colors) ...[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: SqaureColorButton(
                color: color,
                onPressed: () {
                  debugPrint('點擊藍色按鈕');
                }),
          ),
        ]
      ],
    );
  }
}
