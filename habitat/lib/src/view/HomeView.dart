import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitat/src/controler/ReadController.dart';
import 'package:habitat/src/models/Subjects.dart';
import 'package:habitat/src/utils/utils.dart';
import 'package:habitat/src/widgets/ButtonElipse.dart';
import 'package:habitat/src/widgets/FooterMenu.dart';
import 'package:habitat/src/widgets/ImageButton.dart';
import 'package:typesense/typesense.dart';

import '../backend/db_firestore.dart';
import '../backend/typeSenseConfig.dart';
import '../controler/User.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Client client = TypeSenseInstance().client;
  late FirebaseFirestore db = DBFirestore.get();
  FirebaseAuth _auth = FirebaseAuth.instance;
  ReadController readController = ReadController();

  bool showCollege = true;
  Color backgroundColorCollege = Util.azulEscuroBotao;
  Color backgroundColorCity = Util.fundoClaro;
  Color fontColorCollege = Util.fundoClaro;
  Color fontColorCity = Util.azulEscuroBotao;

  openQuestionView(context, subjectTitle) {
    readController.subject = Subject(title: subjectTitle);
    Navigator.of(context).pushNamed('/questionList');
  }

  invertCollegeAndCity() {
    setState(() {
      if (showCollege) {
        showCollege = !showCollege;

        backgroundColorCollege = Util.fundoClaro;
        backgroundColorCity = Util.azulEscuroBotao;

        fontColorCollege = Util.azulEscuroBotao;
        fontColorCity = Util.fundoClaro;
        readController.path = "Cidade/santaRita/subjects/";
        print(readController.path);
      } else {
        showCollege = !showCollege;

        backgroundColorCollege = Util.azulEscuroBotao;
        backgroundColorCity = Util.fundoClaro;

        fontColorCollege = Util.fundoClaro;
        fontColorCity = Util.azulEscuroBotao;
        readController.path = "Faculdade/inatel/subjects/";
        print(readController.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Util.azulClaroFundo,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(
              // não sei se funciona para todo celular
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text(
                  'Olá, ${UserDB.name}',
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w400,
                    // fontFamily: 'Inter',
                    color: Util.azulEscuroBotao,
                  ),
                ),
              ],
            ),
            const Text(
              "Como podemos te ajudar hoje para fazer da faculdade e da cidade um perfeito Habitat para você? ",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w400,
                fontFamily: 'League Gothic Condesed',
                decoration: TextDecoration.none,
                color: Util.azulEscuroBotao,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonElipse(
                  "Faculdade",
                  invertCollegeAndCity,
                  fontSize: 20,
                  width: 150,
                  backgroundColor: backgroundColorCollege,
                  fontColor: fontColorCollege,
                ),
                ButtonElipse(
                  "Cidade",
                  invertCollegeAndCity,
                  fontSize: 20,
                  width: 150,
                  backgroundColor: backgroundColorCity,
                  fontColor: fontColorCity,
                ),
              ],
            ),
            // text Dúvidas e button pesquisa
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(0),
                    child: Text(
                      "Dúvidas",
                      style: TextStyle(
                        // fontWeight: FontWeight.w200,
                        fontSize: 40,
                        color: Color.fromARGB(255, 5, 54, 116),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: CupertinoButton(
                      onPressed: () => {},
                      child: const Icon(
                        Icons.search,
                        color: Color.fromARGB(255, 5, 54, 116),
                        size: 35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: TextButton(
                        onPressed: () => {Navigator.of(context).pushNamed('/subjectsall')},
                        child: const Text(
                          "Exibir todas",
                          style: TextStyle(
                            fontSize: 17,
                            color: Util.azulEscuroBotao,
                          ),
                        )),
                  )
                ],
              ),
            ),
            // carrossel com imagens
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                    ImageButton("assets/programming2.png", () => {openQuestionView(context, "C204")}, "C204"),
                    ImageButton("assets/circuit-board2.png", () => {openQuestionView(context, "E209")}, "E209"),
                  ]),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                    ImageButton("assets/maths2.png", () => {openQuestionView(context, "M005")}, "M005"),
                    ImageButton("assets/anatomia2.png", () => {openQuestionView(context, "B023")}, "B023"),
                  ]),
                ],
              ),
            ),
            // 4 buttons com nagivator
            FooterMenu()
          ],
        ),
      ),
    );
  }
}
