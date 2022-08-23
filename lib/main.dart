import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:instagram_clone/Responsive/mobile_screen_layout.dart';
import 'package:instagram_clone/Responsive/responsive_layout_screen.dart';
import 'package:instagram_clone/Responsive/web_screen_layout.dart';
import 'package:instagram_clone/Screens/login_screen.dart';
import 'package:instagram_clone/Screens/signup_screen.dart';
import 'package:instagram_clone/Utilities/colors.dart';
import 'package:instagram_clone/Utilities/routes.dart';

import 'package:instagram_clone/providers/user_provider.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        routes: {
          loginScreen: (context) => const LoginScreen(),
          signupScreen: (context) => const SignupScreen(),
        },
        title: 'Instagram Clone Using Flutter',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark()
            .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            // Connection to the future has been made
            if (snapshot.connectionState == ConnectionState.active) {
              // means the snapshot has the user data
              if (snapshot.hasData) {
                return const ResponsiveLayout(
                  webScreenLayout: WebScreenLayout(),
                  mobileScreenLayout: MobileScreenLayout(),
                );
              }
              // otherwise the snapshot contains error while authenticating
              if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            // means the connection to the future has still not be made
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }
            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
