// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authentication {
  static Future<bool> singnInWithEmail(
      {required String email,
      required String password,
      required BuildContext context}) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      await FirebaseAuth.instance.currentUser!.updateEmail(email);

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('uid', FirebaseAuth.instance.currentUser!.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return newUserSignUp(
            email: email, password: password, context: context);
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Password did not match'),
            behavior: SnackBarBehavior.floating));
      }
      return false;
    }
    return true;
  }

  static Future<bool> newUserSignUp(
      {required String email,
      required String password,
      required BuildContext context}) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await FirebaseAuth.instance.currentUser!.updateEmail(email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Password Provided is too weak'),
          behavior: SnackBarBehavior.floating,
        ));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Email Provided already Exists'),
            behavior: SnackBarBehavior.floating));
      }
      return false;
    } catch (e) {
      print(e.toString());
    }
    return true;
  }

  static Future<bool> signOut() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      auth.signOut();
    } catch (e) {
      print(e.toString());
      return false;
    }
    return true;
  }
}
