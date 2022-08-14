import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:habitat/src/controler/ReadController.dart';

import '../models/Question.dart';

class QuestionView extends StatelessWidget {
  ReadController control = ReadController();
  late final Question question = control.question;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 220, 221, 203),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Container(
              child: Column(
                children: [
                  Text(question.title, style: TextStyle(fontSize: 40, color: Color.fromARGB(255, 5, 54, 116))),
                  SizedBox(
                    height: 10,
                  ),
                  Text(question.description, style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 5, 54, 116))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
