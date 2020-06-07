import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/health_input_form.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserInput>(builder: (context) => UserInput()),
        ChangeNotifierProvider<Products>(builder: (context) => Products()),
      ],
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
          'HealthInputScreen': (context) => Wrapper(),
          // 'HealthInput': (context) => InputText().
        },
      ),
    );
  }
}
