import 'package:flutter/material.dart';
import 'package:flutter_stylish/helper/style_constant.dart';

class RoundTextButton extends StatefulWidget {
  final String text;
  final void Function(String text) onPressed;
  final bool isSelected;

  const RoundTextButton({
    Key? key,
    required this.text,
    required this.isSelected,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<RoundTextButton> createState() => _RoundTextButtonState();
}

class _RoundTextButtonState extends State<RoundTextButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onPressed(widget.text);
      },
      child: Container(
        alignment: Alignment.center,
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          border: Border.all(
              width: widget.isSelected ? 1.2 : 0.5,
              color: widget.isSelected ? Colors.black26 : Colors.white),
          color: Colors.grey,
          shape: BoxShape.circle,
        ),
        child: Text(widget.text, style: secSubtitleTextStyle),
      ),
    );
  }
}
