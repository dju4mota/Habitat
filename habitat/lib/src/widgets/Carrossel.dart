import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
];

class Carrossel extends StatelessWidget {
  const Carrossel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<int> list = [1, 2, 3, 4, 5, 6];
    return CarouselSlider(
      options: CarouselOptions(
          //aspectRatio: 1.0521,
          ),
      items: list
          .map((item) => Container(
                height: 50,
                child: Center(child: Text(item.toString())),
                color: Colors.green,
              ))
          .toList(),
    );
  }
}
