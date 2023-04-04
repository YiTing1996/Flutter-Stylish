import 'package:flutter/material.dart';

class SqaureColorButton extends StatefulWidget {
  final Color color;
  final VoidCallback onPressed;

  const SqaureColorButton({
    Key? key,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  _SqaureColorButtonState createState() => _SqaureColorButtonState();
}

class _SqaureColorButtonState extends State<SqaureColorButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        debugPrint('SubView接收到點擊事件');
        widget.onPressed;
      },
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: widget.color,
          shape: BoxShape.rectangle,
        ),
      ),
    );
  }
}
