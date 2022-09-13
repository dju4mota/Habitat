import 'package:flutter/material.dart';

import '../utils/utils.dart';

class ButtonElipse extends StatefulWidget {
  String text;
  Color backgroundColor;
  Color fontColor;
  double width;
  double fontSize;
  Function route;
  ButtonElipse(
    this.text,
    this.route, {
    this.width = 350,
    this.fontSize = 30,
    this.backgroundColor = Util.fundoClaro,
    this.fontColor = Util.azulEscuroBotao,
  });

  @override
  State<ButtonElipse> createState() => _ButtonElipseState();
}

class _ButtonElipseState extends State<ButtonElipse> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: widget.width,
        child: ElevatedButton(
          onPressed: () {
            this.widget.route();
          },
          child: Text(
            widget.text,
            style: TextStyle(fontSize: widget.fontSize, color: widget.fontColor, fontWeight: FontWeight.w400),
          ),
          style: ElevatedButton.styleFrom(
              primary: widget.backgroundColor,
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(color: widget.fontColor),
              )),
        ),
      ),
    );
  }
}
