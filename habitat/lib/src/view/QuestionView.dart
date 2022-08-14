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
      body: Container(
        child: Column(
          children: [
            Column(
              children: [
                Text(question.title),
                Text(question.description),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
