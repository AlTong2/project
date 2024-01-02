import 'package:flutter/material.dart';
import 'package:flutter_altong/screen/alt_01_start.dart';
import 'package:flutter_altong/screen/alt_04_main.dart';
import 'package:flutter_altong/screen/alt_09_edit_profile.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/config/.env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print(dotenv.get("TEST"));
    return GetMaterialApp(
      title: 'Flutter Demo',
      routes: {
        '/editProfile' : (context) => ALT09EditProfilePage(),
        '/main': (context) => ALT04Main(),
        '/start' : (context) => ALT01Start(),
      },
      home: ALT01Start(),
    );
  }
}