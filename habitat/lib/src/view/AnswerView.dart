import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:go_router/go_router.dart';
import 'package:habitat/src/controler/ReadController.dart';
import 'package:habitat/src/models/Content.dart';
import 'package:habitat/src/utils/utils.dart';
import 'package:habitat/src/widgets/ButtonElipse.dart';
import 'package:provider/provider.dart';
import 'package:typesense/typesense.dart';

import '../backend/AuthService.dart';
import '../backend/db_firestore.dart';
import '../backend/typeSenseConfig.dart';
import '../models/Answer.dart';
import 'package:uuid/uuid.dart';

class AnswerView extends StatefulWidget {
  @override
  State<AnswerView> createState() => _AnswerViewState();
}

class _AnswerViewState extends State<AnswerView> {
  final formKey = GlobalKey<FormState>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  Client client = TypeSenseInstance().client;
  late FirebaseFirestore db = DBFirestore.get();

  final titleController = TextEditingController();
  final answerController = TextEditingController();
  final ReadController readControl = ReadController();
  final uuid = Uuid();

  postAnswer() {
    createAnswer(context);
    // Navigator.popUntil(context, ModalRoute.withName('/home'));
  }

  createAnswer(BuildContext context) async {
    await db
        .collection("${readControl.path}${readControl.subject.title}/questions/${readControl.question.id}/answers")
        .doc(readControl.answer.id)
        .set({
      '"title"': '"${readControl.answer.title}"',
      '"description"': '"${readControl.answer.description}"',
      '"id"': '"${readControl.answer.id}"',
      '"userId"': '"${readControl.answer.userId}"',
      '"subject"': '"${readControl.question.subject}"',
      '"questionId"': '"${readControl.question.id}"',
    });
    await client.collection("answers").documents.create(
      {
        '"title"': '"${readControl.answer.title}"',
        '"description"': '"${readControl.answer.description}"',
        '"id"': '"${readControl.answer.id}"',
        '"userId"': '"${readControl.answer.userId}"',
        '"subject"': '"${readControl.question.subject}"',
        '"questionId"': '"${readControl.question.id}"',
      },
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Resposta postada com sucesso!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Util.azulClaroFundo,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                ButtonElipse(
                  "Responder",
                  () {
                    readControl.answer = Answer(
                      id: uuid.v4(),
                      title: titleController.text,
                      description: answerController.text,
                      userId: _auth.currentUser!.uid,
                      questionParentId: readControl.question.id,
                      subject: readControl.subject.title,
                    );
                    postAnswer();
                    Navigator.of(context).pop();
                  },
                  width: 100,
                  fontSize: 18,
                  backgroundColor: const Color.fromARGB(255, 5, 54, 116),
                  fontColor: const Color.fromARGB(255, 220, 221, 203),
                ),
              ],
            ),
            Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: titleController,
                        decoration: const InputDecoration(
                          labelText: "Título para sua resposta",
                          labelStyle: TextStyle(fontSize: 20),
                          border: null,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        minLines: 2,
                        maxLines: 15,
                        controller: answerController,
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
