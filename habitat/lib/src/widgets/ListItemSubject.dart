import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habitat/src/utils/utils.dart';

import '../models/Subjects.dart';

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
          context.go('/questionList');
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => QuestionList(),
          //   ),
          // );
        },
      ),
    );
  }
}
