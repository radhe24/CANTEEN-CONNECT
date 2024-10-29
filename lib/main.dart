import 'package:clickncollect/api/api.dart';
import 'package:clickncollect/routes/routerr.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import "package:flutter/services.dart";

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: const FirebaseOptions(
    apiKey:  "AIzaSyDTOgUtlEMWqv4RoWMzl0eaayd0-lvDjSk",
    appId: "1:893219346794:android:7566744c65a04ee866ad13",
    messagingSenderId: "893219346794",
    projectId: "canteen-connect-85f2a"
    ));
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true
  );
  await FirebaseApi().initNotification();
  runApp(const MyApp());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Click and Collect',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/loader',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

