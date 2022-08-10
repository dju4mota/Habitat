import 'dart:collection';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:habitat/src/models/Subjects.dart';
import 'package:habitat/src/view/QuestionList.dart';

import '../backend/AuthService.dart';
import '../backend/db_firestore.dart';

class SubjectsAllView extends StatefulWidget {
  @override
  State<SubjectsAllView> createState() => _SubjectsAllViewState();
}

class _SubjectsAllViewState extends State<SubjectsAllView> {
  late FirebaseFirestore db = DBFirestore.get();

  late AuthService auth;
  List<Subject> subjects = [];

  carregaLista() async {
    subjects.clear();
    QuerySnapshot snapshot = await db.collection('Faculdade/inatel/subjects').get();

    snapshot.docs.forEach((doc) {
      // final json = jsonDecode(doc.data().toString());

      final LinkedHashMap json = jsonDecode(doc.data().toString());
      setState(() {
        subjects.add(Subject(
          title: json["title"],
        ));
      });
      print(subjects);
    });
  }

  _SubjectsAllViewState() {
    carregaLista();
  }

  @override
  Widget build(BuildContext context) {
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
                itemCount: subjects.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: ItemList(subjects[index]),
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
  Subject subject;
  ItemList(this.subject);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          subject.title,
          style: TextStyle(
            color: Color.fromARGB(255, 5, 54, 116),
          ),
        ),
        IconButton(
          icon: Icon(Icons.arrow_right_alt_sharp),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => QuestionList(
                    // question: question,
                    ),
              ),
            );
          },
        )
      ],
    );
  }
}
