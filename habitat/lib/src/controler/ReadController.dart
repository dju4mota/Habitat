import 'package:habitat/src/models/Question.dart';
import 'package:habitat/src/models/Subjects.dart';

class ReadController {
  static final ReadController _control = ReadController._internal();

  late Subject subject;
  late Question question;

  factory ReadController() {
    return _control;
  }

  ReadController._internal();
}
