import 'package:flutter/material.dart';
import 'package:habitat/src/backend/AuthService.dart';
import 'package:habitat/src/utils/utils.dart';
import 'package:habitat/src/widgets/ButtonElipse.dart';
import 'package:provider/provider.dart';

import '../controler/User.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLogin = true;
  bool loading = false;
  late String title;
  late String actionButton;

  login() async {
    setState(() => loading = true);
    try {
      bool logado = await context.read<AuthService>().login(emailController.text, passwordController.text);
      if (logado) {
        await UserDB.getUser();
        Navigator.of(context).pushNamed('/home');
      }
    } on AuthException catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message)),
      );
    }
  }

  register() async {
    setState(() => loading = true);
    try {
      await context.read<AuthService>().register(emailController.text, passwordController.text);
    } on AuthException catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Util.azulClaroFundo,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                child: const Icon(Icons.arrow_back, size: 30),
                onPressed: () => {Navigator.of(context).pop()},
              ),
              // ignore: prefer_const_constructors
              Padding(
                padding: const EdgeInsets.fromLTRB(25.0, 0, 0, 0),
                child: const Text("Login", style: TextStyle(fontSize: 45)),
              ),
              const SizedBox(height: 90),
              Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          border: null,
                          labelText: "Email institucional INATEL",
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Informe o email corretamente';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: null,
                          labelText: "Senha",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Informe sua senha';
                          } else if (value.length < 8) {
                            return "Sua senha deve ter no mínimo 8 caracteres";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ButtonElipse(
                        "Login",
                        login,
                        backgroundColor: const Color.fromARGB(255, 5, 54, 116),
                        fontColor: const Color.fromARGB(255, 220, 221, 203),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 200),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Ainda não tem uma conta?"),
                  TextButton(
                      onPressed: () => {
                            Navigator.of(context).pushNamed("/register"),
                          },
                      child: const Text("Cadastre-se"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
