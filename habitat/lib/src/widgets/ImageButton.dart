import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ImageButton extends StatelessWidget {
  String image;
  Function onPressed;
  String label;
  ImageButton(this.image, this.onPressed, this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 5.0),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 1, 48, 108),
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
            style: const TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 220, 221, 203),
            ),
          ),
        ],
      ),
    );
  }
}
