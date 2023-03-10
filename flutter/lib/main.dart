import 'package:flutter/material.dart';
import 'mainscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'teszteszt',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(person: null,),
    );
  }
}
