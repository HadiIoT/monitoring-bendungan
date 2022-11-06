import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import './pages/page_satu.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> Fire = Firebase.initializeApp();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.light,
          appBarTheme: AppBarTheme(
            color: Color(0xFF21325E),
          ),
          textTheme: TextTheme(
            bodyText2:
                TextStyle(color: Color(0xFFF0F0F0), fontFamily: 'Poppins'),
          )),
      home: FutureBuilder(
          future: Fire,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print('${snapshot.error.toString()}');
              return Text("Error");
            } else if (snapshot.hasData) {
              return PageSatu();
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
