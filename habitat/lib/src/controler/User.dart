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

// getUser - busca o usuario no banco de dados Typesense e prenche as variaveis do Singleton
  static getUser() async {
    final searchParametersQuestionID = {
      'q': '\"${_auth.currentUser?.uid}\"',
      'query_by': '"userId"',
    };

    print("getUser");

//  To Do - try catch para se não achar usuario mas ficar tentando
    try {
      Map<String, dynamic> contentMap =
          // await client.collection('users').documents.search(searchParametersQuestionID).timeout(Duration(seconds: 3));
          await client.collection('users').documents.search(searchParametersQuestionID);
      print("teste");
      print("contentMap" + contentMap.toString());

      if (contentMap['hits'].length > 0) {
        name = (contentMap["hits"][0]["document"]['"name"'] as String).replaceAll('"', '');
        email = (contentMap["hits"][0]["document"]['"email"']);
        period = (contentMap["hits"][0]["document"]['"period"']);
      }
    } catch (e) {
      print(e);
      _auth.signOut();
    }
  }
}
