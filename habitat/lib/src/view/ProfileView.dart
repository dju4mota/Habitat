// ignore_for_file: prefer_const_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habitat/src/backend/AuthService.dart';
import 'package:habitat/src/backend/db_firestore.dart';
import 'package:habitat/src/backend/typeSenseConfig.dart';
import 'package:habitat/src/controler/ReadController.dart';
import 'package:habitat/src/controler/User.dart';
import 'package:habitat/src/models/Content.dart';
import 'package:habitat/src/widgets/ContentItemList.dart';
import 'package:provider/provider.dart';

import 'package:typesense/typesense.dart';

import '../models/Subjects.dart';
import '../utils/utils.dart';
import '../widgets/ButtonElipse.dart';
import '../widgets/FooterMenu.dart';

class ProfileView extends StatefulWidget {
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  // Function sair;
  Client client = TypeSenseInstance().client;
  ReadController readController = ReadController();

  late FirebaseFirestore db = DBFirestore.get();
  FirebaseAuth _auth = FirebaseAuth.instance;

  List<Content> content = [];

  bool showQuestions = true;
  TextDecoration underlineQuestions = TextDecoration.underline;
  TextDecoration underlineAnswers = TextDecoration.none;
  TextDecoration underlineAbout = TextDecoration.none;

  // Color backgroundColorCollege = Util.azulEscuroBotao;
  // Color backgroundColorCity = Util.fundoClaro;
  // Color backgroundColorQuestion = Util.azulEscuroBotao;
  // Color backgroundColorAnswer = Util.fundoClaro;

  // Color fontColorCollege = Util.fundoClaro;
  // Color fontColorCity = Util.azulEscuroBotao;
  // Color fontColorQuestion = Util.fundoClaro;
  // Color fontColorAnswer = Util.azulEscuroBotao;

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  showQuestion() {
    setState(() {
      showQuestions = !showQuestions;
      underlineQuestions = TextDecoration.underline;
      underlineAnswers = TextDecoration.none;
      underlineAbout = TextDecoration.none;
      search('questions');
    });
  }

  showAnswer() {
    setState(() {
      showQuestions = !showQuestions;
      underlineQuestions = TextDecoration.none;
      underlineAnswers = TextDecoration.underline;
      underlineAbout = TextDecoration.none;
      search('answers');
    });
  }

  showAbout() {
    setState(() {
      showQuestions = !showQuestions;
      underlineQuestions = TextDecoration.none;
      underlineAnswers = TextDecoration.none;
      underlineAbout = TextDecoration.underline;
      search('about');
    });
  }

  // invertePerguntaResposta() {
  //   setState(() {
  //     if (showQuestions) {
  //     } else {}
  //   });
  // }

  final searchParameters = {
    'q': '\"${FirebaseAuth.instance.currentUser!.uid}\"',
    'query_by': '"userId"',
  };

  search(String content) async {
    print("buscando - " + content);
    Map<String, dynamic> contentMap = await client.collection(content).documents.search(searchParameters);

    loadQuestionsList(contentMap["hits"]);
  }

  loadQuestionsList(List contentMap) async {
    setState(() {
      content.clear();
    });

    contentMap.forEach((doc) {
      setState(() {
        content.add(Content(
          title: doc["document"]['"title"'].toString().replaceAll('"', ''),
          id: doc["document"]['"id"'].toString().replaceAll('"', ''),
          description: doc["document"]['"description"'].toString().replaceAll('"', ''),
          userId: doc["document"]['"userId"'].toString().replaceAll('"', ''),
          subject: doc["document"]['"subject"'].toString().replaceAll('"', ''),
        ));
      });
    });
  }

  openQuestion(Content content) async {
    if (!showQuestions) {
      String questionParentId = await getQuestionParentId(content.id);

      final searchParametersQuestionID = {
        'q': '${questionParentId}',
        'query_by': '"id"',
      };

      Map<String, dynamic> contentMap =
          await client.collection('questions').documents.search(searchParametersQuestionID);

      readController.question.id = contentMap["hits"][0]["document"]['"id"'].toString().replaceAll('"', '');
      readController.question.title = contentMap["hits"][0]["document"]['"title"'].toString().replaceAll('"', '');
      readController.question.description =
          contentMap["hits"][0]["document"]['"description"'].toString().replaceAll('"', '');
      readController.question.userId = contentMap["hits"][0]["document"]['"userId"'].toString().replaceAll('"', '');
      readController.question.subject = contentMap["hits"][0]["document"]['"subject"'].toString().replaceAll('"', '');
      readController.subject = Subject(title: readController.question.subject);
      print(readController.subject.title);
      Navigator.of(context).pushNamed('/questionView');
    } else {
      readController.subject = Subject(title: content.subject);
      print(readController.subject.title);
      readController.question = content;
      Navigator.of(context).pushNamed('/questionView');
    }
  }

  deleteQuestion(Content content) async {
    final deleteParameters = {
      'filter_by': '"id": ${content.id}}',
    };
    try {
      if (showQuestions) {
        await client.collection('questions').documents.delete(deleteParameters);
        try {
          await db
              .collection("/Faculdade/inatel/subjects/${content.subject.replaceAll('"', '')}/questions")
              .doc(content.id.replaceAll('"', ''))
              .delete();
        } catch (e) {
          print(e);
        }
        try {
          await db
              .collection("/Cidade/santaRita/subjects/${content.subject.replaceAll('"', '')}/questions")
              .doc(content.id.replaceAll('"', ''))
              .delete();
        } catch (e) {
          print(e);
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Pergunta deletada com sucesso!")),
        );
      } else {
        String questionParentId = await getQuestionParentId(content.id.replaceAll('"', ''));
        await client.collection('answers').documents.delete(deleteParameters);
        try {
          await db
              .collection(
                  "/Faculdade/inatel/subjects/${content.subject.replaceAll('"', '')}/questions/${questionParentId.replaceAll('"', '')}/answers")
              .doc(content.id.replaceAll('"', ''))
              .delete();
        } catch (e) {
          print(e);
        }
        try {
          await db
              .collection(
                  "/Cidade/santaRita/subjects/${content.subject.replaceAll('"', '')}/questions/${questionParentId.replaceAll('"', '')}/answers")
              .doc(content.id.replaceAll('"', ''))
              .delete();
        } catch (e) {
          print(e);
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Resposta deletada com sucesso!")),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> getQuestionParentId(String answerId) async {
    final searchParametersQuestionID = {
      'q': '\"${answerId}\"',
      'query_by': '"id"',
    };

    Map<String, dynamic> contentMap = await client.collection('answers').documents.search(searchParametersQuestionID);

    return (contentMap["hits"][0]["document"]['"questionId"']);
  }

  _ProfileViewState() {
    search('questions');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        // child: Container(
        //   height: 170,
        //   decoration: BoxDecoration(
        //     image: DecorationImage(
        //       image: AssetImage("assets/RectangleBlue.png"),
        //       fit: BoxFit.fitWidth,
        //     ),
        //   ),
        child: Stack(children: [
          Column(
            children: [
              // Container(
              //   decoration: BoxDecoration(
              //     image: DecorationImage(image: ,
              //     fit: BoxFit.cover),
              //   ),
              // ),

              const SizedBox(
                // não sei se funciona para todo celular
                height: 70,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    radius: 65, // Image radius
                    backgroundImage: AssetImage("assets/mamonas-assassinas.jpg"),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(height: 50),
                      IconButton(
                        onPressed: () => {},
                        icon: Icon(
                          Icons.settings,
                          size: 30,
                          color: Util.azulEscuro,
                        ),
                      ),
                      // ButtonElipse(
                      //   "Sair",
                      //   () {
                      //     {
                      //       context.read<AuthService>().logout();
                      //       Navigator.of(context).popUntil((route) => route.isFirst);
                      //     }
                      //   },
                      //   fontSize: 18,
                      //   width: 75,
                      // ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: AutoSizeText(
                          '${UserDB.name}',
                          maxLines: 2,
                          minFontSize: 15,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Inter',
                            color: Util.azulEscuro,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 25),
                decoration: BoxDecoration(
                  border: Border.symmetric(
                    horizontal: BorderSide(
                      color: Util.azulEscuro,
                      width: 2,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: showQuestion,
                      child: Text("Perguntas",
                          style: TextStyle(
                            decoration: underlineQuestions,
                            fontSize: 18,
                            color: Util.azulEscuro,
                          )),
                      style: ButtonStyle(),
                    ),
                    TextButton(
                      onPressed: showAnswer,
                      child: Text("Respostas",
                          style: TextStyle(
                            decoration: underlineAnswers,
                            fontSize: 18,
                            color: Util.azulEscuro,
                          )),
                      style: ButtonStyle(),
                    ),
                    TextButton(
                      onPressed: showAbout,
                      child: Text("Sobre",
                          style: TextStyle(
                            decoration: underlineAbout,
                            fontSize: 18,
                            color: Util.azulEscuro,
                          )),
                      style: ButtonStyle(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.49,
                child: ListView.builder(
                  padding: const EdgeInsets.all(0),
                  itemCount: content.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: ItemList(content[index], openQuestion, [content[index]]),
                    );
                  },
                ),
              ),

              /* SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: ButtonElipse(
                    "Deletar Conta",
                    () {
                      {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Deletar Conta"),
                              content: SizedBox(
                                height: MediaQuery.of(context).size.height * 0.3,
                                child: Column(
                                  children: [
                                    const Text("Confirme suas credenciais para deletar sua conta: "),
                                    TextField(
                                      controller: emailController,
                                      decoration: const InputDecoration(
                                        labelText: "Email",
                                      ),
                                    ),
                                    TextField(
                                      controller: passwordController,
                                      decoration: const InputDecoration(
                                        labelText: "Senha",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text("Cancelar"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
          
                                TextButton(
                                  child: const Text("Deletar"),
                                  onPressed: () async {
                                    try {
                                      await context
                                          .read<AuthService>()
                                          .deleteAccount(emailController.text, passwordController.text);
                                      Navigator.of(context).popUntil((route) => route.isFirst);
                                    } catch (e) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text("Erro ao deletar conta!")),
                                      );
                                    }
                                  },
                                ),
                                
                              ],
                            );
                          },
                        );
                      }
                    },
                    fontSize: 20,
                    backgroundColor: Util.azulEscuroBotao,
                    fontColor: Util.fundoClaro,
                  ),
                ), */
            ],
          ),
          Positioned(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FooterMenu(),
              ],
            ),
            bottom: -15,
          ),
        ]),
      ),
      // ),
    );
  }
}

class ItemList extends StatelessWidget {
  Content content;
  Function openContent;
  // Function deleteContent;
  List<Content> answers = [];

  ItemList(this.content, this.openContent, this.answers);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ContentItemList(content, openContent, answers),
      ],
    );
  }
}
