import 'package:cloud_firestore/cloud_firestore.dart';

class DBFirestore {
  // Singleton
  DBFirestore._(); // privado
  static final DBFirestore _instace = DBFirestore._();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// Cria uma instância única da Classe
  static FirebaseFirestore get() {
    return DBFirestore._instace._firestore;
  }
}
