import 'dart:collection';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:habitat/src/backend/db_firestore.dart';
import 'package:habitat/src/widgets/ImageButton.dart';

import '../models/Subjects.dart';
import '../widgets/ButtonElipse.dart';

class PostingListView extends StatefulWidget {
  @override
  State<PostingListView> createState() => _PostingListViewState();
}

class _PostingListViewState extends State<PostingListView> {
  late FirebaseFirestore db = DBFirestore.get();

  List<Subject> subjects = [];

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
            height: MediaQuery.of(context).size.height * 0.76,
            child: ListView.builder(
              itemCount: subjects.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Materia(subjects[index].title),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ButtonElipse(
                "Postar",
                () => {
                  // for (var i = 0; i < subjects.length; i++)
                  //   {
                  //     db.collection("/Faculdade/inatel/subjects/").doc("${subjects[i]}").set({
                  //       '"title"': '"${subjects[i]}"',
                  //     })
                  //   }
                },
                width: 100,
                fontSize: 20,
                backgroundColor: const Color.fromARGB(255, 5, 54, 116),
                fontColor: const Color.fromARGB(255, 220, 221, 203),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Materia extends StatelessWidget {
  String txt;
  Materia(this.txt);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: Color.fromARGB(255, 5, 54, 116),
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          txt,
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
