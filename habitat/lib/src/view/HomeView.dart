import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitat/src/backend/AuthService.dart';
import 'package:provider/provider.dart';

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
          Center(
            child: Container(
              child: Text("We got him!"),
            ),
          ),
          ElevatedButton(
            onPressed: () => context.read<AuthService>().logout(),
            child: Text("Sair"),
          )
        ],
      ),
    );
  }
}
