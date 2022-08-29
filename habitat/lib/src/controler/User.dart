import 'package:firebase_auth/firebase_auth.dart';
import 'package:typesense/typesense.dart';

import '../backend/typeSenseConfig.dart';

class UserDB {
  static final UserDB _UserDB = UserDB._internal();
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static Client client = TypeSenseInstance().client;

  static late String name;
  static late String email;
  static late String UserDBId;
  static late String period;

  factory UserDB() {
    return _UserDB;
  }

  UserDB._internal();

  static getUser() async {
    final searchParametersQuestionID = {
      'q': '\"${_auth.currentUser?.uid}\"',
      'query_by': '"userId"',
    };

    Map<String, dynamic> contentMap = await client.collection('users').documents.search(searchParametersQuestionID);

    name = (contentMap["hits"][0]["document"]['"name"'] as String).replaceAll('"', '');
    email = (contentMap["hits"][0]["document"]['"email"']);
    period = (contentMap["hits"][0]["document"]['"period"']);
  }
}
