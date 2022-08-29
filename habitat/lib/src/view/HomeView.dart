import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitat/src/backend/AuthService.dart';
import 'package:habitat/src/utils/utils.dart';
import 'package:habitat/src/view/QuestionList.dart';
import 'package:habitat/src/widgets/ButtonElipse.dart';
import 'package:habitat/src/widgets/FooterMenu.dart';
import 'package:habitat/src/widgets/ImageButton.dart';
import 'package:provider/provider.dart';
import 'package:typesense/typesense.dart';

import '../backend/db_firestore.dart';
import '../backend/typeSenseConfig.dart';
import '../controler/User.dart';
import '../widgets/Carrossel.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

openQuestionView(context) {
  Navigator.of(context).pushNamed('/questionList');
}

class _HomeViewState extends State<HomeView> {
  Client client = TypeSenseInstance().client;
  late FirebaseFirestore db = DBFirestore.get();
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Util.azulClaroFundo,
      body: Padding(
        padding: const EdgeInsets.all(17.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(
              // não sei se funciona para todo celular
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text(
                  'Olá, ${UserDB.name}',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w400,
                    // fontFamily: 'Inter',
                    color: Util.azulEscuroBotao,
                  ),
                ),
              ],
            ),

            Text(
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
                  () => {},
                  fontSize: 20,
                  width: 150,
                  backgroundColor: const Color.fromARGB(255, 3, 69, 135),
                  fontColor: Util.fundoClaro,
                ),
                ButtonElipse(
                  "Cidade",
                  () => {},
                  fontSize: 20,
                  width: 150,
                  backgroundColor: Util.fundoClaro,
                  fontColor: Util.azulEscuroBotao,
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
                        onPressed: () => {Navigator.of(context).pushNamed("/subjectsall")},
                        child: Text(
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
                    ImageButton("assets/programming2.png", () => {openQuestionView(context)}, "C204"),
                    ImageButton("assets/circuit-board2.png", () => {}, "E209"),
                  ]),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                    ImageButton("assets/maths2.png", () => {}, "M005"),
                    ImageButton("assets/anatomia2.png", () => {}, "B023"),
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
