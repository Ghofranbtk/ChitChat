import 'package:chitchat/firebase_options.dart';
import 'package:chitchat/screen/signin_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'theme/theme.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  OneSignal.initialize("c4d125f3-5e95-4df1-9fbc-ec1a77b33fe4");
  OneSignal.Notifications.requestPermission(true);

  await FirebaseAppCheck.instance.activate(
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.appAttest,
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
