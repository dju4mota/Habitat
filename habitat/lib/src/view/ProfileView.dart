import 'dart:collection';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitat/src/backend/AuthService.dart';
import 'package:habitat/src/backend/typeSenseConfig.dart';
import 'package:habitat/src/models/Question.dart';
import 'package:habitat/src/widgets/QuestionItemList.dart';
import 'package:provider/provider.dart';

import 'package:typesense/typesense.dart';

import '../widgets/FooterMenu.dart';

class ProfileView extends StatefulWidget {
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  // Function sair;
  Client client = TypeSenseInstance().client;

  FirebaseAuth _auth = FirebaseAuth.instance;

  List<Question> questions = [];

  final searchParameters = {
    'q': '\"${FirebaseAuth.instance.currentUser!.uid}\"',
    'query_by': '"userId"',
  };

  pesquisa() async {
    await client.collection('questions').documents.search(searchParameters);
    Map<String, dynamic> questionsMap = await client.collection('questions').documents.search(searchParameters);
    // print(questionsMap["hits"]);
    carregaLista(questionsMap["hits"]);
  }

  carregaLista(List questionsHits) async {
    questions.clear();

    questionsHits.forEach((doc) {
      setState(() {
        questions.add(Question(
            title: doc["document"]['"title"'],
            id: doc["document"]['"id"'],
            description: doc["document"]['"description"'],
            userId: doc["document"]['"userId"']));
      });
    });
  }

  _ProfileViewState() {
    pesquisa();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 220, 221, 203),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(
              // não sei se funciona para todo celular
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text(
                  'Olá, ${_auth.currentUser!.email}!',
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Inter',
                    color: Color.fromARGB(255, 5, 54, 116),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 300,
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: ItemList(questions[index]),
                  );
                },
              ),
            ),
            Center(
                child: ElevatedButton(
              onPressed: () =>
                  {context.read<AuthService>().logout(), Navigator.of(context).popUntil((route) => route.isFirst)},
              child: const Text("Sair"),
            )),
            // 4 buttons com nagivator
            FooterMenu(() => {}, () => {}, () => {Navigator.of(context).pushNamed("/posting")}, () => {})
          ],
        ),
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
      children: [QuestionItemList(question, () => {})],
    );
  }
}
