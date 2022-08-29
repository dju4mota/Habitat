import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:habitat/src/backend/db_firestore.dart';
import 'package:habitat/src/controler/QuestionPostingControl.dart';
import 'package:typesense/typesense.dart';

import '../backend/typeSenseConfig.dart';
import '../models/Subjects.dart';

class PostingListView extends StatefulWidget {
  @override
  State<PostingListView> createState() => _PostingListViewState();
}

class _PostingListViewState extends State<PostingListView> {
  late FirebaseFirestore db = DBFirestore.get();
  Client client = TypeSenseInstance().client;
  final QuestionPostingControl control = QuestionPostingControl();

  List<Subject> subjects = [];
  // late Subject subjectToPostOn;

  postQuestion(BuildContext context, String subjectTitle) {
    control.question.subject = subjectTitle;
    createQuetion(context, subjectTitle);
    // Navigator.popUntil(context, ModalRoute.withName('/home'));
  }

  createQuetion(BuildContext context, String subjectTitle) async {
    await db.collection("/Faculdade/inatel/subjects/$subjectTitle/questions").doc(control.question.id).set({
      '"title"': '"${control.question.title}"',
      '"description"': '"${control.question.description}"',
      '"id"': '"${control.question.id}"',
      '"userId"': '"${control.question.userId}"',
      '"subject"': '"${control.question.subject}"'
    });
    await client.collection("questions").documents.create(
      {
        '"title"': '"${control.question.title}"',
        '"description"': '"${control.question.description}"',
        '"id"': '"${control.question.id}"',
        '"userId"': '"${control.question.userId}"',
        '"subject"': '"${control.question.subject}"'
      },
    );

    Navigator.of(context).pushReplacementNamed("/home");
  }

  carregaLista() async {
    subjects.clear();
    QuerySnapshot snapshot = await db.collection('Faculdade/inatel/subjects').get();

    snapshot.docs.forEach((doc) {
      final LinkedHashMap json = jsonDecode(doc.data().toString());
      // print(json["title"].toString());
      setState(() {
        subjects.add(Subject(
          title: json["title"].toString(),
        ));
      });
    });
  }

  _PostingListViewState() {
    carregaLista();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 220, 221, 203),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 50, 10, 0),
            child: Text(
              "Postar em:",
              style: TextStyle(
                fontSize: 40,
                color: Color.fromARGB(255, 5, 54, 116),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.82,
            child: ListView.builder(
              padding: EdgeInsets.all(0),
              itemCount: subjects.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Materia(subjects[index].title, postQuestion),
                );
              },
            ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     ButtonElipse(
          //       "Postar",
          //       () => {
          //         // for (var i = 0; i < subjects.length; i++)
          //         //   {
          //         //     db.collection("/Faculdade/inatel/subjects/").doc("${subjects[i]}").set({
          //         //       '"title"': '"${subjects[i]}"',
          //         //     })
          //         //   }
          //       width: 100,
          //       fontSize: 20,
          //       backgroundColor: const Color.fromARGB(255, 5, 54, 116),
          //       fontColor: const Color.fromARGB(255, 220, 221, 203),
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }
}

class Materia extends StatefulWidget {
  String txt;
  Function createQuetion;

  Materia(this.txt, this.createQuetion);

  @override
  State<Materia> createState() => _MateriaState();
}

class _MateriaState extends State<Materia> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 220, 221, 203),
        border: Border.all(
          width: 2,
          color: Color.fromARGB(255, 5, 54, 116),
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextButton(
          child: Text(widget.txt, style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 5, 54, 116))),
          onPressed: () {
            widget.createQuetion(context, widget.txt);
          }),
    );
  }
}
