import 'dart:collection';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitat/src/backend/AuthService.dart';
import 'package:habitat/src/backend/typeSenseConfig.dart';
import 'package:habitat/src/models/Answer.dart';
import 'package:habitat/src/models/Content.dart';
import 'package:habitat/src/widgets/ContentItemList.dart';
import 'package:habitat/src/widgets/QuestionItemList.dart';
import 'package:provider/provider.dart';

import 'package:typesense/typesense.dart';

import '../widgets/ButtonElipse.dart';
import '../widgets/FooterMenu.dart';

class ProfileView extends StatefulWidget {
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  // Function sair;
  Client client = TypeSenseInstance().client;

  FirebaseAuth _auth = FirebaseAuth.instance;

  List<Content> content = [];

  bool showQuestions = true;
  bool showCollege = true;
  Color backgroundColorCollege = const Color.fromARGB(255, 5, 54, 116);
  Color backgroundColorCity = Color.fromARGB(255, 220, 221, 203);
  Color backgroundColorQuestion = const Color.fromARGB(255, 5, 54, 116);
  Color backgroundColorAnswer = Color.fromARGB(255, 220, 221, 203);

  Color fontColorCollege = Color.fromARGB(255, 220, 221, 203);
  Color fontColorCity = const Color.fromARGB(255, 5, 54, 116);
  Color fontColorQuestion = Color.fromARGB(255, 220, 221, 203);
  Color fontColorAnswer = const Color.fromARGB(255, 5, 54, 116);

  invertePerguntaResposta() {
    setState(() {
      if (showQuestions) {
        showQuestions = !showQuestions;

        backgroundColorQuestion = Color.fromARGB(255, 220, 221, 203);
        backgroundColorAnswer = const Color.fromARGB(255, 5, 54, 116);

        fontColorQuestion = const Color.fromARGB(255, 5, 54, 116);
        fontColorAnswer = Color.fromARGB(255, 220, 221, 203);

        search('answers');
      } else {
        showQuestions = !showQuestions;

        backgroundColorQuestion = const Color.fromARGB(255, 5, 54, 116);
        backgroundColorAnswer = Color.fromARGB(255, 220, 221, 203);

        fontColorQuestion = Color.fromARGB(255, 220, 221, 203);
        fontColorAnswer = const Color.fromARGB(255, 5, 54, 116);

        search('questions');
      }
    });
  }

  final searchParameters = {
    'q': '\"${FirebaseAuth.instance.currentUser!.uid}\"',
    'query_by': '"userId"',
  };

  search(String content) async {
    print("buscando - " + content);
    Map<String, dynamic> contentMap = await client.collection(content).documents.search(searchParameters);

    loadQuestionsList(contentMap["hits"]);
  }

  loadQuestionsList(List contentMap) async {
    setState(() {
      content.clear();
    });

    contentMap.forEach((doc) {
      setState(() {
        content.add(Content(
            title: doc["document"]['"title"'],
            id: doc["document"]['"id"'],
            description: doc["document"]['"description"'],
            userId: doc["document"]['"userId"']));
      });
    });
  }

  _ProfileViewState() {
    search('questions');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 220, 221, 203),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              // não sei se funciona para todo celular
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          '${_auth.currentUser!.email}',
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Inter',
                            color: Color.fromARGB(255, 5, 54, 116),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: ButtonElipse(
                          "Sair",
                          () {
                            {
                              context.read<AuthService>().logout();
                              Navigator.of(context).popUntil((route) => route.isFirst);
                            }
                          },
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonElipse(
                  "Faculdade",
                  () => {},
                  fontSize: 20,
                  width: 150,
                  backgroundColor: const Color.fromARGB(255, 5, 54, 116),
                  fontColor: const Color.fromARGB(255, 220, 221, 203),
                ),
                ButtonElipse("Cidade", () => {}, fontSize: 20, width: 150),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonElipse(
                  "Perguntas",
                  invertePerguntaResposta,
                  fontSize: 20,
                  width: 150,
                  backgroundColor: backgroundColorQuestion,
                  fontColor: fontColorQuestion,
                ),
                ButtonElipse(
                  "Respostas",
                  invertePerguntaResposta,
                  fontSize: 20,
                  width: 150,
                  backgroundColor: backgroundColorAnswer,
                  fontColor: fontColorAnswer,
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.55,
              child: ListView.builder(
                padding: EdgeInsets.all(0),
                itemCount: content.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: ItemList(content[index], () => {}, () => {}),
                  );
                },
              ),
            ),
            // 4 buttons com nagivator
            FooterMenu(() => {}, () => {}, () => {Navigator.of(context).pushNamed("/posting")}, () => {})
          ],
        ),
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  Content content;
  Function openContent;
  Function deleteContent;

  ItemList(this.content, this.openContent, this.deleteContent);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ContentItemList(content, openContent, deleteContent),
      ],
    );
  }
}
