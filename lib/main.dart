import 'package:chitchat/firebase_options.dart';
import 'package:chitchat/screen/home_pages.dart';
import 'package:chitchat/screen/signin_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ISI Chat',
      theme: TAppTheme.mobileTheme,
      home: SigninPage(),
    );
  }
}
