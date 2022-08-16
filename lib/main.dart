import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/Responsive/mobile_screen_layout.dart';
import 'package:instagram_clone/Responsive/responsive_layout_screen.dart';
import 'package:instagram_clone/Responsive/web_screen_layout.dart';
import 'package:instagram_clone/Screens/login_screen.dart';
import 'package:instagram_clone/Screens/signup_screen.dart';
import 'package:instagram_clone/utilities/colors.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyC96VznuM87chmknpdWZW1Iif6WnBe_R9o',
        appId: '1:117178325821:web:c23f93af0f1c982522c354',
        messagingSenderId: '117178325821',
        projectId: 'instagram-clone-828f7',
        storageBucket: "instagram-clone-828f7.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram Clone Using Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
      // home: const ResponsiveLayout(
      //   webScreenLayout: WebScreenLayout(),
      //   mobileScreenLayout: MobileScreenLayout(),
      // ),
      // home: const LoginScreen(),
      home: const SignupScreen(),
    );
  }
}
