import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:habitat/src/view/QuestionView.dart';

class QuestionList extends StatelessWidget {
  // final String subject;
  List questions = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z"
  ];
  // QuestionList(this.subject);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 220, 221, 203),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
          ),
          IconButton(
              onPressed: () => {Navigator.of(context).pop()},
              icon: Icon(Icons.arrow_back)),
          Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: ItemList(questions[index]),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  String txt;
  ItemList(this.txt);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          txt,
          style: TextStyle(
            color: Color.fromARGB(255, 5, 54, 116),
          ),
        ),
        IconButton(
          icon: Icon(Icons.arrow_right_alt_sharp),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => QuestionView(),
              ),
            );
          },
        )
      ],
    );
  }
}
