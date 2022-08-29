import 'dart:collection';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:habitat/src/controler/ReadController.dart';
import 'package:habitat/src/models/Answer.dart';
import 'package:habitat/src/models/Subjects.dart';

import '../backend/AuthService.dart';
import '../backend/db_firestore.dart';
import '../models/Content.dart';
import '../widgets/AnswertemList.dart';

class QuestionView extends StatefulWidget {
  @override
  State<QuestionView> createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  ReadController control = ReadController();
  late FirebaseFirestore db = DBFirestore.get();
  late AuthService auth;

  late final Content question = control.question;

  List<Answer> answers = [];

  carregaLista() async {
    answers.clear();

    QuerySnapshot snapshot = await db
        .collection('/Faculdade/inatel/subjects/${control.subject.title}/questions/${question.id}/answers')
        .get();

    snapshot.docs.forEach((doc) {
      // final json = jsonDecode(doc.data().toString());
      final LinkedHashMap json = jsonDecode(doc.data()!.toString());

      setState(() {
        answers.add(Answer(
            title: json["title"],
            id: json["id"],
            description: json["description"],
            userId: json["userId"],
            questionParentId: json["questionId"],
            subject: json["subject"]));
      });
    });
  }

  _QuestionViewState() {
    carregaLista();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 220, 221, 203),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 5, 10, 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              Column(
                children: [
                  Text(question.title, style: const TextStyle(fontSize: 40, color: Color.fromARGB(255, 5, 54, 116))),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(question.description,
                      style: const TextStyle(fontSize: 20, color: Color.fromARGB(255, 5, 54, 116))),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () => {
                            control.question = question,
                            Navigator.of(context).pushNamed("/answerView"),
                          },
                      child: const Text('Responder',
                          style: TextStyle(fontSize: 20, color: const Color.fromARGB(255, 5, 54, 116)))),
                ],
              ),
              SizedBox(
                height: 300,
                child: ListView.builder(
                  itemCount: answers.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: ItemList(answers[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  Answer answer;

  ItemList(this.answer);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [AnswerItemList(answer)],
    );
  }
}
