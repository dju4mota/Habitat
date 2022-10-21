import 'dart:collection';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habitat/src/backend/typeSenseConfig.dart';
import 'package:habitat/src/controler/ReadController.dart';
import 'package:habitat/src/utils/utils.dart';
import 'package:habitat/src/widgets/ButtonElipse.dart';
import 'package:typesense/typesense.dart';

import '../backend/db_firestore.dart';
import '../controler/QuestionPostingControl.dart';
import '../models/Content.dart';
import 'package:uuid/uuid.dart';

class PostingView extends StatefulWidget {
  @override
  State<PostingView> createState() => _PostingViewState();
}

class _PostingViewState extends State<PostingView> {
  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();

  final questionController = TextEditingController();

  final control = QuestionPostingControl();

  FirebaseAuth _auth = FirebaseAuth.instance;
  late FirebaseFirestore db = DBFirestore.get();
  Client client = TypeSenseInstance().client;
  ReadController readController = ReadController();

  final uuid = Uuid();

  late List<String> subjects;

  late String dropdownValue;

  carregaLista() async {
    subjects.clear();
    if (readController.path == "Faculdade/inatel/subjects/") {
      subjects.add('Selecione uma matéria');
    } else {
      subjects.add('Escolha o assunto');
    }
    QuerySnapshot snapshot = await db.collection(readController.path).get();

    snapshot.docs.forEach((doc) {
      final LinkedHashMap json = jsonDecode(doc.data().toString());
      // print(json["title"].toString());
      setState(() {
        subjects.add(
          json["title"].toString(),
        );
      });
    });
  }

  _PostingViewState() {
    if (readController.path == "Faculdade/inatel/subjects/") {
      subjects = ['Selecione uma matéria'];
    } else {
      subjects = ['Escolha o assunto'];
    }
    carregaLista();
    dropdownValue = subjects.first;
  }

  postQuestion(BuildContext context, String subjectTitle) {
    control.question.subject = subjectTitle;
    createQuestion(context, subjectTitle);
  }

  createQuestion(BuildContext context, String subjectTitle) async {
    print("${readController.path}$subjectTitle/questions");
    await db.collection("${readController.path}$subjectTitle/questions").doc(control.question.id).set({
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
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Pergunta postada com sucesso!")),
    );
    // context.go('/home');
    Navigator.of(context).popAndPushNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Util.azulClaroFundo,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                ButtonElipse(
                  "Postar",
                  () {
                    control.question = Content(
                      id: uuid.v4(),
                      title: titleController.text,
                      description: questionController.text,
                      userId: _auth.currentUser!.uid,
                      subject: "",
                    );
                    if (dropdownValue == "Selecione uma matéria") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Selecione uma matéria!")),
                      );
                    } else {
                      postQuestion(context, dropdownValue);
                    }
                  },
                  width: 100,
                  fontSize: 18,
                  backgroundColor: Util.azulEscuroBotao,
                  fontColor: Util.fundoClaro,
                ),
              ],
            ),
            Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: titleController,
                        decoration: const InputDecoration(
                          labelText: "Título para sua pergunta",
                          labelStyle: TextStyle(fontSize: 20),
                          border: null,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        minLines: 2,
                        maxLines: 15,
                        controller: questionController,
                      ),
                    ),
                  ],
                )),
            DropdownButton<String>(
              value: dropdownValue,
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: subjects.map<DropdownMenuItem<String>>((String subject) {
                return DropdownMenuItem<String>(value: subject, child: Text(subject));
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
