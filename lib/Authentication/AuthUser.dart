import 'dart:developer';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/Authentication/Storage_Methods.dart';
import '../Models/user_model.dart' as model;

class AuthUser {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = auth.currentUser!;
    DocumentSnapshot snapshot =
        await firestore.collection('users').doc(currentUser.uid).get();
    return model.User.fromSnapshot(snapshot);
  }

  Future<String> userSignUp({
    required String email,
    required String password,
    required String bio,
    required String userName,
    required Uint8List image,
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

        String photoURL = await StorageMethods()
            .uploadImagetoStorage("profilePics", image, false);
        model.User user = model.User(
          userName: userName,
          uid: userId,
          email: email,
          photoURL: photoURL,
          bio: bio,
          followers: [],
          following: [],
        );
        await firestore.collection('users').doc(userId).set(user.toJson());
        res = "Successfull";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = err.code.toString();
      }
    }
    return res;
  }

  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = 'Some Error Occured';

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await auth.signInWithEmailAndPassword(email: email, password: password);
        res = 'Success';
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }
}
