import 'package:flutter/material.dart';
import 'package:habitat/src/backend/AuthService.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  // Function sair;
  // ProfileView(this.sair);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
        onPressed: () => {
          context.read<AuthService>().logout(),
          Navigator.of(context).popUntil((route) => route.isFirst)
        },
        child: const Text("Sair"),
      )),
    );
  }
}
