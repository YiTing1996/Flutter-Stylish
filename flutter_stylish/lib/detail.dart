import 'package:flutter/material.dart';

// class DetailPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final String message = ModalRoute.of(context)!.settings.arguments as String;

//     return Scaffold(
//       body: Center(
//         child: Text('$message'),
//       ),
//     );
//   }
// }

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
      body: Column(
        children: [Text(message)],
        // children: [
        //   SingleChildScrollView(
        //       scrollDirection: Axis.horizontal,
        //       child: Text(''),
        //   ),
        // ],
      ),
    );
  }
}