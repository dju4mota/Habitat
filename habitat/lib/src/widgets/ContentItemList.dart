// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:habitat/src/models/Content.dart';
import 'package:habitat/src/utils/utils.dart';

class ContentItemList extends StatelessWidget {
  Content question;
  List<Content> answers = [];

  Function openContent;
  // Function deleteContent;

  ContentItemList(this.question, this.openContent, this.answers);
  // , this.openContent, this.deleteContent);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: Util.fundoClaro,
          border: Border.all(
            width: 2,
            color: Color.fromARGB(255, 5, 54, 116),
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ContentHeader(question),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 5, 5, 20.0),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.62,
                    child: Text(
                      question.description,
                      style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 5, 54, 116)),
                    ),
                  )),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * answers.length * 0.13,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(0),
                itemCount: answers.length,
                itemBuilder: (context, index) {
                  return ContentHeader(answers[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContentHeader extends StatelessWidget {
  const ContentHeader(this.content);

  final Content content;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 0, 1, 4),
          child: CircleAvatar(
            radius: 32, // Image radius
            backgroundImage: AssetImage("assets/mamonas-assassinas.jpg"),
          ),
        ),
        Column(
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.65,
                child: Text(content.userId, style: TextStyle(fontSize: 24, color: Color.fromARGB(255, 5, 54, 116)))),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.65,
                child: Text(content.title, style: TextStyle(fontSize: 24, color: Color.fromARGB(255, 5, 54, 116)))),
          ],
        ),
      ],
    );
  }
}
