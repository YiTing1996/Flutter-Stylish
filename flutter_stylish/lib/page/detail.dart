import '../helper/export/common_export.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Product? productDetail;
  double screenWidth = 0;
  double screenHeight = 0;
  int productId = 0;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    productId = ModalRoute.of(context)!.settings.arguments as int;

    return BlocProvider(
        create: (context) => DetailBloc(productId)..add(DetailInitialEvent()),
        child: Scaffold(
          appBar: AppBar(
            title: Image.asset(
              'assets/logo.png',
              width: 120,
              height: 120,
            ),
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.black12),
            actions: [
              Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/cart');
                    },
                    child: const Icon(
                      Icons.add_shopping_cart,
                      color: Colors.black12,
                      size: 26.0,
                    ),
                  ))
            ],
          ),
          body: BlocBuilder<DetailBloc, DetailState>(
            builder: (context, state) {
              if (state is DetailLoadingState) {
                return const Center(
                    child: CircularProgressIndicator.adaptive(
                        valueColor: AlwaysStoppedAnimation(Colors.grey)));
              } else if (state is DetailErrorState) {
                return const Center(child: Text('Error'));
              } else if (state is DetailLoadedState) {
                productDetail = state.product;
                return body();
              }
              return Container();
            },
          ),
        )
        // }
        );
  }

  Widget body() {
    bool isWide = screenWidth > 650 ? true : false;
    double containerWidth = isWide ? 620 : 350;
    return SingleChildScrollView(
      child: Center(
        child: SizedBox(
          width: containerWidth,
          child: Column(
            children: [
              if (isWide) ...[
                // desktop
                Row(
                  children: [
                    Image.network(
                      productDetail?.mainImage ?? "",
                      width: 300,
                      height: 400,
                      fit: BoxFit.fill,
                    ),
                    const SizedBox(width: 10),
                    const FeatureMenu(),
                  ],
                )
              ] else ...[
                // mobile
                Image.network(
                  productDetail?.mainImage ?? "",
                  width: 350,
                  height: 400,
                  fit: BoxFit.fill,
                ),
                const FeatureMenu()
              ],
              const SizedBox(height: 10),
              DescMenu(
                  containerWidth: containerWidth,
                  isWide: isWide,
                  desc: productDetail?.story ?? "",
                  images: productDetail?.images ?? [])
            ],
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
  final bool isWide;

  const DescMenu(
      {Key? key,
      required this.desc,
      required this.images,
      required this.containerWidth,
      required this.isWide})
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
                      width: containerWidth,
                      height: isWide ? 300 : 300,
                      fit: BoxFit.fill),
                ),
              );
            })
      ],
    );
  }
}

class FeatureMenu extends StatefulWidget {
  const FeatureMenu({super.key});

  @override
  State<FeatureMenu> createState() => _FeatureMenuState();
}

class _FeatureMenuState extends State<FeatureMenu> {
  Product? detail;

  int selectedCount = 0;
  String selectedSize = "";
  CColor selectedColor = CColor(code: "", name: "");

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailBloc, DetailState>(
      builder: (context, state) {
        if (state is DetailLoadingState) {
          return const Center(
              child: CircularProgressIndicator.adaptive(
                  valueColor: AlwaysStoppedAnimation(Colors.grey)));
        } else if (state is DetailErrorState) {
          return const Center(child: Text('Error'));
        } else if (state is DetailLoadedState) {
          detail = state.product;
          return body();
        }
        return Container(); // 都沒有接收到的狀態
      },
    );
  }

  Widget body() {
    return SizedBox(
      width: 300,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              detail?.title ?? "",
              style: titleTextStyle,
            ),
            Text(
              detail?.id.toString() ?? "",
              style: subtitleTextStyle,
            ),
            Text(
              'NT\$ ${detail?.price ?? ""}',
              style: titleTextStyle,
            ),
            getColorButton(detail?.colors ?? []),
            getSizeButton(detail?.sizes ?? []),
            getCountButton(),
            const SizedBox(height: 8),
            BlocBuilder<CartBloc, CartState>(builder: (context, state) {
              if (state is CartLoadingState) {
                return const Center(
                    child: CircularProgressIndicator.adaptive(
                        valueColor: AlwaysStoppedAnimation(Colors.grey)));
              } else if (state is CartLoadedState) {
                return ElevatedButton(
                  onPressed: () {
                    debugPrint('點擊加入購物車');
                    context.read<CartBloc>().add(CartAddedEvent(CartItem(
                        id: detail?.id ?? 0,
                        title: detail?.title ?? "",
                        price: detail?.price ?? 0,
                        color: selectedColor,
                        size: selectedSize,
                        mainImage: detail?.mainImage ?? "",
                        stock: selectedCount)));
                    showOkDialog(context, 'Success Add To Cart', 'Check items in shopping cart 🛒');
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(300, 50),
                      backgroundColor: Colors.black45,
                      textStyle: secTitleTextStyle),
                  child: const Text(
                    '加入購物車',
                    style: secTitleTextStyle,
                  ),
                );
              } else {
                return const Center(child: Text('Error'));
              }
            }),
            const SizedBox(height: 8),
            Text(
                '${detail?.note ?? ""}\n${detail?.texture ?? ""}\n${detail?.description ?? ""}\n產地：${detail?.place ?? ""}')
          ],
        ),
      ),
    );
  }

  Row getCountButton() {
    return Row(
      children: [
        const Text(
          '數量',
          style: subtitleTextStyle,
        ),
        NumChangeWidget(onValueChanged: (selected) {
          debugPrint('數量改變$selected');
          setState(() {
            selectedCount = selected;
          });
        })
      ],
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
                isSelected: selectedSize == size,
                onPressed: (selected) {
                  debugPrint('點擊$selected按鈕');
                  setState(() {
                    selectedSize = selected;
                  });
                }),
          ),
        ]
      ],
    );
  }

  Row getColorButton(List<PColor> colors) {
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
                color: CColor(code: color.code, name: color.name),
                isSelected: selectedColor.code == color.code,
                onPressed: (selected) {
                  debugPrint('點擊${selected.name}按鈕');
                  setState(() {
                    selectedColor = selected;
                  });
                }),
          ),
        ]
      ],
    );
  }
}
