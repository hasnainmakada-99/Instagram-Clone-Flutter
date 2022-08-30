import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/Authentication/Storage_Methods.dart';
import 'package:instagram_clone/Models/post.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(String description, Uint8List file, String uid,
      String username, String profImage) async {
    String res = 'Some error occured';
    try {
      String photoUrl = await StorageMethods().uploadImagetoStorage(
        'posts',
        file,
        true,
      );
      String postId = const Uuid().v1();
      Post post = Post(
        description: description,
        uid: uid,
        username: username,
        likes: [],
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
        profImage: profImage,
      );
      _firestore.collection('posts').doc(postId).set(post.toJson());
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update(
          {
            'likes': FieldValue.arrayRemove([uid]),
          },
        );
      } else {
        await _firestore.collection('posts').doc(postId).update(
          {
            'likes': FieldValue.arrayUnion([uid]),
          },
        );
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> likeComment(
    String postId,
    String commentId,
    String uid,
    List likes,
  ) async {
    try {
      if (likes.contains(uid)) {
        await _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .update(
          {
            'likes': FieldValue.arrayRemove([uid]),
          },
        );
      } else {
        await _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .update(
          {
            'likes': FieldValue.arrayUnion([uid]),
          },
        );
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> postComment(String postId, String username, String comment,
      String profilePic, String uid) async {
    try {
      if (comment.isNotEmpty) {
        String commentId = Uuid().v1();
        _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set(
          {
            'profilePic': profilePic,
            'username': username,
            'postId': postId,
            'comment': comment,
            'uid': uid,
            'likes': [],
            'commentId': commentId,
            'datePublished': DateTime.now(),
          },
        );
      } else {
        log('Text is Empty, Please make a comment');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deletePost(String postId) async {
    try {
      _firestore.collection('posts').doc(postId).delete();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> followUser(String userId, String followerId) async {
    DocumentSnapshot<Map<String, dynamic>> snap =
        await _firestore.collection('users').doc(userId).get();
    List following = snap.data()!['following'];
    try {
      if (following.contains(followerId)) {
        await _firestore.collection('users').doc(followerId).update({
          'followers': FieldValue.arrayRemove([userId])
        });

        await _firestore.collection('users').doc(userId).update({
          'following': FieldValue.arrayRemove([followerId])
        });
      } else {
        await _firestore.collection('users').doc(followerId).update({
          'followers': FieldValue.arrayUnion([userId])
        });

        await _firestore.collection('users').doc(userId).update({
          'following': FieldValue.arrayUnion([followerId])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
