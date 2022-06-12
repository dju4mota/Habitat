import 'package:flutter/material.dart';
import 'package:habitat/src/widgets/ButtonElipse.dart';

class PostingView extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final questionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(children: [
            IconButton(
                onPressed: (() => Navigator.of(context).pop()),
                icon: Icon(Icons.cancel)),
            ButtonElipse("Próximo",
                () => {Navigator.of(context).pushNamed("/postingPlace")})
          ]),
          Form(
            key: formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Image(image: AssetImage("assets/programming2.png")),
                    TextFormField(
                      controller: titleController,
                      decoration:
                          const InputDecoration(hintText: "Escolha um título"),
                    ),
                  ],
                ),
                TextFormField(
                  controller: questionController,
                  decoration:
                      const InputDecoration(hintText: "Descreva sua pergunta"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
