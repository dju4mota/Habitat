import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../backend/AuthService.dart';
import '../widgets/ButtonElipse.dart';

class RegisterView extends StatefulWidget {
  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nomeController = TextEditingController();
  final periodoController = TextEditingController();

  bool isLogin = true;

  bool loading = false;

  late String title;

  late String actionButton;

  register() async {
    setState(() => loading = true);
    try {
      await context
          .read<AuthService>()
          .register(emailController.text, passwordController.text);
    } on AuthException catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message)),
      );
    }
  }
  // this.backgroundColor = const Color.fromARGB(255, 220, 221, 203),
  //   this.fontColor = const Color.fromARGB(255, 1, 48, 108),

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 1, 48, 108),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                child: const Icon(Icons.arrow_back,
                    size: 30, color: const Color.fromARGB(255, 220, 221, 203)),
                onPressed: () => {Navigator.of(context).pop()},
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(25.0, 0, 0, 0),
                child: Text("Criar Conta",
                    style: TextStyle(
                      fontSize: 45,
                      color: Color.fromARGB(255, 220, 221, 203),
                    )),
              ),
              Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    formField(
                      nomeController,
                      "Nome",
                      (value) {
                        if (value!.isEmpty) {
                          return 'Informe um nome válido';
                        }
                        return null;
                      },
                      TextInputType.text,
                    ),
                    formField(
                      emailController,
                      "Email institucional INATEL",
                      (value) {
                        if (value!.isEmpty) {
                          return 'Informe o email corretamente';
                        }
                        return null;
                      },
                      TextInputType.emailAddress,
                    ),
                    formField(
                      passwordController,
                      "Senha",
                      (value) {
                        if (value!.isEmpty) {
                          return 'Informe sua senha';
                        } else if (value.length < 8) {
                          return "Sua senha deve ter no mínimo 8 caracteres";
                        }
                        return null;
                      },
                      TextInputType.text,
                      obscure: true,
                    ),
                    formField(
                      periodoController,
                      "Período",
                      (value) {
                        if (value!.isEmpty) {
                          return 'Informe seu período';
                        }
                        return null;
                      },
                      TextInputType.number,
                    ),
                    const SizedBox(height: 150),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ButtonElipse(
                        "Cadastrar",
                        register,
                        backgroundColor:
                            const Color.fromARGB(255, 220, 221, 203),
                        fontColor: const Color.fromARGB(255, 5, 54, 116),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding formField(controller, labelText, validator, keyboardType,
      {obscure = false}) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextFormField(
          obscureText: obscure,
          style: const TextStyle(
            color: Color.fromARGB(255, 220, 221, 203),
          ),
          controller: controller,
          decoration: InputDecoration(
            border: null,
            labelText: labelText,
            labelStyle: TextStyle(
              color: Color.fromARGB(255, 220, 221, 203),
            ),
          ),
          keyboardType: keyboardType,
          validator: validator),
    );
  }
}
