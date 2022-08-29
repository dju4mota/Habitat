import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:habitat/src/utils/utils.dart';

import '../models/Subjects.dart';
import '../view/QuestionList.dart';

class ListItemCus extends StatelessWidget {
  const ListItemCus({
    Key? key,
    required this.subject,
    required this.function,
  }) : super(key: key);

  final Subject subject;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Util.fundoClaro,
        border: Border.all(
          width: 2,
          color: Util.azulEscuroBotao,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextButton(
        child: Text(subject.title, style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 5, 54, 116))),
        onPressed: () {
          function(subject);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => QuestionList(),
            ),
          );
        },
      ),
    );
  }
}
