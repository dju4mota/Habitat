import 'package:habitat/src/models/Content.dart';
import 'package:habitat/src/models/Subjects.dart';

import '../models/Answer.dart';

class ReadController {
  static final ReadController _control = ReadController._internal();

  late Subject subject;
  late Content question;
  late Answer answer;

  factory ReadController() {
    return _control;
  }

  ReadController._internal();
}
