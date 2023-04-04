import 'package:flutter/material.dart';

class ViewModel {
  final void Function(String) onTapListItem; // define callback

  ViewModel({
    required this.onTapListItem,
  });

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
              onTapListItem("點擊Row$index");
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

  ListView createColumnContainer() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            onTapListItem("點擊Column$index");
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
                    child: Image.asset(
                      'images/default.jpg',
                      height: 90,
                      fit: BoxFit.fill,
                    )),
                Expanded(
                    flex: 70,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                            child: Text("UNIQULO 特級極輕羽絨外套"),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                            child: Text("NT \$323"),
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
