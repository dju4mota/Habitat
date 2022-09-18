import 'package:flutter/material.dart';

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
    this.cor = const Color.fromARGB(255, 3, 69, 135),
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
              scale: 0.1,
            ),
            iconSize: MediaQuery.of(context).size.height * 0.12,
          ),
          Text(
            label.split(" ")[0],
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.03,
              color: corFonte,
            ),
          ),
        ],
      ),
    );
  }
}
