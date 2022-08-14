import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:habitat/src/models/Question.dart';

class QuestionItemList extends StatelessWidget {
  Question question;
  Function function;
  QuestionItemList(this.question, this.function);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 220, 221, 203),
          border: Border.all(
            width: 2,
            color: Color.fromARGB(255, 5, 54, 116),
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(question.title, style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 5, 54, 116))),
                IconButton(
                    onPressed: () {
                      function(question);
                    },
                    icon: Icon(Icons.arrow_forward))
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(question.description, style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 5, 54, 116))),
            ),
          ],
        ),
      ),
    );
  }
}
