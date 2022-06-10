import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class FooterMenu extends StatelessWidget {
  Function routeHome;
  Function routeSearch;
  Function routeAdd;
  Function routePerson;
  final Color corBotao = Color.fromARGB(255, 1, 48, 108);
  FooterMenu(this.routeHome, this.routeSearch, this.routeAdd, this.routePerson);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // 4 buttons
          CupertinoButton(
            onPressed: () => {},
            child: Icon(Icons.home, color: corBotao, size: 35),
          ),
          CupertinoButton(
            onPressed: () => {},
            child: Icon(Icons.search, color: corBotao, size: 35),
          ),
          CupertinoButton(
            onPressed: () => {},
            child: Icon(Icons.add, color: corBotao, size: 35),
          ),
          CupertinoButton(
            onPressed: () => {},
            child: Icon(Icons.person, color: corBotao, size: 35),
          ),
        ],
      ),
    );
  }
}
