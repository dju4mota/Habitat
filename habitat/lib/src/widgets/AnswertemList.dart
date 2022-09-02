import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:habitat/src/models/Content.dart';
import 'package:habitat/src/utils/utils.dart';

import '../models/Answer.dart';

class AnswerItemList extends StatelessWidget {
  Answer answer;

  AnswerItemList(this.answer);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Util.fundoClaro,
          border: Border.all(
            width: 2,
            color: const Color.fromARGB(255, 5, 54, 116),
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 5, 5, 5),
              child: Text(answer.title, style: const TextStyle(fontSize: 24, color: Color.fromARGB(255, 5, 54, 116))),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 5, 5, 20.0),
              child: Text(answer.description,
                  style: const TextStyle(fontSize: 20, color: Color.fromARGB(255, 5, 54, 116))),
            ),
          ],
        ),
      ),
    );
  }
}
