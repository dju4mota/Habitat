import 'package:habitat/src/models/Content.dart';

class QuestionPostingControl {
  static final QuestionPostingControl _control = QuestionPostingControl._internal();

  late Content question;

  factory QuestionPostingControl() {
    return _control;
  }

  QuestionPostingControl._internal();
}
