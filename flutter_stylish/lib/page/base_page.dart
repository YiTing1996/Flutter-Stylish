import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stylish/helper/common_export.dart';
import 'package:flutter_stylish/model/product.dart';

abstract class BasePageScreen extends StatefulWidget {
  const BasePageScreen({super.key});
}

abstract class BasePageScreenState<Page extends BasePageScreen>
    extends State<Page> {}

mixin BaseScreen<Page extends BasePageScreen> on BasePageScreenState<Page> {
  List<Detail>? womenList;
  List<Detail>? menList;
  List<Detail>? accessoryList;

  Widget body();
  double screenWidth = 0;
  double screenHeight = 0;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
        create: (context) => ProductBloc(
              RepositoryProvider.of<ProductRepository>(context),
              EndPoint.all,
            )..add(LoadProductEvent()),
        child: Scaffold(
          appBar: AppBar(
            title: Image.asset(
              'images/logo.png',
              width: 120,
              height: 120,
            ),
            backgroundColor: Colors.white,
          ),
          body: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoadingState) {
                return const Center(
                    child: CircularProgressIndicator.adaptive(
                        valueColor: AlwaysStoppedAnimation(Colors.grey)));
              } else if (state is ProductErrorState) {
                return const Center(child: Text('Error'));
              } else if (state is ProductLoadedState) {
                // 拆成三個List
                Map<String, List<Detail>> categoryMap = {};
                for (Detail detail in state.products) {
                  if (!categoryMap.containsKey(detail.category)) {
                    categoryMap[detail.category] = [];
                  }
                  categoryMap[detail.category]!.add(detail);
                }
                womenList = categoryMap[CategoryType.women.rawValue()];
                menList = categoryMap[CategoryType.men.rawValue()];
                accessoryList = categoryMap[CategoryType.accessories.rawValue()];
                return body();
              }
              return Container(); // 都沒有接收到的狀態
            },
          ),
        ));
  }

  GridView createRowContainer() {
    return GridView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: 10,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // TODO: 帶入ID
              Navigator.pushNamed(context, '/detail', arguments: index);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'images/default.jpg',
                fit: BoxFit.fill,
              ),
            ),
          );
        });
  }

  ListView createColumnContainer(CategoryType category) {
    List<Detail> getCategoryList(CategoryType type) {
      switch (type) {
        case CategoryType.men:
          return menList ?? [];
        case CategoryType.women:
          return womenList ?? [];
        case CategoryType.accessories:
          return accessoryList ?? [];
      }
    }

    var categoryList = getCategoryList(category);

    return ListView.builder(
      shrinkWrap: true,
      itemCount: categoryList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/detail',
                arguments: categoryList[index].id);
          },
          child: Card(
            shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(10)),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 30,
                    child: Image.network(
                      categoryList[index].mainImage,
                      height: 90,
                      fit: BoxFit.fill,
                    )),
                Expanded(
                    flex: 70,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                            child: Text(categoryList[index].title),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                            child: Text('\$${categoryList[index].price}')
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}