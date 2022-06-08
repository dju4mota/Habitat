import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        child: const Icon(Icons.arrow_back),
        onPressed: () => {Navigator.of(context).pop()},
      ),
    );
  }
}
