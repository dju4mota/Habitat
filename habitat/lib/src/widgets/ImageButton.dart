import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ImageButton extends StatelessWidget {
  String image;
  Function onPressed;
  String label;
  Color cor;
  Color corFonte;
  ImageButton(
    this.image,
    this.onPressed,
    this.label, {
    this.cor = const Color.fromARGB(255, 1, 48, 108),
    this.corFonte = const Color.fromARGB(255, 220, 221, 203),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 5.0),
      decoration: BoxDecoration(
        color: cor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          IconButton(
            onPressed: () {
              onPressed();
            },
            icon: Image.asset(
              image,
              scale: 0.2,
            ),
            iconSize: 100,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 20,
              color: corFonte,
            ),
          ),
        ],
      ),
    );
  }
}
