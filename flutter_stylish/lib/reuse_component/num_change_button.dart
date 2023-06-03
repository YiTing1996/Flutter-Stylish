import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stylish/helper/style_constant.dart';

class NumChangeWidget extends StatefulWidget {
  final double height;
  final double width;
  final double iconWidth;
  final String numText;
  final ValueChanged onValueChanged;

  const NumChangeWidget({
    Key? key,
   this.height = 50,
   this.width = 150,
   this.iconWidth = 50,
   this.numText = '0',
   required this.onValueChanged,
  }) : super(key: key);

  @override
  State<NumChangeWidget> createState() => _NumChangeWidgetState();
}

class _NumChangeWidgetState extends State<NumChangeWidget> {
  var textController= TextEditingController();

  @override
  void initState() {
    super.initState();
    textController.text = widget.numText;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          height: widget.height,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              customIconButton(icon: Icons.remove_circle, isAdd: false),
              SizedBox(
                width: widget.width,
                child: TextField(
                  controller: textController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  inputFormatters: [ // 只允許輸入數字
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  ],
                  style: subtitleTextStyle,
                  enableInteractiveSelection: false,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 0, top: 2, bottom: 2, right: 0),
                    border: InputBorder.none // 去除底部的線
                  ),
                  onChanged: (String text) {
                    widget.onValueChanged(text);
                  },
                ),
              ),
              customIconButton(icon: Icons.add_circle, isAdd: true),
            ],
          ),
        )
      ],
    );
  }

 Widget customIconButton({ required IconData icon, required bool isAdd}) {
    return SizedBox(
      width: widget.iconWidth,
      child:IconButton(
        padding: const EdgeInsets.all(0),
        icon: Icon(icon, color: Colors.black87,),
        onPressed: (){
          var num = int.parse(textController.text);
          if(!isAdd&&num == 0) return;
          if(isAdd) {
            num ++;
          }
          else {
            num --;
          }
          textController.text = '$num';
          widget.onValueChanged(num);
        },
      ),
    );
  }
}
