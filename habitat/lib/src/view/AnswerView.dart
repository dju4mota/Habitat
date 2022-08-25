import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:habitat/src/controler/ReadController.dart';
import 'package:habitat/src/widgets/ButtonElipse.dart';

import '../backend/db_firestore.dart';
import '../models/Answer.dart';
import 'package:uuid/uuid.dart';

class AnswerView extends StatefulWidget {
  @override
  State<AnswerView> createState() => _AnswerViewState();
}

class _AnswerViewState extends State<AnswerView> {
  final formKey = GlobalKey<FormState>();

  late FirebaseFirestore db = DBFirestore.get();

  final titleController = TextEditingController();
  final answerController = TextEditingController();
  final ReadController readControl = ReadController();
  final uuid = Uuid();

  postAnswer() {
    createAnswer(context);
    // Navigator.popUntil(context, ModalRoute.withName('/home'));
  }

  createAnswer(BuildContext context) {
    db
        .collection(
            "/Faculdade/inatel/subjects/${readControl.subject.title}/questions/${readControl.question.id}/answers")
        .doc(readControl.answer.id)
        .set({
      '"title"': '"${readControl.answer.title}"',
      '"description"': '"${readControl.answer.description}"',
      '"id"': '"${readControl.answer.id}"',
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 220, 221, 203),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                ButtonElipse(
                  "Responder",
                  () {
                    readControl.answer = Answer(
                      id: uuid.v4(),
                      title: titleController.text,
                      description: answerController.text,
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
