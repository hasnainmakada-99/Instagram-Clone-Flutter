import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/Screens/add_post_screen.dart';
import 'package:instagram_clone/Screens/feed_screen.dart';
import 'package:instagram_clone/Screens/profile_screen.dart';
import 'package:instagram_clone/Screens/search_screen.dart';

var homeScreenItems = [
  Center(child: FeedScreen()),
  SearchScreen(),
  AddPostScreen(),
  Center(child: Text('notfications screen')),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
