import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/model.dart';

class FirestoreService {
  static Future<void> addData({required BuildContext context, required SettingsModel model}) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final String uid = auth.currentUser!.uid;
    final FirebaseFirestore db = FirebaseFirestore.instance;

    try {
      await db.collection("Users").doc(uid).set(model.toJson()); 
    } catch (e) {
      print(e);
    }
  }

  static Future<SettingsModel?> fetchData({required BuildContext context}) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final String uid = auth.currentUser!.uid;
    final FirebaseFirestore db = FirebaseFirestore.instance;

    try {
      final DocumentSnapshot<Map<String, dynamic>> snapshot = await db.collection("Users").doc(uid).get();
      final docs = snapshot.data()!;
      return SettingsModel.fromJson(docs);
    } catch (e) {
      print(e);
    }
    return null;
  }
}