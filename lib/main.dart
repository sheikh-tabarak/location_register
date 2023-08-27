import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_system/MainPage.dart';
import 'package:login_system/admin/Login.dart';
import 'package:login_system/admin/Signup.dart';
import 'package:login_system/configurations/SmallText.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double img_height = 200;
  double img_width = 200;
  var isDeviceConnected = false;
  @override
  void initState() {
    super.initState();
    // InternetConnectionStatus.connected;
    for (var i = 1000; i > 200; i--) {
      img_height = i.toDouble();
      img_width = i.toDouble();
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: FirebaseAuth.instance.currentUser == null ||
                    FirebaseAuth.instance.currentUser.isNullOrBlank == true
                ? Signup()
                : MainPage()));
  }
}
