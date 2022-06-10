import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitat/src/backend/AuthService.dart';
import 'package:habitat/src/widgets/ButtonElipse.dart';
import 'package:habitat/src/widgets/FooterMenu.dart';
import 'package:provider/provider.dart';

import '../widgets/Carrossel.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
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
                Text(
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
                  child: Icon(
                    Icons.search,
                    color: Color.fromARGB(255, 5, 54, 116),
                    size: 35,
                  ),
                ),
              ],
            ),
            // carrossel com imagens
            Container(
              child: Column(
                children: [
                  Row(children: [
                    Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () => {},
                          icon: Image.asset(
                            "assets/programming1.png",
                            height: 250,
                          ),
                          iconSize: 70,
                        ),
                        const Text("C204"),
                      ],
                    ),
                    IconButton(
                        onPressed: () => {},
                        icon: Image.asset("assets/programming1.png"),
                        iconSize: 150)
                  ]),
                  Row(children: [
                    IconButton(
                        onPressed: () => {},
                        icon: Image.asset("assets/programming1.png"),
                        iconSize: 150),
                    IconButton(
                        onPressed: () => {},
                        icon: Image.asset("assets/programming1.png"),
                        iconSize: 150)
                  ]),
                ],
              ),
            ),
            // 4 buttons com nagivator
            FooterMenu(() => {}, () => {}, () => {}, () => {}),
            // ElevatedButton(
            //   onPressed: () => context.read<AuthService>().logout(),
            //   child: const Text("Sair"),
            // )
          ],
        ),
      ),
    );
  }
}
