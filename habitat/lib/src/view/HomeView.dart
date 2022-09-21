import 'package:auto_size_text/auto_size_text.dart';
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

  //bool showCollege = true;
  Color backgroundColorCollege = Util.azulEscuroBotao;
  Color backgroundColorCity = Util.fundoClaro;
  Color fontColorCollege = Util.fundoClaro;
  Color fontColorCity = Util.azulEscuroBotao;
  String path1 = 'assets/programSomb.png';
  String path2 = 'assets/circuitSomb.png';
  String path3 = 'assets/mathSomb.png';
  String path4 = 'assets/anatoSomb.png';
  String subject1 = 'C202';
  String subject2 = 'E201';
  String subject3 = 'M004';
  String subject4 = 'B202';

  openQuestionView(context, subjectTitle) {
    readController.subject = Subject(title: subjectTitle);
    Navigator.of(context).pushNamed('/questionList');
  }

  showCity() {
    setState(() {
      backgroundColorCollege = Util.fundoClaro;
      backgroundColorCity = Util.azulEscuroBotao;

      fontColorCollege = Util.azulEscuroBotao;
      fontColorCity = Util.fundoClaro;
      readController.path = "Cidade/santaRita/subjects/";
      path1 = 'assets/SaudeSomb.png';
      path2 = 'assets/FestaSombra.png';
      path3 = 'assets/AppsSombra.png';
      path4 = 'assets/ComercioSombra.png';
      subject1 = 'Saúde & Estética';
      subject2 = 'Festas & Eventos';
      subject3 = 'Apps';
      subject4 = 'Comércio';
    });

    print(readController.path);
  }

  showCollege() {
    setState(() {
      backgroundColorCollege = Util.azulEscuroBotao;
      backgroundColorCity = Util.fundoClaro;

      fontColorCollege = Util.fundoClaro;
      fontColorCity = Util.azulEscuroBotao;
      readController.path = "Faculdade/inatel/subjects/";
      path1 = 'assets/programSomb.png';
      path2 = 'assets/circuitSomb.png';
      path3 = 'assets/mathSomb.png';
      path4 = 'assets/anatoSomb.png';
      subject1 = 'C202';
      subject2 = 'E201';
      subject3 = 'M004';
      subject4 = 'B202';
    });
    print(readController.path);
  }

  // invertCollegeAndCity() {
  //   setState(() {
  //     if (showCollege && readController.path != "Cidade/santaRita/subjects/") {
  //       showCollege = !showCollege;
  //     } else if (readController.path != "Faculdade/inatel/subjects/") {
  //       showCollege = !showCollege;
  //     }
  //   });
  // }

  _HomeViewState() {
    readController.path = "Faculdade/inatel/subjects/";
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
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: AutoSizeText(
                    'Olá, ${UserDB.name}!',
                    maxLines: 2,
                    minFontSize: 15,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w400,
                      color: Util.azulEscuroBotao,
                    ),
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
                  showCollege,
                  fontSize: 20,
                  width: 150,
                  backgroundColor: backgroundColorCollege,
                  fontColor: fontColorCollege,
                ),
                ButtonElipse(
                  "Cidade",
                  showCity,
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
                      onPressed: () => {Navigator.of(context).pushNamed('/searchView')},
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
                    ImageButton(path1, () => {openQuestionView(context, subject1)}, subject1),
                    ImageButton(path2, () => {openQuestionView(context, subject2)}, subject2),
                  ]),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                    ImageButton(path3, () => {openQuestionView(context, subject3)}, subject3),
                    ImageButton(path4, () => {openQuestionView(context, subject4)}, subject4),
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
