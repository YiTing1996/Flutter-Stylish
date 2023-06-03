import 'package:flutter/material.dart';
import 'package:flutter_stylish/helper/style_constant.dart';

Future<dynamic> showOkDialog(
  BuildContext context,
  String title, 
  String content) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title, style: titleTextStyle),
          content: Text(content, style: subtitleTextStyle),
          actions: <Widget>[
            Center(
              child: TextButton(
                style: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(Colors.black)),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ),
          ],
        );
      });
}