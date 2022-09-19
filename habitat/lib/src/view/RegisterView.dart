import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:typesense/typesense.dart';

import '../backend/AuthService.dart';
import '../backend/db_firestore.dart';
import '../backend/typeSenseConfig.dart';
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
  bool aceitouTermos = false;
  bool mostrarTermos = false;

  bool loading = false;

  late String title;

  late String actionButton;
  FirebaseAuth _auth = FirebaseAuth.instance;
  Client client = TypeSenseInstance().client;
  late FirebaseFirestore db = DBFirestore.get();

  saveUserInDB(BuildContext context) async {
    print("salvando");
    await db.collection("/Users").doc(_auth.currentUser?.uid).set({
      '"userId"': '"${_auth.currentUser?.uid}"',
      '"email"': '"${emailController.text}"',
      '"name"': '"${nomeController.text}"',
      '"period"': '"${periodoController.text}"',
    });
    await client.collection("users").documents.create(
      {
        '"userId"': '"${_auth.currentUser?.uid}"',
        '"email"': '"${emailController.text}"',
        '"name"': '"${nomeController.text}"',
        '"period"': '"${periodoController.text}"',
      },
    );
    print("salvado");
  }

  register() async {
    if (aceitouTermos) {
      setState(() => loading = true);
      try {
        await context.read<AuthService>().register(
              emailController.text,
              passwordController.text,
            );
        await saveUserInDB(context);
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Cadastro realizado com sucesso!")),
        );
      } on AuthException catch (e) {
        setState(() => loading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message)),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Você precisa aceitar os termos!")),
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
                child: const Icon(Icons.arrow_back, size: 30, color: const Color.fromARGB(255, 220, 221, 203)),
                onPressed: () => {
                  Navigator.of(context).pop(),
                },
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
                      "Nome Social",
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
                    Row(
                      children: [
                        Checkbox(
                          value: aceitouTermos,
                          onChanged: (value) => setState(() => aceitouTermos = value!),
                        ),
                        const Text(
                          "Li e aceito os termos de uso",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 220, 221, 203),
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                        onPressed: () => setState(() => mostrarTermos = !mostrarTermos),
                        child: const Text(
                          "Termos de uso",
                          style: TextStyle(color: Colors.blue),
                        )),
                    if (mostrarTermos)
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '''   Você está adquirindo o aplicativo “Habitat”, com ele você poderá tirar suas dúvidas sobre matérias da sua universidade e também da cidade, assim como ver perguntas e respostas de outros usuários, para assim, ajudar no seu desenvolvimento acadêmico e afins.
    
    Dessa forma, para ter-se o melhor habitat digital, deve-se lembrar que é responsabilidade do usuários:
    1.  a correta utilização da plataforma, prezando pela boa convivência, pelo respeito e cordialidade entre os usuários, qualquer tipo de preconceito levará a banimento imediato.
    2.  pela proteção aos dados de acesso à sua conta/perfil (login/senha).
	  
    Assim como é responsabilidade da plataforma:
    1.  as informações que foram por ela divulgadas, sendo que os comentários ou informações divulgadas por usuários são de inteira responsabilidade dos próprios usuários, ou seja, todas as opiniões expressadas nos comentários deste aplicativo não expressam a opinião dos criadores, mas tão somente a opinião de quem os escreveu.
	  
    A plataforma não se responsabiliza por links externos contidos em seu sistema que possam redirecionar o usuário à ambiente externo a sua rede.

	  Toda a estrutura do aplicativo, as marcas, logotipos, nomes comerciais, layouts, gráficos e design de interface, imagens, ilustrações, fotografias, apresentações, vídeos, conteúdos escritos e de som e áudio e quaisquer outras informações e direitos de propriedade intelectual, observados os termos da Lei de Propriedade Industrial, Lei de Direitos Autorais e Lei de Software, estão devidamente reservados.

	  Sem prejuízo das demais medidas legais cabíveis, a qualquer momento, o usuário poderá ser advertido, suspenso ou ter a conta banida se:
    1.  descumprir seus deveres de usuário;
    2.  tiver qualquer comportamento fraudulento, doloso ou que ofenda terceiros.
    
    Você pode rescindir este Termos a qualquer momento e por qualquer motivo, excluindo sua Conta e interrompendo o uso de todos os Serviços.
''',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ButtonElipse(
                        "Cadastrar",
                        register,
                        backgroundColor: const Color.fromARGB(255, 220, 221, 203),
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

  Padding formField(controller, labelText, validator, keyboardType, {obscure = false}) {
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
            labelStyle: const TextStyle(
              color: Color.fromARGB(255, 220, 221, 203),
            ),
          ),
          keyboardType: keyboardType,
          validator: validator),
    );
  }
}
