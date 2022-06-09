import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitat/src/backend/AuthService.dart';
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
      body: Column(
        children: [
          const Text(
            'Olá, USER',
            style: const TextStyle(fontSize: 50),
          ),

          const Text(
            "Como podemos te ajudar hoje para fazer da faculdade e da cidade um perfeito Habitat para você? ",
            style: const TextStyle(fontSize: 20),
          ),
          ElevatedButton(onPressed: () => {}, child: const Text("Faculdade")),
          ElevatedButton(onPressed: () => {}, child: const Text("Cidade")),
          // text Dúvidas e button pesquisa
          Text("Dúvidas"),
          ElevatedButton(
            onPressed: () => {},
            child: Icon(Icons.search),
          ),
          // carrossel com imagens
          Carrossel(),
          // 4 buttons com nagivator
          Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Row(
              children: [
                // 4 buttons
                ElevatedButton(onPressed: () => {}, child: Icon(Icons.home)),
                ElevatedButton(onPressed: () => {}, child: Icon(Icons.search)),
                ElevatedButton(onPressed: () => {}, child: Icon(Icons.add)),
                ElevatedButton(onPressed: () => {}, child: Icon(Icons.person)),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () => context.read<AuthService>().logout(),
            child: const Text("Sair"),
          )
        ],
      ),
    );
  }
}
