import 'dart:collection';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habitat/src/controler/ReadController.dart';
import 'package:habitat/src/models/Subjects.dart';
import 'package:habitat/src/utils/utils.dart';

import '../backend/AuthService.dart';
import '../backend/db_firestore.dart';
import '../widgets/ListItemSubject.dart';

class SubjectsAllView extends StatefulWidget {
  @override
  State<SubjectsAllView> createState() => _SubjectsAllViewState();
}

class _SubjectsAllViewState extends State<SubjectsAllView> {
  late FirebaseFirestore db = DBFirestore.get();

  late AuthService auth;
  ReadController control = ReadController();
  List<Subject> subjects = [];

  saveSubjectToShow(Subject subject) {
    control.subject = subject;
  }

  carregaLista() async {
    subjects.clear();
    QuerySnapshot snapshot = await db.collection(control.path).get();

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

  _SubjectsAllViewState() {
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
            height: 20,
          ),
          IconButton(
            onPressed: () => {
              Navigator.of(context).pop(),
            },
            icon: Icon(Icons.arrow_back),
          ),
          Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.82,
              child: ListView.builder(
                padding: EdgeInsets.all(0),
                itemCount: subjects.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: ItemList(subjects[index], saveSubjectToShow),
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
  Function saveSubejectToShow;
  ItemList(this.subject, this.saveSubejectToShow);

  @override
  Widget build(BuildContext context) {
    return ListItemCus(subject: subject, function: saveSubejectToShow);
  }
}
