import 'package:habitat/src/models/Question.dart';

class QuestionPostingControl {
  static final QuestionPostingControl _control = QuestionPostingControl._internal();

  late Question question;

  factory QuestionPostingControl() {
    return _control;
  }

  QuestionPostingControl._internal();
}
