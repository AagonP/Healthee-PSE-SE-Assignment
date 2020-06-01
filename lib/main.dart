import 'package:flutter/material.dart';

import './screens/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.grey,
        fontFamily: 'Montserrat',
        textTheme: TextTheme(
          bodyText1: TextStyle(fontSize: 14.0, fontFamily: 'Montserrat'),
        ),
        iconTheme: IconThemeData(size: 20),
      ),
      home: HomePage(),
    );
  }
}
