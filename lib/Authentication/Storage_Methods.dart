import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<String> uploadImagetoStorage(
      String childname, Uint8List file, bool isPost) async {
    // For creating a folder named by the user (Profilepics, Post)
    Reference reference =
        await storage.ref().child(childname).child(auth.currentUser!.uid);

    // Uploading the actual file
    UploadTask uploadTask = reference.putData(file);
    // Waiting for the file to get uploaded to firebase storage
    TaskSnapshot snapshot = await uploadTask;
    // getting the download url from the actual uploaded file
    String downloadUrl = await snapshot.ref.getDownloadURL();
    // returning the downloaded url
    return downloadUrl;
  }
}
