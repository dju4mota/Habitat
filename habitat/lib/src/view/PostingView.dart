import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habitat/src/utils/utils.dart';
import 'package:habitat/src/widgets/ButtonElipse.dart';

import '../controler/QuestionPostingControl.dart';
import '../models/Content.dart';
import 'package:uuid/uuid.dart';

class PostingView extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final questionController = TextEditingController();

  final control = QuestionPostingControl();
  FirebaseAuth _auth = FirebaseAuth.instance;
  final uuid = Uuid();

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
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).dispose(),
                ),
                ButtonElipse(
                  "Próximo",
                  () {
                    control.question = Content(
                      id: uuid.v4(),
                      title: titleController.text,
                      description: questionController.text,
                      userId: _auth.currentUser!.uid,
                      subject: "",
                    );
                    Navigator.of(context).pushReplacementNamed("/postingPlace");
                  },
                  width: 100,
                  fontSize: 18,
                  backgroundColor: Util.azulEscuroBotao,
                  fontColor: Util.fundoClaro,
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
