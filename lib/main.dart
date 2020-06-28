import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/health_input_form.dart';
import './screens/filter_screen.dart';
import './screens/home_page.dart';
import './screens/food_info.dart';
import './providers/products.dart';

import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import './providers/user_input.dart';
import './providers/filtered_saved_list.dart';
import './screens/scan_screen.dart';

// The following are all the files supporting for Plan For A Diet.
import './plan_for_a_diet/plan_for_a_diet_screens/health_data_input_screen.dart';
import './plan_for_a_diet/plan_for_a_diet_providers/diet_plan_data.dart';
import './plan_for_a_diet/plan_for_a_diet_screens/daily_detail_screen.dart';
import './plan_for_a_diet/plan_for_a_diet_screens/diet_timetable_screen.dart';
import './plan_for_a_diet/plan_for_a_diet_screens/planning_option_screen.dart';
import './plan_for_a_diet/plan_for_a_diet_providers/user_health_data.dart';

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
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    FlutterStatusbarcolor.setNavigationBarColor(Colors.black);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserInput>(builder: (context) => UserInput()),
        ChangeNotifierProvider<Products>(builder: (context) => Products()),
        ChangeNotifierProvider<FilterSavedList>(
            builder: (context) => FilterSavedList()),
        // The following UserHealthData is of the User to set Diet Plan
        // including: Height, Weight, Age, and Exercise Frequency.
        ChangeNotifierProvider<UserHealthData>(
          builder: (context) => UserHealthData(),
        ),
        ChangeNotifierProvider<DietPlanData>(
          builder: (context) => DietPlanData(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.white,
          fontFamily: 'Montserrat',
        ),
        home: HomePage(),
        //Setting route for pages here
        routes: {
          'HomePage': (context) => HomePage(),
          'FilterScreen': (context) => FilterScreen(),
          'HealthInputScreen': (context) => Wrapper(),
          'FoodInfoScreen': (context) => FoodInfo(),

          // The following routes are for Plan For A Diet feature.
          '/health-data-input-screen': (context) => HealthDataInputScreen(),
          '/planning-option-screen': (context) => PlanningOptionScreen(),
          '/diet-timetable-screen': (context) => DietTimetableScreen(),
          '/daily-detail-screen': (context) => DailyDetailScreen(),
          'ScanScreen': (context) => ScanScreen(),
          // 'HealthInput': (context) => InputText().
        },
      ),
    );
  }
}
