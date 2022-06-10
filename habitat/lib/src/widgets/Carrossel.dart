import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

final List<Image> imgList = [
  Image.asset("assests/materias/programming1.jpg"),
];

class Carrossel extends StatelessWidget {
  const Carrossel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(),
      items: imgList,
    );
  }
}
