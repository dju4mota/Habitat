import 'package:flutter/material.dart';
import 'package:habitat/src/backend/AuthService.dart';
import 'package:habitat/src/view/HomeView.dart';
import 'package:habitat/src/view/StartView.dart';
import 'package:provider/provider.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  _AuthCheckState createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);

    // return StartView();

    try {
      if (auth.isLoading) {
        return loading();
      } else if (auth.usuario == null) {
        print("usuario nulo");
        return const StartView();
      } else {
        print("usuario logado");
        print(auth.usuario?.email);

        return HomeView();
      }
    } catch (e) {
      print(e);
      return const StartView();
    }
  }

  loading() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
