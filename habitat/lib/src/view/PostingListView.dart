import 'package:flutter/material.dart';
import 'package:habitat/src/widgets/ImageButton.dart';

import '../widgets/ButtonElipse.dart';

class PostingListView extends StatelessWidget {
  List materias = [
    "C204 - Alg 3 ",
    "E207 - Elt. Digital 1",
    "M004 - Cálculo 2",
    "F207 - Física",
    "C204 - Alg 3 ",
    "E207 - Elt. Digital 1",
    "M004 - Cálculo 2",
    "F207 - Física",
    "C204 - Alg 3 ",
    "E207 - Elt. Digital 1",
    "M004 - Cálculo 2",
    "F207 - Física",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 220, 221, 203),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 50, 10, 0),
            child: Text(
              "Postar em:",
              style: TextStyle(
                fontSize: 40,
                color: Color.fromARGB(255, 5, 54, 116),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.76,
            child: ListView.builder(
              itemCount: materias.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Materia(materias[index]),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ButtonElipse(
                "Postar",
                () => {},
                width: 100,
                fontSize: 20,
                backgroundColor: const Color.fromARGB(255, 5, 54, 116),
                fontColor: const Color.fromARGB(255, 220, 221, 203),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Materia extends StatelessWidget {
  String txt;
  Materia(this.txt);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: Color.fromARGB(255, 5, 54, 116),
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          txt,
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
