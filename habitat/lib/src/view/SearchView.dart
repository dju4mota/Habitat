import 'dart:collection';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habitat/src/backend/AuthService.dart';
import 'package:habitat/src/backend/db_firestore.dart';
import 'package:habitat/src/backend/typeSenseConfig.dart';
import 'package:habitat/src/controler/ReadController.dart';
import 'package:habitat/src/models/Content.dart';
import 'package:habitat/src/models/Subjects.dart';
import 'package:habitat/src/utils/utils.dart';
import 'package:habitat/src/widgets/ButtonElipse.dart';
import 'package:habitat/src/widgets/QuestionItemList.dart';
import 'package:typesense/typesense.dart';

class SearchView extends StatefulWidget {
  SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  late FirebaseFirestore db = DBFirestore.get();

  ReadController control = ReadController();
  TextEditingController searchController = TextEditingController();
  Client client = TypeSenseInstance().client;
  late AuthService auth;
  List<Content> questions = [];

  saveQuestionToShow(Content question) {
    control.subject = Subject(title: question.subject);
    print(control.subject.title);
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

    Map<String, dynamic> contentMap = await client.collection("questions").documents.search(
      {
        'q': searchController.text,
        'query_by': '"title", "description"',
      },
    );
    print(contentMap['hits']);

    contentMap['hits'].forEach((doc) {
      setState(() {
        questions.add(Content(
          title: doc["document"]['"title"'].toString().replaceAll('"', ''),
          id: doc["document"]['"id"'].toString().replaceAll('"', ''),
          description: doc["document"]['"description"'].toString().replaceAll('"', ''),
          userId: doc["document"]['"userId"'].toString().replaceAll('"', ''),
          subject: doc["document"]['"subject"'].toString().replaceAll('"', ''),
        ));
      });
    });
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
              icon: const Icon(Icons.arrow_back)),
          const Padding(
            padding: EdgeInsets.fromLTRB(20.0, 5, 5, 5),
            child: Text("Pesquise por palavras-chaves:",
                style: TextStyle(fontSize: 30, color: Color.fromARGB(255, 5, 54, 116))),
          ),
          Form(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  controller: searchController,
                ),
                ButtonElipse(
                  "Pesquisar",
                  carregaLista,
                ),
              ],
            ),
          )),
          Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: ListView.builder(
                padding: const EdgeInsets.all(0),
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
