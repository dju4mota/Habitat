import 'package:habitat/src/models/Content.dart';

class Answer extends Content {
  late String questionParentId;

  Answer({
    required String title,
    required String description,
    required String id,
    required String userId,
    required String subject,
    required String questionParentId,
  }) : super(
          title: title,
          description: description,
          id: id,
          userId: userId,
          subject: subject,
        );
}
