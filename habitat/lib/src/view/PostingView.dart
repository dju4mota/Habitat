import 'package:flutter/material.dart';
import 'package:habitat/src/widgets/ButtonElipse.dart';

import '../controler/QuestionPostingControl.dart';
import '../models/Question.dart';
import 'package:uuid/uuid.dart';

class PostingView extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final questionController = TextEditingController();

  final control = QuestionPostingControl();
  final uuid = Uuid();

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
                  "Próximo",
                  () {
                    control.question = Question(
                      id: uuid.v4(),
                      title: titleController.text,
                      description: questionController.text,
                    );
                    Navigator.of(context).pushNamed("/postingPlace");
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
                          labelText: "Título para sua pergunta",
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
                        controller: questionController,
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
