import 'dart:collection';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:habitat/src/backend/AuthService.dart';
import 'package:habitat/src/backend/db_firestore.dart';
import 'package:habitat/src/models/Question.dart';
import 'package:habitat/src/view/QuestionView.dart';

class QuestionList extends StatefulWidget {
  QuestionList({Key? key}) : super(key: key);

  @override
  State<QuestionList> createState() => _QuestionListState();
}

class _QuestionListState extends State<QuestionList> {
  late FirebaseFirestore db = DBFirestore.get();

  late AuthService auth;
  List<Question> questions = [];

  carregaLista() async {
    questions.clear();
    QuerySnapshot snapshot = await db.collection('/Faculdade/inatel/subjects/c206/questions').get();

    snapshot.docs.forEach((doc) {
      // final json = jsonDecode(doc.data().toString());
      final LinkedHashMap json = jsonDecode(doc.data().toString());
      setState(() {
        questions.add(Question(title: json["titulo"], Id: json["id"], description: json["descricao"]));
      });
      print(questions);
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
                    title: ItemList(questions[index]),
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
  ItemList(this.question);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          question.title,
          style: TextStyle(
            color: Color.fromARGB(255, 5, 54, 116),
          ),
        ),
        IconButton(
          icon: Icon(Icons.arrow_right_alt_sharp),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => QuestionView(
                  question: question,
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
