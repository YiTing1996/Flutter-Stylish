import 'package:flutter/material.dart';
import 'package:flutter_stylish/helper/common_export.dart';

class RoundTextButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const RoundTextButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  _RoundTextButtonState createState() => _RoundTextButtonState();
}

class _RoundTextButtonState extends State<RoundTextButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        debugPrint('SubView接收到點擊事件');
        widget.onPressed;
      },
      child: Container(
        alignment: const Alignment(0, 0),
        width: 20,
        height: 20,
        decoration: const BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.circle,
        ),
        child: Text(widget.text, style: secSubtitleTextStyle),
      ),
    );
  }
}
