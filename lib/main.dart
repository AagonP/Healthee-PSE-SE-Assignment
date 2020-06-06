import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import './screens/filter_screen.dart';
import './screens/home_page.dart';
import './providers/products.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (ctx) => Products(),
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.grey,
          fontFamily: 'Montserrat',
        ),
        home: HomePage(),
        //Setting route for pages here
        routes: {
          'HomePage': (context) => HomePage(),
          'FilterScreen': (context) => FilterScreen(),
          // 'HealthInput': (context) => InputText().
        },
      ),
    );
  }
}
