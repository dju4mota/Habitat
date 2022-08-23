import 'package:habitat/src/models/Question.dart';
import 'package:habitat/src/models/Subjects.dart';

import '../models/Answer.dart';

class ReadController {
  static final ReadController _control = ReadController._internal();

  late Subject subject;
  late Question question;
  late Answer answer;

  factory ReadController() {
    return _control;
  }

  ReadController._internal();
}
