import 'package:flutter/material.dart';
import 'package:instagram_clone/Screens/add_post_screen.dart';
import 'package:instagram_clone/Screens/feed_screen.dart';

const homeScreenItems = [
  Center(child: FeedScreen()),
  Center(child: Text('search screen')),
  AddPostScreen(),
  Center(child: Text('notfications screen')),
  Center(child: Text('profile screen')),
];
