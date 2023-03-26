import 'package:flutter/material.dart';

class ViewModel {
  final BuildContext context;
  ViewModel({
    required this.context,
  });

  List<Container> createRowContainer() {
    List<Container> containers = [];
    for (int i = 0; i < 10; i++) {
      containers.add(Container(
          height: 100,
          width: 180,
          margin: const EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset('images/default.jpg', fit: BoxFit.fill),
          )));
    }
    return containers;
  }

  List<Container> createColumnContainer() {
    List<Container> containers = [];
    double screenWidth = MediaQuery.of(context).size.width;
    for (int i = 0; i < 10; i++) {
      containers.add(Container(
          width: screenWidth > 600 ? screenWidth * 0.33 : screenWidth * 0.95,
          height: 90,
          child: Card(
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                color: Colors.grey
              ),
              borderRadius: BorderRadius.circular(10)
            ),
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
                    )
                  )
              ],
            ),
          )
        )
      );
    }
    return containers;
  }
}
