import 'dart:collection';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habitat/src/backend/AuthService.dart';
import 'package:habitat/src/backend/db_firestore.dart';
import 'package:habitat/src/controler/ReadController.dart';
import 'package:habitat/src/models/Content.dart';
import 'package:habitat/src/utils/utils.dart';
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
  List<Content> questions = [];

  saveQuestionToShow(Content question) {
    control.question = question;
  }

  openQuestion(Content question) {
    saveQuestionToShow(question);
    Navigator.of(context).pushNamed('/questionView');
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => QuestionView(),
    //   ),
    // );
  }

  carregaLista() async {
    questions.clear();
    QuerySnapshot snapshot = await db.collection('${control.path}${control.subject.title}/questions').get();
    print(control.path + control.subject.title);

    snapshot.docs.forEach((doc) {
      // final json = jsonDecode(doc.data().toString());
      final LinkedHashMap json = jsonDecode(doc.data().toString());
      setState(() {
        questions.add(Content(
            title: json["title"],
            id: json["id"],
            description: json["description"],
            userId: json["userId"],
            subject: json["subject"]));
      });
    });
  }

  _QuestionListState() {
    carregaLista();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Util.azulClaroFundo,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40,
          ),
          IconButton(
              onPressed: () => {
                    Navigator.of(context).pop(),
                  },
              icon: Icon(Icons.arrow_back)),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 5, 5, 5),
            child: Text("Dúvidas de ${control.subject.title}",
                style: TextStyle(fontSize: 30, color: Color.fromARGB(255, 5, 54, 116))),
          ),
          Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: ListView.builder(
                padding: EdgeInsets.all(0),
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
  Content question;
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
