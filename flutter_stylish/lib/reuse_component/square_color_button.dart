import 'package:flutter/material.dart';
import 'package:flutter_stylish/helper/extension.dart';
import 'package:flutter_stylish/model/cart.dart';

class SqaureColorButton extends StatefulWidget {
  final CColor color;
  final bool isSelected;
  final void Function(CColor color) onPressed;

  const SqaureColorButton({
    Key? key,
    required this.color,
    required this.isSelected,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<SqaureColorButton> createState() => _SqaureColorButtonState();  
}

class _SqaureColorButtonState extends State<SqaureColorButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        debugPrint('SubView接收到點擊事件');
        widget.onPressed(widget.color);
      },
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          border: Border.all(
            color: widget.isSelected ? Colors.black26 : Colors.black12, 
            width: widget.isSelected ? 1.2 : 0.5
          ),
          color: widget.color.code.toColor(),
          shape: BoxShape.rectangle,
        ),
      ),
    );
  }
}
