import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/features/channel/my_channel/pages/channel_settings.dart';
import 'package:instagram_clone/features/channel/my_channel/pages/my_channel_screen.dart';
import 'package:instagram_clone/features/channel/users_channel/pages/user_channel_page.dart';
import 'package:instagram_clone/features/upload/video_details_page.dart';
import 'package:instagram_clone/home_page.dart';
import 'package:instagram_clone/features/auth/pages/login_page.dart';
import 'package:instagram_clone/features/auth/pages/username_page.dart';
import 'package:instagram_clone/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const LoginPage();
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                final user = FirebaseAuth.instance.currentUser;
                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return UsernamePage(
                      user!.displayName!, user.email!, user.photoURL!);
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return const HomePage();
                }
              },
            );
          }),
    );
  }
}
