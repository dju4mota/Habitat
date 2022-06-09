import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonElipse extends StatelessWidget {
  String text;
  Color backgroundColor;
  Color fontColor;
  Function route;
  ButtonElipse(
    this.text,
    this.route, {
    this.backgroundColor = const Color.fromARGB(255, 220, 221, 203),
    this.fontColor = const Color.fromARGB(255, 1, 48, 108),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 350,
        child: ElevatedButton(
          onPressed: () {
            this.route();
          },
          child: Text(
            text,
            style: TextStyle(fontSize: 30, color: fontColor, fontWeight: FontWeight.w400),
          ),
          style: ElevatedButton.styleFrom(
              primary: backgroundColor,
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(color: fontColor),
              )),
        ),
      ),
    );
  }
}
