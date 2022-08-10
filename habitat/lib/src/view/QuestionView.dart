import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../models/Question.dart';

class QuestionView extends StatelessWidget {
  late final Question question;
  QuestionView({required this.question});

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
