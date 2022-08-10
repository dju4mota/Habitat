import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitat/src/backend/AuthService.dart';
import 'package:habitat/src/view/QuestionList.dart';
import 'package:habitat/src/widgets/ButtonElipse.dart';
import 'package:habitat/src/widgets/FooterMenu.dart';
import 'package:habitat/src/widgets/ImageButton.dart';
import 'package:provider/provider.dart';

import '../widgets/Carrossel.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

openQuestionView(context) {
  Navigator.of(context).pushNamed('/questionList');
}

class _HomeViewState extends State<HomeView> {
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
                const Text(
                  'Olá, Fernando!',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Inter',
                    color: Color.fromARGB(255, 5, 54, 116),
                  ),
                ),
              ],
            ),

            const Text(
              "Como podemos te ajudar hoje para fazer da faculdade e da cidade um perfeito Habitat para você? ",
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w400,
                fontFamily: 'Inter',
                color: Color.fromARGB(255, 5, 54, 116),
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
                  backgroundColor: const Color.fromARGB(255, 5, 54, 116),
                  fontColor: const Color.fromARGB(255, 220, 221, 203),
                ),
                ButtonElipse("Cidade", () => {}, fontSize: 20, width: 150),
              ],
            ),
            // text Dúvidas e button pesquisa
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Dúvidas",
                  style: TextStyle(
                    fontSize: 29,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Inter',
                    color: Color.fromARGB(255, 5, 54, 116),
                  ),
                ),
                CupertinoButton(
                  onPressed: () => {},
                  child: const Icon(
                    Icons.search,
                    color: Color.fromARGB(255, 5, 54, 116),
                    size: 35,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () => {Navigator.of(context).pushNamed("/subjectsall")}, child: Text("Exibir todas"))
              ],
            ),
            // carrossel com imagens
            Container(
              height: 350,
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
            FooterMenu(() => {}, () => {}, () => {Navigator.of(context).pushNamed("/posting")},
                () => {Navigator.of(context).pushNamed("/profile")})
          ],
        ),
      ),
    );
  }
}
