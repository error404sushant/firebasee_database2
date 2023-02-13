import 'package:firebase_data/home/home_screen.dart';
import 'package:flutter/material.dart';
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/home":(context)=>HomeScreen()
      },
      initialRoute: "/home",
    );

  }
}
