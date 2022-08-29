import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitat/src/widgets/ButtonElipse.dart';

class StartView extends StatefulWidget {
  const StartView({Key? key}) : super(key: key);

  @override
  State<StartView> createState() => _StartViewState();
}

class _StartViewState extends State<StartView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // Container para a imagem de fundo
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/homiMochila.png"),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: [0.13, 0.5],
            colors: [
              Color.fromARGB(255, 1, 48, 108),
              Color.fromARGB(0, 0, 0, 0),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 0, 0, 10),
              child: SizedBox(
                // width: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      "Bem vindo \nao seu \nHabitat!",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontFamily: 'League Gothic',
                        color: Color.fromARGB(255, 220, 221, 203),
                        fontSize: 35,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ButtonElipse("Partiuu!", () {
              Navigator.of(context).pushNamed('/login');
            }),
            ButtonElipse("Cadastre-se", () {
              Navigator.of(context).pushNamed('/register');
            }, backgroundColor: Color.fromARGB(255, 5, 54, 116), fontColor: Color.fromARGB(255, 255, 255, 255)),
            const SizedBox(height: 25, width: 10)
          ],
        ),
      ),
    );
  }
}
