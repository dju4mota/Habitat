import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FooterMenu extends StatelessWidget {
  final Color corBotao = Color.fromARGB(255, 1, 48, 108);
  FooterMenu();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 223, 225, 227),
          border: Border.all(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // 4 buttons
          CupertinoButton(
            onPressed: () {
              if (ModalRoute.of(context)!.settings.name != "/home") {
                Navigator.of(context).pushNamed('/home');
              }
            },
            child: Icon(Icons.home, color: corBotao, size: 35),
          ),
          CupertinoButton(
            onPressed: () {
              if (ModalRoute.of(context)!.settings.name != "/home") {
                Navigator.of(context).pushNamed('/home');
              }
            },
            child: Icon(Icons.search, color: corBotao, size: 35),
          ),
          CupertinoButton(
            onPressed: () {
              if (ModalRoute.of(context)!.settings.name != "/posting") {
                Navigator.of(context).pushNamed('/posting');
              }
            },
            child: Icon(Icons.add, color: corBotao, size: 35),
          ),
          CupertinoButton(
            onPressed: () {
              if (ModalRoute.of(context)!.settings.name != "/profile") {
                Navigator.of(context).pushNamed('/profile');
              }
            },
            child: Icon(Icons.person, color: corBotao, size: 35),
          ),
        ],
      ),
    );
  }
}
