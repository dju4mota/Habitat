import 'dart:collection';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:habitat/src/backend/AuthService.dart';
import 'package:habitat/src/backend/db_firestore.dart';
import 'package:habitat/src/controler/ReadController.dart';
import 'package:habitat/src/models/Question.dart';
import 'package:habitat/src/view/QuestionView.dart';
import 'package:habitat/src/widgets/QuestionItemList.dart';

class QuestionList extends StatefulWidget {
  QuestionList({Key? key}) : super(key: key);

  @override
  State<QuestionList> createState() => _QuestionListState();
}

class _QuestionListState extends State<QuestionList> {
  late FirebaseFirestore db = DBFirestore.get();

  ReadController control = ReadController();
  late AuthService auth;
  List<Question> questions = [];

  saveQuestionToShow(Question question) {
    control.question = question;
  }

  openQuestion(Question question) {
    saveQuestionToShow(question);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => QuestionView(),
      ),
    );
  }

  carregaLista() async {
    questions.clear();
    print(control.subject.title);
    QuerySnapshot snapshot = await db.collection('/Faculdade/inatel/subjects/${control.subject.title}/questions').get();
    print(snapshot.docs);

    snapshot.docs.forEach((doc) {
      // final json = jsonDecode(doc.data().toString());
      final LinkedHashMap json = jsonDecode(doc.data().toString());
      print(json["id"]);
      setState(() {
        questions.add(Question(title: json["title"], id: json["id"], description: json["description"]));
      });
      print("questions: ${questions}");
    });
  }

  _QuestionListState() {
    carregaLista();
  }

  @override
  Widget build(BuildContext context) {
    print(questions.length);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 220, 221, 203),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40,
          ),
          IconButton(onPressed: () => {Navigator.of(context).pop()}, icon: Icon(Icons.arrow_back)),
          Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: ItemList(questions[index], openQuestion),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  Question question;
  Function openQuestion;
  ItemList(this.question, this.openQuestion);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [QuestionItemList(question, openQuestion)],
    );
  }
}
