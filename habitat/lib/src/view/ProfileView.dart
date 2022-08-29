import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habitat/src/backend/AuthService.dart';
import 'package:habitat/src/backend/db_firestore.dart';
import 'package:habitat/src/backend/typeSenseConfig.dart';
import 'package:habitat/src/controler/User.dart';
import 'package:habitat/src/models/Content.dart';
import 'package:habitat/src/widgets/ContentItemList.dart';
import 'package:provider/provider.dart';

import 'package:typesense/typesense.dart';

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

  late FirebaseFirestore db = DBFirestore.get();
  FirebaseAuth _auth = FirebaseAuth.instance;

  List<Content> content = [];

  bool showQuestions = true;
  bool showCollege = true;
  Color backgroundColorCollege = Util.azulEscuroBotao;
  Color backgroundColorCity = Util.fundoClaro;
  Color backgroundColorQuestion = Util.azulEscuroBotao;
  Color backgroundColorAnswer = Util.fundoClaro;

  Color fontColorCollege = Util.fundoClaro;
  Color fontColorCity = Util.azulEscuroBotao;
  Color fontColorQuestion = Util.fundoClaro;
  Color fontColorAnswer = Util.azulEscuroBotao;

  invertePerguntaResposta() {
    setState(() {
      if (showQuestions) {
        showQuestions = !showQuestions;

        backgroundColorQuestion = Util.fundoClaro;
        backgroundColorAnswer = Util.azulEscuroBotao;

        fontColorQuestion = Util.azulEscuroBotao;
        fontColorAnswer = Util.fundoClaro;

        search('answers');
      } else {
        showQuestions = !showQuestions;

        backgroundColorQuestion = Util.azulEscuroBotao;
        backgroundColorAnswer = Util.fundoClaro;

        fontColorQuestion = Util.fundoClaro;
        fontColorAnswer = Util.azulEscuroBotao;

        search('questions');
      }
    });
  }

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
          title: doc["document"]['"title"'],
          id: doc["document"]['"id"'],
          description: doc["document"]['"description"'],
          userId: doc["document"]['"userId"'],
          subject: doc["document"]['"subject"'],
        ));
      });
    });
  }

  deleteQuestion(Content content) async {
    final deleteParameters = {
      'filter_by': '"id": ${content.id}}',
    };
    try {
      if (showQuestions) {
        await client.collection('questions').documents.delete(deleteParameters);
        await db
            .collection("/Faculdade/inatel/subjects/${content.subject.replaceAll('"', '')}/questions")
            .doc(content.id.replaceAll('"', ''))
            .delete();
      } else {
        String questionParentId = await getQuestionParentId(content.id.replaceAll('"', ''));
        await client.collection('answers').documents.delete(deleteParameters);
        await db
            .collection(
                "/Faculdade/inatel/subjects/${content.subject.replaceAll('"', '')}/questions/${questionParentId.replaceAll('"', '')}/answers")
            .doc(content.id.replaceAll('"', ''))
            .delete();
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
      backgroundColor: Util.azulClaroFundo,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              // não sei se funciona para todo celular
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          '${UserDB.name}',
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Inter',
                            color: Color.fromARGB(255, 5, 54, 116),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: ButtonElipse(
                          "Sair",
                          () {
                            {
                              context.read<AuthService>().logout();
                              Navigator.of(context).popUntil((route) => route.isFirst);
                            }
                          },
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonElipse(
                  "Faculdade",
                  () => {},
                  fontSize: 20,
                  width: 150,
                  backgroundColor: Util.azulEscuroBotao,
                  fontColor: Util.fundoClaro,
                ),
                ButtonElipse("Cidade", () => {}, fontSize: 20, width: 150),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonElipse(
                  "Perguntas",
                  invertePerguntaResposta,
                  fontSize: 20,
                  width: 150,
                  backgroundColor: backgroundColorQuestion,
                  fontColor: fontColorQuestion,
                ),
                ButtonElipse(
                  "Respostas",
                  invertePerguntaResposta,
                  fontSize: 20,
                  width: 150,
                  backgroundColor: backgroundColorAnswer,
                  fontColor: fontColorAnswer,
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.55,
              child: ListView.builder(
                padding: EdgeInsets.all(0),
                itemCount: content.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: ItemList(content[index], () => {}, deleteQuestion),
                  );
                },
              ),
            ),
            FooterMenu()
          ],
        ),
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  Content content;
  Function openContent;
  Function deleteContent;

  ItemList(this.content, this.openContent, this.deleteContent);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ContentItemList(content, openContent, deleteContent),
      ],
    );
  }
}
