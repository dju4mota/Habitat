import 'package:flutter/material.dart';
import 'package:habitat/src/widgets/ImageButton.dart';

import '../widgets/ButtonElipse.dart';

class PostingListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 220, 221, 203),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 50, 10, 10),
                  child: Text(
                    "Postar em:",
                    style: TextStyle(fontSize: 40),
                  ),
                ),
              ],
            ),
          ]),
    );
  }
}
