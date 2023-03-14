import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:typesense/typesense.dart';

import '../backend/db_firestore.dart';
import '../backend/typeSenseConfig.dart';
import 'ReadController.dart';

class BDcontroller {
  static final BDcontroller _control = BDcontroller._internal();

  Client client = TypeSenseInstance().client;
  ReadController readController = ReadController();

  late FirebaseFirestore db = DBFirestore.get();
  FirebaseAuth _auth = FirebaseAuth.instance;

  factory BDcontroller() {
    return _control;
  }

  BDcontroller._internal();
}
