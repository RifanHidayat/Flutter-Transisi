import 'package:flutter/material.dart';
import 'package:transisi/ui/splassScreen.dart';



void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note',
      debugShowCheckedModeBanner: false,
      home: SplassScreen(),
    );
  }
}