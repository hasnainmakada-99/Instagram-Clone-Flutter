import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthUser {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> userSignUp({
    required String email,
    required String password,
    required String bio,
    required String userName,
  }) async {
    String res = 'Some error occured';
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          userName.isNotEmpty ||
          bio.isNotEmpty) {
        UserCredential credential = await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        String userId = credential.user!.uid;
        log(userId);
        await firestore.collection('users').doc(userId).set({
          "email": email,
          "username": userName,
          "uid": userId,
          "bio": bio,
          "following": [],
          "followers": [],
        });
        res = "Successfull";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
